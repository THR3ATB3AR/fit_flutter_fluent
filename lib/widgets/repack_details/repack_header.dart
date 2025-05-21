import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fit_flutter_fluent/theme.dart';
import 'package:fit_flutter_fluent/widgets/fluent_chip.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class RepackHeader extends StatefulWidget {
  final Repack repack;
  const RepackHeader({super.key, required this.repack});

  @override
  State<RepackHeader> createState() => _RepackHeaderState();
}

class _RepackHeaderState extends State<RepackHeader> {
  String? _selectedDownloadMethod;
  Map<String, String>? _selectedMirror;

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

  String _overflowText(String text, int maxLength) {
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
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
            List<Map<String, String>> currentMirrors = [];
            if (_selectedDownloadMethod != null &&
                widget.repack.downloadLinks.containsKey(
                  _selectedDownloadMethod,
                )) {
              currentMirrors =
                  widget.repack.downloadLinks[_selectedDownloadMethod!]!;
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
                      InfoLabel(
                        label: 'Select Download Method:',
                        child: ComboBox<String>(
                          value: _selectedDownloadMethod,
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
                              setState(() { 
                                _selectedDownloadMethod = newValue;
                                _selectedMirror = null;
                                List<Map<String, String>>? mirrors = widget
                                    .repack
                                    .downloadLinks[_selectedDownloadMethod!];
                                if (mirrors != null && mirrors.isNotEmpty) {
                                  _selectedMirror = mirrors.first;
                                }
                              });
                              setStateDialog((){}); 
                            }
                          },
                          placeholder: const Text('Select method'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      InfoLabel(
                        label: 'Select Mirror:',
                        child: ComboBox<Map<String, String>>(
                          value: _selectedMirror,
                          items:
                              currentMirrors.map((mirrorMap) {
                                final hostName = mirrorMap['hostName']!;
                                return ComboBoxItem<Map<String, String>>(
                                  value: mirrorMap,
                                  child: Text(hostName),
                                );
                              }).toList(),
                          onChanged: (Map<String, String>? newValue) {
                            if (newValue != null) {
                              setState(() { 
                                _selectedMirror = newValue;
                              });
                              setStateDialog((){}); 
                            }
                          },
                          placeholder: const Text('Select mirror'),
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
                            setStateDialog(() {
                              localDownloadPathController.text = path;
                            });
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
                    localDownloadPathController.dispose();
                    Navigator.pop(dialogContext);
                  }
                ),
                FilledButton(
                  onPressed: () {
                    final String downloadPathForThisOperation = localDownloadPathController.text;

                    if (_selectedDownloadMethod != null &&
                        _selectedMirror != null) {
                      print('Selected Method: $_selectedDownloadMethod');
                      print('Selected Mirror Host: ${_selectedMirror!['hostName']}');
                      print('Download Path for this operation: $downloadPathForThisOperation');
                    }
                    localDownloadPathController.dispose(); 
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Next'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
    });
  }

  @override
  Widget build(BuildContext context) {
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
              ),
            ),
            const SizedBox(width: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _overflowText(widget.repack.title, 39),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  widget.repack.company,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
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
          onPressed: showDownloadDialog,
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