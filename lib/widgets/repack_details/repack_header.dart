import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fit_flutter_fluent/theme.dart';
import 'package:fit_flutter_fluent/widgets/fluent_chip.dart';
import 'package:fit_flutter_fluent/widgets/repack_details/download_links_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:fit_flutter_fluent/services/dd_manager.dart';
import 'package:fit_flutter_fluent/services/host_service.dart';

class RepackHeader extends StatefulWidget {
  final Repack repack;
  const RepackHeader({super.key, required this.repack});

  @override
  State<RepackHeader> createState() => _RepackHeaderState();
}

class _RepackHeaderState extends State<RepackHeader> {
  String? _selectedDownloadMethod;
  Map<String, String>? _selectedMirror;
  final HostService _hostService = HostService();

  final DdManager _ddManager = DdManager.instance;
  ValueNotifier<double>? _batchProgressNotifier;
  double _batchProgress = 0.0;
  StreamSubscription? _taskGroupUpdateSubscription;

  @override
  void initState() {
    super.initState();
    if (widget.repack.downloadLinks.isNotEmpty) {
      _selectedDownloadMethod = widget.repack.downloadLinks.keys.first;
      List<Map<String, String>>? mirrors =
          widget.repack.downloadLinks[_selectedDownloadMethod!];
      if (mirrors != null && mirrors.isNotEmpty) {
        _selectedMirror = mirrors.first;
      }
    }

    _setupProgressListener();
    _taskGroupUpdateSubscription = _ddManager.onTaskGroupUpdated.listen((
      updatedSanitizedTitle,
    ) {
      if (mounted &&
          updatedSanitizedTitle ==
              _ddManager.sanitizeFileName(widget.repack.title)) {
        _setupProgressListener();
      }
    });
  }

  void _setupProgressListener() {
    _batchProgressNotifier?.removeListener(_onProgressChanged);
    _batchProgressNotifier = _ddManager.getBatchProgressForTitle(
      widget.repack.title,
    );

    if (mounted) {
      setState(() {
        if (_batchProgressNotifier != null) {
          _batchProgress = _batchProgressNotifier!.value;
          _batchProgressNotifier!.addListener(_onProgressChanged);
        } else {
          _batchProgress = 0.0;
        }
      });
    }
  }

  void _onProgressChanged() {
    if (mounted && _batchProgressNotifier != null) {
      setState(() {
        _batchProgress = _batchProgressNotifier!.value;
      });
    }
  }

  @override
  void dispose() {
    _batchProgressNotifier?.removeListener(_onProgressChanged);
    _taskGroupUpdateSubscription?.cancel();
    super.dispose();
  }

