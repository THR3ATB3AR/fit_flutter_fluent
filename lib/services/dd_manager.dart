import 'dart:async';
import 'dart:io';
import 'package:fit_flutter_fluent/data/download_info.dart';
import 'package:fit_flutter_fluent/services/rar_extractor.dart';
import 'package:flutter_download_manager/flutter_download_manager.dart'
    show DownloadManager, DownloadTask, DownloadStatus;
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

class DdManager {
  final DownloadManager downloadManager = DownloadManager();
  final RarExtractor rarExtractor;
  bool? autoInstall;

  final StreamController<String> _taskGroupUpdatedController =
      StreamController<String>.broadcast();
  Stream<String> get onTaskGroupUpdated => _taskGroupUpdatedController.stream;

  DdManager._privateConstructor()
    : rarExtractor = RarExtractor(sevenZipPath: _getPlatformSpecific7ZipPath());

  Map<String, List<Map<String, dynamic>>> downloadTasks = {};
  static final DdManager _instance = DdManager._privateConstructor();
  static DdManager get instance => _instance;

  final ValueNotifier<bool> isAnyTaskDownloading = ValueNotifier(false);
  final Map<String, VoidCallback> _statusListeners = {};
  final Set<String> _processedForExtraction = {}; 

  static String _getPlatformSpecific7ZipPath() {
    if (Platform.isWindows) {
      const String path1 = r"C:\Program Files\7-Zip\7z.exe";
      if (File(path1).existsSync()) return path1;
      const String path2 = r"C:\Program Files (x86)\7-Zip\7z.exe";
      if (File(path2).existsSync()) return path2;
      return "7z.exe";
    } else if (Platform.isLinux || Platform.isMacOS) {
      return "7z";
    }
    debugPrint(
      "DdManager: Unsupported platform for 7-Zip path auto-detection. Assuming '7z' is in PATH.",
    );
    return "7z";
  }

  void _checkActiveDownloads() {
    bool anyActive = false;
    for (var taskList in downloadTasks.values) {
      for (var taskMap in taskList) {
        final task = taskMap['task'] as DownloadTask?;
        if (task != null) {
          final status = task.status.value;
          if (status == DownloadStatus.downloading ||
              status == DownloadStatus.paused ||
              status == DownloadStatus.queued) {
            anyActive = true;
            break;
          }
        }
      }
      if (anyActive) break;
    }
    if (isAnyTaskDownloading.value != anyActive) {
      isAnyTaskDownloading.value = anyActive;
      debugPrint("DdManager: isAnyTaskDownloading changed to $anyActive");
    }
  }

  void _addStatusListener(DownloadTask task, String sanitizedTitle) {
    final url = task.request.url;
    if (_statusListeners.containsKey(url)) {
      final oldListener = _statusListeners[url]!;
      task.status.removeListener(oldListener);
    }

    listener() {
      _checkActiveDownloads(); 

      if (task.status.value == DownloadStatus.completed) {
        _handleTaskCompletionForGroup(sanitizedTitle, "task_completed: ${task.request.url}");
      }
    }

    _statusListeners[url] = listener;
    task.status.addListener(listener);
  }

  void _removeStatusListener(String url) {
    final listener = _statusListeners.remove(url);
    if (listener != null) {
      final task = downloadManager.getDownload(url);
      if (task != null) {
        task.status.removeListener(listener);
        debugPrint("DdManager: Removed status listener for $url");
      } else {
        debugPrint(
          "DdManager: Task $url not found in plugin manager while removing listener.",
        );
      }
    }
  }

