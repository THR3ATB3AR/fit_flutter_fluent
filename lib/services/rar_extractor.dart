import 'dart:async';
import 'dart:io'; 
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p; 

enum ExtractionStatus {
  idle,
  queued,
  extracting,
  completed,
  failed,
  noRarFound,
  sevenZipNotFound,
  installing, 
  installationSucceeded, 
  installationFailed, 
  setupExeNotFound, 
}

class ExtractionProgress {
  final String groupTitle;
  final ExtractionStatus status;
  final String?
  message; 

  ExtractionProgress(this.groupTitle, this.status, {this.message});

  @override
  String toString() {
    return 'ExtractionProgress(groupTitle: $groupTitle, status: $status, message: $message)';
  }
}

class RarExtractor {
  final String sevenZipPath; 

  final StreamController<ExtractionProgress> _extractionProgressController =
      StreamController<ExtractionProgress>.broadcast();
  Stream<ExtractionProgress> get onExtractionProgress =>
      _extractionProgressController.stream;

  final Map<String, ExtractionStatus> _groupExtractionStatus = {};
  final List<Map<String, dynamic>> _extractionQueue = [];
  bool _isProcessingQueue = false;
  bool _sevenZipVerified = false;

  RarExtractor({required this.sevenZipPath});

  Future<bool> _verifySevenZipPath() async {
    if (_sevenZipVerified) return true;
    if (sevenZipPath.isEmpty) {
      debugPrint("RarExtractor: 7-Zip path is empty.");
      return false;
    }
    try {
      final result = await Process.run(sevenZipPath, ['i']);
      if (result.exitCode == 0 ||
          result.stdout.toString().toLowerCase().contains("7-zip")) {
        debugPrint(
          "RarExtractor: 7-Zip found at '$sevenZipPath' and verified.",
        );
        _sevenZipVerified = true;
        return true;
      } else {
        debugPrint(
          "RarExtractor: Command '$sevenZipPath i' failed. Exit: ${result.exitCode}, Stderr: ${result.stderr}",
        );
        return false;
      }
    } catch (e) {
      debugPrint(
        "RarExtractor: Failed to run 7-Zip from '$sevenZipPath'. Error: $e",
      );
      return false;
    }
  }

  Future<void> scheduleExtraction({
    required String groupTitle,
    required String downloadFolderPath,
    required List<Map<String, dynamic>> filesInGroup,
    required bool performAutoInstall, 
    required String installPath,      
  }) async {
    if (_groupExtractionStatus[groupTitle] == ExtractionStatus.extracting ||
        _groupExtractionStatus[groupTitle] == ExtractionStatus.queued ||
        _groupExtractionStatus[groupTitle] == ExtractionStatus.completed ||
        _groupExtractionStatus[groupTitle] == ExtractionStatus.installing ||
        _groupExtractionStatus[groupTitle] == ExtractionStatus.installationSucceeded) {
      debugPrint(
        "RarExtractor: Extraction/Installation for group '$groupTitle' already handled or in progress. Skipping.",
      );
      return;
    }

    if (!_sevenZipVerified && !await _verifySevenZipPath()) {
      debugPrint(
        "RarExtractor: 7-Zip not found/working at '$sevenZipPath'. Cannot schedule '$groupTitle'.",
      );
      _updateGroupStatus(
        groupTitle,
        ExtractionStatus.sevenZipNotFound,
        message: "7-Zip not found at $sevenZipPath",
      );
      return;
    }

    _extractionQueue.add({
      'groupTitle': groupTitle,
      'downloadFolderPath': downloadFolderPath,
      'filesInGroup': filesInGroup,
      'performAutoInstall': performAutoInstall, 
      'installPath': installPath,
    });
    _updateGroupStatus(groupTitle, ExtractionStatus.queued);
    debugPrint(
        "RarExtractor: Group '$groupTitle' queued for extraction. Auto-install: $performAutoInstall, Install Path: '$installPath'");
    _processExtractionQueue();
  }

