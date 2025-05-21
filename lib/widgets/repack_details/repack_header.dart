import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fit_flutter_fluent/theme.dart';
import 'package:fit_flutter_fluent/widgets/fluent_chip.dart';
import 'package:fit_flutter_fluent/widgets/repack_details/download_links_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

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
  final HostService _hostService = HostService(); // Instantiate HostService

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
  }

  void _showDownloadLinksProcessingDialog(String repackTitle, String mirrorUrlsString, String downloadPath) {
    showDialog(
      context: context,
      barrierDismissible: false, // User cannot dismiss by tapping outside while loading
      builder: (dialogContext) {
        return DownloadLinksDialog(
          repackTitle: repackTitle,
          mirrorUrlsString: mirrorUrlsString,
          downloadPath: downloadPath,
          hostService: _hostService, // Pass the HostService instance
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
        // Use StatefulBuilder to manage the dialog's internal state for selections
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateDialog) {
            // These local variables hold the state for THIS dialog instance
            // Initialized from the main state, but changes are local until "Next"
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
                                  currentDialogSelectedMirror = null; // Reset mirror
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
                            // Controller updates TextBox, no need for setStateDialog for this
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
                    // Persist dialog selections back to the main state
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
                      
                      Navigator.pop(dialogContext); // Close this first dialog

                      // Show the second dialog for processing links
                      _showDownloadLinksProcessingDialog(
                        widget.repack.title,
                        _selectedMirror!['url']!, 
                        downloadPathForThisOperation,
                      );

                    } else {
                      // Inform user to make selections
                      showDialog(
                        context: context, // Use main context for this simple info dialog
                        builder: (ctx) => ContentDialog(
                          title: Text("Selection Incomplete"),
                          content: Text("Please select a download method, a mirror, and ensure the mirror has URLs."),
                          actions: [Button(child: Text("OK"), onPressed: ()=>Navigator.pop(ctx))],
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
      // Dispose the controller when the dialog (and its StatefulBuilder) is gone.
      localDownloadPathController.dispose(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    // ... (rest of your RepackHeader build method is unchanged)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.repack.cover,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
                errorWidget:(context, url, error) => Container(width:100, height:100, color: Colors.grey[40], child: Center(child: Icon(FluentIcons.error, size: 24))),
                placeholder: (context, url) => Container(width:100, height:100, color: Colors.grey[40], child: Center(child: ProgressRing())),

              ),
            ),
            const SizedBox(width: 40),
            Expanded( // Added Expanded to prevent overflow if title is very long
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.repack.title, // Use full title, let Text widget handle overflow with maxLines if needed
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
        FilledButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              FluentTheme.of(context).accentColor,
            ),
            padding: WidgetStateProperty.all(
              const EdgeInsets.only(right: 80, left: 15, top: 15, bottom: 15),
            ),
          ),
          onPressed: widget.repack.downloadLinks.isEmpty ? null : showDownloadDialog, // Disable if no download links
          child: Text(
            "Download",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}