  void _handleTaskCompletionForGroup(String sanitizedTitle, String eventReason) {
    if (_processedForExtraction.contains(sanitizedTitle)) {
      return;
    }

    debugPrint("DdManager: Checking group '$sanitizedTitle' completion. Trigger: $eventReason.");

    final List<Map<String, dynamic>>? tasksInGroup = downloadTasks[sanitizedTitle];
    if (tasksInGroup == null || tasksInGroup.isEmpty) {
      debugPrint("DdManager: Group '$sanitizedTitle' is empty or not found during completion check (Reason: $eventReason).");
      _processedForExtraction.remove(sanitizedTitle); 
      return;
    }

    bool allComplete = true;
    for (var taskMap in tasksInGroup) {
      final task = taskMap['task'] as DownloadTask?;
      if (task == null) { 
          debugPrint("DdManager: Null task found in group '$sanitizedTitle' while checking completion. This is unexpected.");
          allComplete = false;
          break;
      }
      final currentStatus = task.status.value;
      if (currentStatus != DownloadStatus.completed) {
        allComplete = false;
        debugPrint("DdManager: Group '$sanitizedTitle' not (yet) fully complete. Task ${task.request.url} status: $currentStatus");
        break;
      }
    }

    if (allComplete && autoInstall == true) {
      debugPrint(
        "DdManager: SUCCESS! All tasks in group '$sanitizedTitle' have completed. (Trigger: $eventReason)",
      );
      
      final List<Map<String, dynamic>>? completedGroupTasks = downloadTasks[sanitizedTitle];
      if (completedGroupTasks != null) {
          debugPrint("DdManager: Status of tasks in '$sanitizedTitle' UPON BATCH COMPLETION CONFIRMATION:");
          for (var taskMap in completedGroupTasks) {
              final task = taskMap['task'] as DownloadTask?;
              debugPrint("  - Task URL: ${task?.request.url}, Final Status: ${task?.status.value}");
          }
      }

      _processedForExtraction.add(sanitizedTitle); 

      final filesInGroup = downloadTasks[sanitizedTitle]; 
      if (filesInGroup != null && filesInGroup.isNotEmpty) {
        final firstTaskInGroup = filesInGroup.first['task'] as DownloadTask?;
        if (firstTaskInGroup != null) {
          final String fullFilePathOfFirstTask = firstTaskInGroup.request.path;
          final String groupFilesDownloadPath = p.dirname(fullFilePathOfFirstTask);

          debugPrint(
            "DdManager: Scheduling extraction for group '$sanitizedTitle' in '$groupFilesDownloadPath'.",
          );
          final List<Map<String, dynamic>> filesToExtract = List.from(filesInGroup);

          rarExtractor.scheduleExtraction(
            groupTitle: sanitizedTitle,
            downloadFolderPath: groupFilesDownloadPath,
            filesInGroup: filesToExtract,
          );
        } else {
          debugPrint(
            "DdManager: No task details for download path for '$sanitizedTitle' after confirming completion. This is unexpected.",
          );
          _processedForExtraction.remove(sanitizedTitle); 
        }
      } else {
        debugPrint(
          "DdManager: Group '$sanitizedTitle' empty after completion, skipping extraction. This is unexpected.",
        );
        _processedForExtraction.remove(sanitizedTitle); 
      }
    }
  }


  String sanitizeFileName(String fileName) {
    final RegExp regExp = RegExp(r'[<>:"/\\|?*]');
    return fileName.replaceAll(regExp, '_');
  }

  Future<void> addDdLink(
    DownloadInfo ddInfo,
    String downloadFolder,
    String title,
  ) async {
    final sanitizedTitle = sanitizeFileName(title);
    String effectiveDownloadFolder = downloadFolder;
    if (effectiveDownloadFolder.isNotEmpty &&
        !effectiveDownloadFolder.endsWith('/')) {
      effectiveDownloadFolder += '/';
    }
    final downloadPath =
        '$effectiveDownloadFolder$sanitizedTitle/${ddInfo.fileName}';

    var existingTask = downloadManager.getDownload(ddInfo.downloadLink);
    if (existingTask == null) {
      await downloadManager.addDownload(ddInfo.downloadLink, downloadPath);
    } else {
      debugPrint(
        "Download task for ${ddInfo.downloadLink} already exists. Status: ${existingTask.status.value}",
      );
    }

    DownloadTask? task = downloadManager.getDownload(ddInfo.downloadLink);

    if (task == null) {
      debugPrint(
        "Error: Could not retrieve task for ${ddInfo.downloadLink} after attempting to add/get it.",
      );
      return;
    }

    _addStatusListener(task, sanitizedTitle); 

    if (!downloadTasks.containsKey(sanitizedTitle)) {
      downloadTasks[sanitizedTitle] = [];
    }

    bool taskAlreadyInGroup = downloadTasks[sanitizedTitle]!.any(
      (t) => (t['task'] as DownloadTask).request.url == ddInfo.downloadLink,
    );

    if (!taskAlreadyInGroup) {
      downloadTasks[sanitizedTitle]!.add({
        'fileName': ddInfo.fileName,
        'url': ddInfo.downloadLink,
        'task': task,
      });
      _taskGroupUpdatedController.add(sanitizedTitle);
    }
    _checkActiveDownloads();
  }


  DownloadTask? getDownloadTask(DownloadInfo ddInfo) {
    return downloadManager.getDownload(ddInfo.downloadLink);
  }

  DownloadTask? getDownloadTaskByUrl(String url) {
    return downloadManager.getDownload(url);
  }

  Future<void> cancelDownload(String url) async {
    await downloadManager.cancelDownload(url);
    removeDownloadTaskByUrl(url); 
  }

  Future<void> pauseDownload(String url) async {
    await downloadManager.pauseDownload(url);
  }

  Future<void> resumeDownload(String url) async {
    await downloadManager.resumeDownload(url);
  }

  Map<String, List<Map<String, dynamic>>> getDownloadTasks() {
    return downloadTasks;
  }