  void _updateGroupStatus(
    String groupTitle,
    ExtractionStatus status, {
    String? message,
  }) {
    _groupExtractionStatus[groupTitle] = status;
    _extractionProgressController.add(
      ExtractionProgress(groupTitle, status, message: message),
    );
  }

  void _finishProcessingJob() {
    _isProcessingQueue = false;
    _processExtractionQueue(); 
  }

  Future<void> _processExtractionQueue() async {
    if (_isProcessingQueue || _extractionQueue.isEmpty) {
      return;
    }
    _isProcessingQueue = true;

    final job = _extractionQueue.removeAt(0);
    final String groupTitle = job['groupTitle'];
    final String downloadFolderPath = job['downloadFolderPath'];
    final List<Map<String, dynamic>> filesInGroup = job['filesInGroup'];
    final bool performAutoInstall = job['performAutoInstall'] as bool; 
    final String installPath = job['installPath'] as String;

    debugPrint(
      "RarExtractor: Starting extraction process for group '$groupTitle'. Perform auto-install: $performAutoInstall",
    );
    _updateGroupStatus(
      groupTitle,
      ExtractionStatus.extracting,
      message: "Preparing to extract archives...",
    );

    try {
      if (!_sevenZipVerified) {
        _updateGroupStatus(
          groupTitle,
          ExtractionStatus.sevenZipNotFound,
          message: "7-Zip became unverified.",
        );
        _finishProcessingJob();
        return;
      }

      final List<String> primaryRarParts = _findAllPrimaryRarParts(
        filesInGroup,
      );

      if (primaryRarParts.isEmpty) {
        debugPrint(
          "RarExtractor: No suitable primary RAR files found in group '$groupTitle'.",
        );
        _updateGroupStatus(
          groupTitle,
          ExtractionStatus.noRarFound,
          message: "No primary RAR parts identified in the group.",
        );
        _finishProcessingJob();
        return;
      }

      debugPrint(
        "RarExtractor: Found ${primaryRarParts.length} primary RAR part(s) for group '$groupTitle': $primaryRarParts",
      );

      bool allExtractionsSuccessful = true;
      List<String> errorMessages = [];
      int extractedCount = 0;

      for (String primaryRarPartName in primaryRarParts) {
        _updateGroupStatus(
          groupTitle,
          ExtractionStatus.extracting,
          message:
              "Extracting archive: $primaryRarPartName (${extractedCount + 1} of ${primaryRarParts.length})...",
        );

        final String rarFullPath = p.join(
          downloadFolderPath,
          primaryRarPartName,
        );
        if (!await File(rarFullPath).exists()) {
          final msg = "File not found: $primaryRarPartName";
          debugPrint("RarExtractor: Error - $msg for group '$groupTitle'.");
          errorMessages.add(msg);
          allExtractionsSuccessful = false;
          continue;
        }

        final String outputDirectory = downloadFolderPath;
        await Directory(outputDirectory).create(recursive: true);

        debugPrint(
          "RarExtractor: Extracting '$rarFullPath' to '$outputDirectory' for group '$groupTitle'.",
        );
        final ProcessResult result = await Process.run(
          sevenZipPath,
          [
            'x',
            rarFullPath,
            '-o$outputDirectory',
            '-y',
            '-bsp1',
          ], 
          workingDirectory: downloadFolderPath,
        );

        if (result.exitCode == 0) {
          debugPrint(
            "RarExtractor: Successfully extracted '$primaryRarPartName' for group '$groupTitle'.",
          );
          if (result.stdout.toString().isNotEmpty) {
            debugPrint(
              "7-Zip stdout for $primaryRarPartName: ${result.stdout}",
            );
          }
          extractedCount++;
        } else {
          String errorMessage =
              "Failed to extract '$primaryRarPartName' (Code: ${result.exitCode}).";
          if (result.stderr.toString().isNotEmpty) {
            errorMessage += " Stderr: ${result.stderr}";
          }
          if (result.stdout.toString().isNotEmpty &&
              result.stderr.toString().isEmpty) {
            errorMessage += " Stdout: ${result.stdout}";
          }
          debugPrint("RarExtractor: $errorMessage");
          errorMessages.add(errorMessage);
          allExtractionsSuccessful = false;
        }
      } 

      if (allExtractionsSuccessful) {
        _updateGroupStatus(
          groupTitle,
          ExtractionStatus.completed,
          message:
              "All $extractedCount archive(s) in group extracted successfully.",
        );

        if (performAutoInstall) {
            await _attemptAutoInstall(groupTitle, downloadFolderPath, installPath);
        }
      } else {
        _updateGroupStatus(
          groupTitle,
          ExtractionStatus.failed,
          message:
              "Extraction failed for one or more archives. $extractedCount of ${primaryRarParts.length} succeeded. Errors: ${errorMessages.join('; ')}",
        );
      }
    } catch (e, s) {
      debugPrint(
        "RarExtractor: Exception during extraction for group '$groupTitle': $e\n$s",
      );
      _updateGroupStatus(
        groupTitle,
        ExtractionStatus.failed,
        message: "Unhandled exception during extraction: $e",
      );
    } finally {
      _finishProcessingJob();
    }
  }