  void _showDownloadLinksProcessingDialog(
    String repackTitle,
    String mirrorUrlsString,
    String downloadPath,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return DownloadLinksDialog(
          repackTitle: repackTitle,
          mirrorUrlsString: mirrorUrlsString,
          downloadPath: downloadPath,
          hostService: _hostService,
        );
      },
    );
  }

  void showDownloadDialog() {
    final appTheme = Provider.of<AppTheme>(context, listen: false);
    final TextEditingController localDownloadPathController =
        TextEditingController(text: appTheme.downloadPath);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateDialog) {
            String? currentDialogSelectedMethod = _selectedDownloadMethod;
            Map<String, String>? currentDialogSelectedMirror = _selectedMirror;

            List<Map<String, String>> currentMirrorsForDialog = [];
            if (currentDialogSelectedMethod != null &&
                widget.repack.downloadLinks.containsKey(
                  currentDialogSelectedMethod,
                )) {
              currentMirrorsForDialog =
                  widget.repack.downloadLinks[currentDialogSelectedMethod]!;
            }

            return ContentDialog(
              title: const Text('Select download options'),
              constraints: const BoxConstraints(maxWidth: 600),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InfoLabel(
                          label: 'Download Method:',
                          child: ComboBox<String>(
                            value: currentDialogSelectedMethod,
                            isExpanded: true,
                            items:
                                widget.repack.downloadLinks.keys
                                    .map(
                                      (key) => ComboBoxItem<String>(
                                        value: key,
                                        child: Text(key),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setStateDialog(() {
                                  currentDialogSelectedMethod = newValue;
                                  currentDialogSelectedMirror = null;
                                  List<Map<String, String>>? mirrors =
                                      widget
                                          .repack
                                          .downloadLinks[currentDialogSelectedMethod!];
                                  if (mirrors != null && mirrors.isNotEmpty) {
                                    currentDialogSelectedMirror = mirrors.first;
                                  }
                                });
                              }
                            },
                            placeholder: const Text('Select method'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InfoLabel(
                          label: 'Mirror:',
                          child: ComboBox<Map<String, String>>(
                            value: currentDialogSelectedMirror,
                            isExpanded: true,
                            items:
                                currentMirrorsForDialog.map((mirrorMap) {
                                  final hostName = mirrorMap['hostName']!;
                                  return ComboBoxItem<Map<String, String>>(
                                    value: mirrorMap,
                                    child: Text(hostName),
                                  );
                                }).toList(),
                            onChanged: (Map<String, String>? newValue) {
                              if (newValue != null) {
                                setStateDialog(() {
                                  currentDialogSelectedMirror = newValue;
                                });
                              }
                            },
                            placeholder: const Text('Select mirror'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  InfoLabel(
                    label: 'Download Location:',
                    child: TextBox(
                      placeholder: 'Enter download location or browse',
                      controller: localDownloadPathController,
                      suffix: IconButton(
                        icon: const Icon(FluentIcons.folder_open),
                        onPressed: () async {
                          final path =
                              await FilePicker.platform.getDirectoryPath();
                          if (path != null) {
                            localDownloadPathController.text = path;
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                Button(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                ),
                FilledButton(
                  onPressed: () {
                    final String downloadPathForThisOperation =
                        localDownloadPathController.text.trim();

                    if (downloadPathForThisOperation.isEmpty) {
                      showDialog(
                        context: context,
                        builder:
                            (ctx) => ContentDialog(
                              title: const Text("Download Location Empty"),
                              content: const Text(
                                "Please select or enter a download location.",
                              ),
                              actions: [
                                Button(
                                  child: const Text("OK"),
                                  onPressed: () => Navigator.pop(ctx),
                                ),
                              ],
                            ),
                      );
                      return;
                    }

                    _selectedDownloadMethod = currentDialogSelectedMethod;
                    _selectedMirror = currentDialogSelectedMirror;

                    if (_selectedDownloadMethod != null &&
                        _selectedMirror != null &&
                        _selectedMirror!['url'] != null &&
                        _selectedMirror!['url']!.isNotEmpty) {
                      Navigator.pop(dialogContext);

                      _showDownloadLinksProcessingDialog(
                        widget.repack.title,
                        _selectedMirror!['url']!,
                        downloadPathForThisOperation,
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder:
                            (ctx) => ContentDialog(
                              title: const Text("Selection Incomplete"),
                              content: const Text(
                                "Please select a download method and a mirror.",
                              ),
                              actions: [
                                Button(
                                  child: const Text("OK"),
                                  onPressed: () => Navigator.pop(ctx),
                                ),
                              ],
                            ),
                      );
                    }
                  },
                  child: const Text('Next'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      localDownloadPathController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final typography = theme.typography;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.repack.cover,
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                    errorWidget:
                        (context, url, error) => Container(
                          width: 120,
                          height: 120,
                          color: theme.resources.subtleFillColorSecondary,
                          child: Center(
                            child: Icon(
                              FluentIcons.photo_error,
                              size: 32,
                              color: theme.inactiveColor,
                            ),
                          ),
                        ),
                    placeholder:
                        (context, url) => Container(
                          width: 120,
                          height: 120,
                          color: theme.resources.subtleFillColorTertiary,
                          child: const Center(child: ProgressRing()),
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.repack.title,
                      style: typography.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.repack.company,
                      style: typography.bodyLarge?.copyWith(
                        color: theme.inactiveColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          if (widget.repack.genres.isNotEmpty)
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children:
                  widget.repack.genres
                      .split(',')
                      .map((g) => FluentChip(label: g.trim()))
                      .toList(),
            ),
          const SizedBox(height: 24),
          SizedBox(
            width: 180,
            child: FilledButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              onPressed:
                  widget.repack.downloadLinks.isEmpty
                      ? null
                      : showDownloadDialog,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FluentIcons.download,
                    size: 16,
                    color:
                        theme.brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Download",
                    style: typography.bodyStrong?.copyWith(
                      color:
                          theme.brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_batchProgressNotifier != null)
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180,
                    child: ProgressBar(
                      value: _batchProgress * 100,
                      backgroundColor: theme.resources.subtleFillColorSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _batchProgress == 1.0
                        ? 'Download complete!'
                        : _batchProgress == 0.0
                        ? 'Download pending...'
                        : 'Downloading: ${(_batchProgress * 100).toStringAsFixed(0)}%',
                    style: typography.body,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
