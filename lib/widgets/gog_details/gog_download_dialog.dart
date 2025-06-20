import 'package:fit_flutter_fluent/data/download_mirror.dart';
import 'package:fit_flutter_fluent/data/gog_download_links.dart';
import 'package:fit_flutter_fluent/services/dd_manager.dart';
import 'package:fit_flutter_fluent/data/download_info.dart';
import 'package:fit_flutter_fluent/services/host_service.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fit_flutter_fluent/theme.dart';
import 'package:fit_flutter_fluent/l10n/generated/app_localizations.dart';

class GogDownloadDialog extends StatefulWidget {
  final String gameTitle;
  final GogDownloadLinks links;

  const GogDownloadDialog({
    super.key,
    required this.gameTitle,
    required this.links,
  });

  @override
  State<GogDownloadDialog> createState() => _GogDownloadDialogState();
}

class _GogDownloadDialogState extends State<GogDownloadDialog> {
  late final TextEditingController _pathController;
  String? _selectedCategory;
  DownloadMirror? _selectedMirror;

  @override
  void initState() {
    super.initState();
    final appTheme = Provider.of<AppTheme>(context, listen: false);
    _pathController = TextEditingController(text: appTheme.downloadPath);

    // Pre-select the first available category and mirror
    if (widget.links.gameDownloadLinks.isNotEmpty) {
      _selectedCategory = 'GAME';
      _selectedMirror = widget.links.gameDownloadLinks['GAME']!.first;
    } else if (widget.links.patchDownloadLinks.isNotEmpty) {
      _selectedCategory = 'PATCH';
      _selectedMirror = widget.links.patchDownloadLinks['PATCH']!.first;
    } else if (widget.links.extraDownloadLinks.isNotEmpty) {
      _selectedCategory = 'EXTRA';
      _selectedMirror = widget.links.extraDownloadLinks['EXTRA']!.first;
    } else if (widget.links.torrentLink != null) {
      _selectedCategory = 'TORRENT';
    }
  }

  @override
  void dispose() {
    _pathController.dispose();
    super.dispose();
  }

  Future<void> _startDownload() async {
    final downloadPath = _pathController.text.trim();
    if (downloadPath.isEmpty) {
      // Show error if path is empty
      return;
    }

    if (_selectedCategory == 'TORRENT' && widget.links.torrentLink != null) {
      launchUrl(Uri.parse(widget.links.torrentLink!));
      Navigator.pop(context);
    } else if (_selectedMirror != null) {
      
      showDialog(
        context: context,
        builder: (context) => ContentDialog(
          title: Text(AppLocalizations.of(context)!.error),
            content: Text(AppLocalizations.of(context)!.onlyTorrentsAreWorkingForNow),
          actions: [
        Button(
          child: Text(AppLocalizations.of(context)!.ok),
          onPressed: () => Navigator.pop(context),
        ),
          ],
        ),
      );

      // final ddManager = DdManager.instance;
      // final hostService = HostService();
      // for (final url in _selectedMirror!.urls) {
      //   debugPrint(url);
      //   final DownloadInfo info = await hostService.getDownloadPlugin(widget.gameTitle, url);
      //   debugPrint('${info.downloadLink}, ${info.downloadType}, ${info.fileName}');
      //   await ddManager.addDdLink(info, downloadPath, widget.gameTitle);
      // }
      // Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final categories = {
      if (widget.links.torrentLink != null) 'TORRENT': <DownloadMirror>[],
      ...widget.links.gameDownloadLinks,
      ...widget.links.patchDownloadLinks,
      ...widget.links.extraDownloadLinks,
    };

    List<DownloadMirror> currentMirrors = [];
    if (_selectedCategory != null && _selectedCategory != 'TORRENT') {
      currentMirrors = categories[_selectedCategory] ?? [];
    }

    return ContentDialog(
      title: Text(localizations.selectDownloadOptions),
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
                  label: localizations.downloadMethod,
                  child: ComboBox<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    items: categories.keys.map((key) => ComboBoxItem<String>(value: key, child: Text(key))).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedCategory = value;
                          if (value != 'TORRENT' && categories[value]!.isNotEmpty) {
                            _selectedMirror = categories[value]!.first;
                          } else {
                            _selectedMirror = null;
                          }
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              if (_selectedCategory != 'TORRENT')
                Expanded(
                  child: InfoLabel(
                    label: localizations.mirror,
                    child: ComboBox<DownloadMirror>(
                      value: _selectedMirror,
                      isExpanded: true,
                      items: currentMirrors.map((mirror) => ComboBoxItem<DownloadMirror>(
                        value: mirror,
                        child: Text(mirror.mirrorName),
                      )).toList(),
                      onChanged: (value) {
                        setState(() => _selectedMirror = value);
                      },
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          InfoLabel(
            label: localizations.downloadLocation,
            child: TextBox(
              controller: _pathController,
              suffix: IconButton(
                icon: const Icon(FluentIcons.folder_open),
                onPressed: () async {
                  final path = await FilePicker.platform.getDirectoryPath();
                  if (path != null) {
                    _pathController.text = path;
                  }
                },
              ),
            ),
          ),
        ],
      ),
      actions: [
        Button(
          child: Text(localizations.close),
          onPressed: () => Navigator.pop(context),
        ),
        FilledButton(
          onPressed: _startDownload,
          child: Text(localizations.next),
        ),
      ],
    );
  }
}