  Future<void> _attemptAutoInstall(
    String groupTitle,
    String extractedFilesPath, 
    String targetInstallDir,   
  ) async {
    final setupExePath = p.join(extractedFilesPath, 'setup.exe');
    final setupExeFile = File(setupExePath);

    if (!await setupExeFile.exists()) {
      debugPrint(
          "RarExtractor: setup.exe not found in '$extractedFilesPath' for group '$groupTitle'. Installation skipped.");
      _updateGroupStatus(
        groupTitle,
        ExtractionStatus.setupExeNotFound,
        message: "setup.exe not found in extracted files. Installation cannot proceed.",
      );
      return;
    }

    debugPrint(
        "RarExtractor: Found setup.exe at '$setupExePath'. Attempting installation for group '$groupTitle' to '$targetInstallDir'.");
    _updateGroupStatus(
      groupTitle,
      ExtractionStatus.installing,
      message: "Starting setup.exe...",
    );

    try {
      final String logFileName = 'setup_install.log';
      final List<String> setupArguments = [
        '/LOG="$logFileName"', 
        '/VERYSILENT',
      ];

      if (targetInstallDir.isNotEmpty) {
        setupArguments.add('/DIR="$targetInstallDir"');
      }

      ProcessResult result;

      if (Platform.isWindows) {
        String psSetupExePath = setupExePath.replaceAll("'", "''"); 

        String psArgumentListString = setupArguments.map((arg) {
          return arg.replaceAll("'", "''");
        }).join(' ');

        String powerShellCommand = "Start-Process -FilePath '$psSetupExePath' -ArgumentList '$psArgumentListString' -Verb RunAs -Wait -PassThru";

        debugPrint(
            "RarExtractor: Running elevated command via PowerShell: powershell.exe -NoProfile -NonInteractive -Command \"$powerShellCommand\"");
        
        result = await Process.run(
          'powershell.exe',
          [
            "-NoProfile",
            "-NonInteractive",
            "-Command",
            powerShellCommand,
          ],
          workingDirectory: extractedFilesPath, 
        );
      } else {
        debugPrint(
            "RarExtractor: Running command directly (non-Windows or fallback): \"$setupExePath\" ${setupArguments.join(' ')}");
        result = await Process.run(
          setupExePath,
          setupArguments,
          workingDirectory: extractedFilesPath,
        );
      }

      if (result.exitCode == 0) {
        debugPrint(
            "RarExtractor: setup.exe for group '$groupTitle' command completed. Assuming success. Exit code: ${result.exitCode}");
        if (result.stdout.toString().isNotEmpty) {
          debugPrint("Setup/PowerShell stdout: ${result.stdout}");
        }
        if (result.stderr.toString().isNotEmpty) {
          debugPrint("Setup/PowerShell stderr: ${result.stderr}");
        }
        _updateGroupStatus(
          groupTitle,
          ExtractionStatus.installationSucceeded,
          message: "Installation completed successfully.",
        );
      } else {
        String errorMessage =
            "setup.exe for group '$groupTitle' failed or was cancelled. Exit code: ${result.exitCode}.";
        if (result.stdout.toString().isNotEmpty) {
          errorMessage += " Stdout: ${result.stdout}";
        }
        if (result.stderr.toString().isNotEmpty) {
          errorMessage += " Stderr: ${result.stderr}";
          if (result.stderr.toString().toLowerCase().contains("operation was canceled by the user")) {
            errorMessage = "Installation for group '$groupTitle' was cancelled by the user (UAC prompt). Exit code: ${result.exitCode}. Stderr: ${result.stderr}";
          }
        }
        debugPrint("RarExtractor: $errorMessage");
        _updateGroupStatus(
          groupTitle,
          ExtractionStatus.installationFailed,
          message: errorMessage,
        );
      }
    } catch (e, s) {
      debugPrint(
          "RarExtractor: Exception running/orchestrating setup.exe for group '$groupTitle': $e\n$s");
      _updateGroupStatus(
        groupTitle,
        ExtractionStatus.installationFailed,
        message: "Exception during installation: $e",
      );
    }
  }