  void removeDownloadTaskByUrl(String url) {
    String? titleToRemoveFrom;
    String? updatedTitle;

    downloadTasks.forEach((title, tasks) {
      int initialCount = tasks.length;
      tasks.removeWhere((taskMap) {
        String? taskUrl;
        if (taskMap['url'] != null) {
          taskUrl = taskMap['url'] as String;
        } else if (taskMap['task'] != null && taskMap['task'] is DownloadTask) {
          taskUrl = (taskMap['task'] as DownloadTask).request.url;
        }

        if (taskUrl != null && taskUrl == url) {
          _removeStatusListener(url); 
          updatedTitle = title;
          return true;
        }
        return false;
      });

      if (tasks.isEmpty) {
        titleToRemoveFrom = title;
      } else if (initialCount > tasks.length) {
      }
    });

    if (titleToRemoveFrom != null) {
      downloadTasks.remove(titleToRemoveFrom);
      _taskGroupUpdatedController.add(titleToRemoveFrom!);
      _processedForExtraction.remove(titleToRemoveFrom!); 
      debugPrint("DdManager: Group $titleToRemoveFrom became empty and was removed.");
    } else if (updatedTitle != null) {
      _taskGroupUpdatedController.add(updatedTitle!);
      debugPrint("DdManager: Task $url removed from group $updatedTitle.");
      _handleTaskCompletionForGroup(updatedTitle!, "task_removed: $url");
    }
    _checkActiveDownloads();
  }

  Future<void> removeDownloadGroup(String title) async {
    final sanitizedTitle = sanitizeFileName(title);
    if (downloadTasks.containsKey(sanitizedTitle)) {
      final tasksInGroup = List<Map<String, dynamic>>.from(
        downloadTasks[sanitizedTitle]!,
      );

      for (var taskMap in tasksInGroup) {
        final task = taskMap['task'] as DownloadTask?;
        final url = taskMap['url'] as String?;
        final taskUrl = url ?? task?.request.url;

        if (taskUrl == null) continue;

        _removeStatusListener(taskUrl); 

        if (downloadManager.getDownload(taskUrl) != null) {
          try {
            await downloadManager.cancelDownload(taskUrl);
          } catch (e) {
            debugPrint(
              "DdManager: Error calling plugin's cancelDownload for $taskUrl: $e",
            );
          }
        }
      }

      downloadTasks.remove(sanitizedTitle);
      _taskGroupUpdatedController.add(sanitizedTitle);
      _processedForExtraction.remove(sanitizedTitle); 
      _checkActiveDownloads();
      debugPrint("DdManager: Removed download group '$sanitizedTitle'.");
    } else {
      debugPrint("DdManager: Attempted to remove non-existent group '$sanitizedTitle'.");
    }
  }

  void dispose() {
    _taskGroupUpdatedController.close();
    List<String> urlsWithListeners = _statusListeners.keys.toList();
    for (String url in urlsWithListeners) {
        _removeStatusListener(url); 
    }
    _statusListeners.clear(); 
    isAnyTaskDownloading.dispose();
    _processedForExtraction.clear();
    debugPrint("DdManager: Disposed.");
  }

  void debugPrintDownloadTasks() {
    downloadTasks.forEach((title, tasks) {
      debugPrint('Title: $title (${_processedForExtraction.contains(title) ? "Processed" : "Not Processed"})');
      for (var taskMap in tasks) {
        final task = taskMap['task'] as DownloadTask?;
        debugPrint(
          '  FileName: ${taskMap['fileName']}, URL: ${taskMap['url']}, Task Status: ${task?.status.value}',
        );
      }
    });
  }

  void setMaxConcurrentDownloads(int maxDownloads) {
    downloadManager.maxConcurrentTasks = maxDownloads;
  }

  void setAutoInstall(bool value) {
    autoInstall = value;
    debugPrint("DdManager: Auto-install set to $value");
  }

  ValueNotifier<double>? getBatchProgressForTitle(String title) {
    final sanitizedTitle = sanitizeFileName(title);
    if (!downloadTasks.containsKey(sanitizedTitle) ||
        downloadTasks[sanitizedTitle]!.isEmpty) {
      return null;
    }
    final tasksForTitle = downloadTasks[sanitizedTitle]!;
    final List<String> urls =
        tasksForTitle.map((taskMap) => taskMap['url'] as String).toList();
    if (urls.isEmpty) return ValueNotifier<double>(1.0); 
    return downloadManager.getBatchDownloadProgress(urls);
  }

  Future<void>? whenBatchCompleteForTitle(String title) {
    final sanitizedTitle = sanitizeFileName(title);
    if (!downloadTasks.containsKey(sanitizedTitle) ||
        downloadTasks[sanitizedTitle]!.isEmpty) {
      debugPrint(
      "DdManager: whenBatchCompleteForTitle called for '$sanitizedTitle' but group is empty or not found. Returning null.",
    );
      return null;
    }
    final tasksForTitle = downloadTasks[sanitizedTitle]!;
    final List<String> urls =
        tasksForTitle.map((taskMap) => taskMap['url'] as String).toList();
    debugPrint(
      "DdManager: whenBatchCompleteForTitle called for '$sanitizedTitle' with URLs: $urls. This Future is for external use.",
    );
    if (urls.isEmpty) return Future.value(); 
    return downloadManager.whenBatchDownloadsComplete(urls);
  }
}