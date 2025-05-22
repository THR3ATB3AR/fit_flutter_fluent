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
    _taskGroupUpdateSubscription = _ddManager.onTaskGroupUpdated.listen((updatedSanitizedTitle) {
      if (mounted && updatedSanitizedTitle == _ddManager.sanitizeFileName(widget.repack.title)) {
        _setupProgressListener(); 
      }
    });
  }

  void _setupProgressListener() {
    _batchProgressNotifier?.removeListener(_onProgressChanged);

    _batchProgressNotifier = _ddManager.getBatchProgressForTitle(widget.repack.title);

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

  void _showDownloadLinksProcessingDialog(String repackTitle, String mirrorUrlsString, String downloadPath) {
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
                    children: [
                      Expanded(
                        child: InfoLabel(
                          label: 'Select Download Method:',
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
                                  List<Map<String, String>>? mirrors = widget
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
                          label: 'Select Mirror:',
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
                  const SizedBox(height: 16),
                  InfoLabel(
                    label: 'Override Download Location:',
                    child: TextBox(
                      placeholder: 'Enter download location',
                      controller: localDownloadPathController, 
                      suffix: IconButton(
                        icon: const Icon(FluentIcons.folder),
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
                  }
                ),
                FilledButton(
                  onPressed: () {
                    _selectedDownloadMethod = currentDialogSelectedMethod;
                    _selectedMirror = currentDialogSelectedMirror;

                    final String downloadPathForThisOperation = localDownloadPathController.text;
                    
                    if (_selectedDownloadMethod != null &&
                        _selectedMirror != null &&
                        _selectedMirror!['url'] != null &&
                        _selectedMirror!['url']!.isNotEmpty) {
                      
                      debugPrint('Selected Method: $_selectedDownloadMethod');
                      debugPrint('Selected Mirror Host: ${_selectedMirror!['hostName']}');
                      debugPrint('Selected Mirror URL(s): ${_selectedMirror!['url']}');
                      debugPrint('Download Path for this operation: $downloadPathForThisOperation');
                      
                      Navigator.pop(dialogContext); 

                      _showDownloadLinksProcessingDialog(
                        widget.repack.title,
                        _selectedMirror!['url']!, 
                        downloadPathForThisOperation,
                      );

                    } else {
                      showDialog(
                        context: context, 
                        builder: (ctx) => ContentDialog(
                          title: const Text("Selection Incomplete"),
                          content: const Text("Please select a download method, a mirror, and ensure the mirror has URLs."),
                          actions: [Button(child: const Text("OK"), onPressed: ()=>Navigator.pop(ctx))],
                        )
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.repack.cover,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
                errorWidget:(context, url, error) => Container(width:100, height:100, color: Colors.grey[40], child: const Center(child: Icon(FluentIcons.error, size: 24))),
                placeholder: (context, url) => Container(width:100, height:100, color: Colors.grey[40], child: const Center(child: ProgressRing())),
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.repack.title,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.repack.company,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:
              widget.repack.genres
                  .split(',')
                  .map(
                    (g) => Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: FluentChip(label: g.trim()),
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 170,
          child: FilledButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                FluentTheme.of(context).accentColor,
              ),
              padding: WidgetStateProperty.all(
                const EdgeInsets.only(left: 15, top: 15, bottom: 15),
              ),
            ),
            onPressed: widget.repack.downloadLinks.isEmpty ? null : showDownloadDialog,
            child: Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Download",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),

        if (_batchProgressNotifier != null) 
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  width: 170,
                  child: ProgressBar(
                    value: _batchProgress * 100, 
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _batchProgress == 1.0
                      ? 'Download complete!'
                      : _batchProgress == 0.0
                          ? 'Download pending...'
                          : 'Downloading: ${(_batchProgress * 100).toStringAsFixed(0)}%',
                  style: FluentTheme.of(context).typography.body,
                ),
                
              ],
            ),
          ),
      ],
    );
  }
}