  List<String> _findAllPrimaryRarParts(
    List<Map<String, dynamic>> filesInGroupMap,
  ) {
    final List<String> allFileNames =
        filesInGroupMap.map((f) => f['fileName'] as String).toList();
    allFileNames.sort(); 

    final Map<String, List<String>> potentialArchiveSets = {};

    for (final fileName in allFileNames) {
      String? baseName;
      Match? match;

      match = RegExp(
        r"^(.*?)\.part\d+\.rar$",
        caseSensitive: false,
      ).firstMatch(fileName);
      if (match != null) {
        baseName = match.group(1);
      } else {
        match = RegExp(
          r"^(.*?)\.r\d{2}$",
          caseSensitive: false,
        ).firstMatch(fileName);
        if (match != null) {
          baseName = match.group(1);
        } else {
          match = RegExp(
            r"^(.*?)\.(\d{3,})$",
            caseSensitive: false,
          ).firstMatch(fileName);
          if (match != null && int.tryParse(match.group(2)!) != null) {
            baseName = match.group(1);
          } else {
            if (fileName.toLowerCase().endsWith('.rar')) {
              baseName = p.basenameWithoutExtension(fileName);
            }
          }
        }
      }

      if (baseName != null && baseName.isNotEmpty) {
        potentialArchiveSets.putIfAbsent(baseName, () => []).add(fileName);
      } else if (fileName.toLowerCase().endsWith('.rar')) {
        String derivedBase = p.basenameWithoutExtension(fileName);
        potentialArchiveSets.putIfAbsent(derivedBase, () => []).add(fileName);
      }
    }

    debugPrint(
      "RarExtractor: Potential archive sets identified: $potentialArchiveSets",
    );
    final Set<String> primaryParts = {};

    for (final entry in potentialArchiveSets.entries) {
      final String currentBaseName = entry.key;
      final List<String> setFileNames = List.from(entry.value)
        ..sort(); 

      String? chosenPrimaryPart;

      chosenPrimaryPart = setFileNames.firstWhere(
        (name) =>
            RegExp(r'\.part0*1\.rar$', caseSensitive: false).hasMatch(name),
        orElse: () => "",
      );
      if (chosenPrimaryPart.isNotEmpty) {
        primaryParts.add(chosenPrimaryPart);
        debugPrint(
          "RarExtractor(_findAllPrimaryRarParts): Base '$currentBaseName', Rule 1 -> $chosenPrimaryPart",
        );
        continue; 
      }

      String? baseRarFile = setFileNames.firstWhere(
        (fn) => fn.toLowerCase() == "$currentBaseName.rar".toLowerCase(),
        orElse: () => "",
      );
      if (baseRarFile.isNotEmpty) {
        bool hasRxxSequence = setFileNames.any(
          (fn) =>
              fn.toLowerCase().startsWith(
                "${currentBaseName.toLowerCase()}.",
              ) &&
              RegExp(r'\.r\d{2}$', caseSensitive: false).hasMatch(fn) &&
              fn.toLowerCase() != baseRarFile.toLowerCase(),
        );
        bool hasNumericSequence = setFileNames.any(
          (fn) =>
              fn.toLowerCase().startsWith(
                "${currentBaseName.toLowerCase()}.",
              ) &&
              RegExp(r'\.\d{3,}$', caseSensitive: false).hasMatch(fn) &&
              int.tryParse(p.extension(fn).substring(1)) !=
                  null && 
              fn.toLowerCase() != baseRarFile.toLowerCase(),
        );

        if (hasRxxSequence || hasNumericSequence) {
          primaryParts.add(baseRarFile);
          debugPrint(
            "RarExtractor(_findAllPrimaryRarParts): Base '$currentBaseName', Rule 2 -> $baseRarFile",
          );
          continue;
        }
      }

      chosenPrimaryPart = setFileNames.firstWhere(
        (name) => RegExp(r'\.r01$', caseSensitive: false).hasMatch(name),
        orElse: () => "",
      );
      if (chosenPrimaryPart.isNotEmpty) {
        primaryParts.add(chosenPrimaryPart);
        debugPrint(
          "RarExtractor(_findAllPrimaryRarParts): Base '$currentBaseName', Rule 3 -> $chosenPrimaryPart",
        );
        continue;
      }

      chosenPrimaryPart = setFileNames.firstWhere(
        (name) => RegExp(
          r'\.001$',
          caseSensitive: false,
        ).hasMatch(name), 
        orElse: () => "",
      );
      if (chosenPrimaryPart.isNotEmpty) {
        primaryParts.add(chosenPrimaryPart);
        debugPrint(
          "RarExtractor(_findAllPrimaryRarParts): Base '$currentBaseName', Rule 4 -> $chosenPrimaryPart",
        );
        continue;
      }

      chosenPrimaryPart = setFileNames.firstWhere(
        (name) => RegExp(r'\.r00$', caseSensitive: false).hasMatch(name),
        orElse: () => "",
      );
      if (chosenPrimaryPart.isNotEmpty) {
        bool hasOtherRxx = setFileNames.any(
          (fn) =>
              fn.toLowerCase().startsWith(
                "${currentBaseName.toLowerCase()}.",
              ) &&
              RegExp(r'\.r\d{2}$', caseSensitive: false).hasMatch(fn) &&
              fn.toLowerCase() != chosenPrimaryPart!.toLowerCase(),
        );
        if (hasOtherRxx) {
          primaryParts.add(chosenPrimaryPart);
          debugPrint(
            "RarExtractor(_findAllPrimaryRarParts): Base '$currentBaseName', Rule 5 -> $chosenPrimaryPart",
          );
          continue;
        }
      }

      if (baseRarFile.isNotEmpty) {
        primaryParts.add(baseRarFile);
        debugPrint(
          "RarExtractor(_findAllPrimaryRarParts): Base '$currentBaseName', Rule 6 (standalone .rar) -> $baseRarFile",
        );
        continue;
      }

      if (chosenPrimaryPart.isEmpty) {
        debugPrint(
          "RarExtractor(_findAllPrimaryRarParts): No primary part identified for base '$currentBaseName' with files: $setFileNames using defined rules.",
        );
      }
    }
    return primaryParts.toList()..sort(); 
  }

  ExtractionStatus? getGroupExtractionStatus(String groupTitle) {
    return _groupExtractionStatus[groupTitle];
  }

  void dispose() {
    _extractionProgressController.close();
    _extractionQueue.clear();
    _groupExtractionStatus.clear();
    debugPrint("RarExtractor: Disposed.");
  }
}
