import 'package:fluent_ui/fluent_ui.dart';
import 'package:fit_flutter_fluent/data/download_info.dart'; 
import 'package:fit_flutter_fluent/services/host_service.dart';

class DownloadLinksDialog extends StatefulWidget {
  final String repackTitle;
  final String mirrorUrlsString; 
  final String downloadPath;
  final HostService hostService;

  const DownloadLinksDialog({
    super.key,
    required this.repackTitle,
    required this.mirrorUrlsString,
    required this.downloadPath,
    required this.hostService,
  });

  @override
  State<DownloadLinksDialog> createState() => _DownloadLinksDialogState();
}

class _DownloadLinksDialogState extends State<DownloadLinksDialog> {
  bool _isLoading = true;
  List<DownloadInfo> _downloadInfos = [];
  List<TreeViewItem> _treeViewItems = [];
  String? _processingError;
  final Set<TreeViewItem> _selectedTreeItems = {};

  @override
  void initState() {
    super.initState();
    _fetchAndProcessLinks();
  }

  Future<void> _fetchAndProcessLinks() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _processingError = null;
      _downloadInfos.clear();
      _treeViewItems.clear();
      _selectedTreeItems.clear();
    });

    List<String> urls = [];
    if (widget.mirrorUrlsString.contains(',')) {
      urls = widget.mirrorUrlsString.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    } else if (widget.mirrorUrlsString.trim().isNotEmpty) {
      urls.add(widget.mirrorUrlsString.trim());
    }

    if (urls.isEmpty) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _processingError = "No URLs found in the mirror configuration.";
      });
      return;
    }

    List<DownloadInfo> collectedInfos = [];
    String? errorDuringProcessing;

    for (final url in urls) {
      
      try {
        final result = await widget.hostService.getDownloadPlugin(widget.repackTitle, url);
        if (result is DownloadInfo) {
          collectedInfos.add(result);
        } else {
          debugPrint('Plugin for $url is unknown or returned: $result');
          collectedInfos.add(DownloadInfo(
              repackTitle: widget.repackTitle,
              downloadLink: url,
              fileName: 'Failed to process (Unknown Plugin): ${url.split('/').last}',
              downloadType: 'Error'));
          errorDuringProcessing = '${errorDuringProcessing ?? ""}Problem processing some links. ';
        }
      } catch (e) {
        debugPrint('Error processing link $url: $e');
        String shortError = e.toString();
        if (shortError.length > 100) shortError = "${shortError.substring(0, 97)}...";
        collectedInfos.add(DownloadInfo(
            repackTitle: widget.repackTitle,
            downloadLink: url,
            fileName: 'Error processing ${url.split('/').last}: $shortError',
            downloadType: 'Error'));
        errorDuringProcessing = '${errorDuringProcessing ?? ""}Error processing one or more links. ';
      }
    }

    Map<String, List<DownloadInfo>> groupedInfos = {};
    for (final info in collectedInfos) {
      groupedInfos.putIfAbsent(info.downloadType.isNotEmpty ? info.downloadType : "Uncategorized", () => []).add(info);
    }

    List<TreeViewItem> treeItems = [];
    groupedInfos.forEach((type, infos) {
      treeItems.add(
        TreeViewItem(
          content: Text(type, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          value: type, 
          selected: true,
          expanded: false,
          children: infos.map((info) {
            return TreeViewItem(
              content: Text(info.fileName),
              value: info, 
              selected: true,
            );
          }).toList(),
        ),
      );
    });
    
    if (!mounted) return;
    setState(() {
      _downloadInfos = collectedInfos;
      _treeViewItems = treeItems;
      _selectedTreeItems.clear();
      for (var item in _treeViewItems) {
          for (var child in item.children) {
            if (child.selected!) {
              _selectedTreeItems.add(child);
            }
        }
      }
      _isLoading = false;
      _processingError = errorDuringProcessing?.trim();
    });
  }

  void _startDownloadSelected() {
    List<DownloadInfo> itemsToDownload = _selectedTreeItems
        .where((item) => item.value is DownloadInfo) 
        .map((item) => item.value as DownloadInfo)
        .toList();

    if (itemsToDownload.isNotEmpty) {
      debugPrint('Attempting to download ${itemsToDownload.length} items to ${widget.downloadPath}:');
      for (var item in itemsToDownload) {
        debugPrint('- ${item.fileName} from ${item.downloadLink}');
      }
      Navigator.pop(context);
      showDialog(
        context: context, 
        builder: (ctx) => ContentDialog(
          title: Text("Download Initiated (Placeholder)"),
          content: Text("${itemsToDownload.length} file(s) would start downloading to ${widget.downloadPath}."),
          actions: [Button(child: Text("OK"), onPressed: ()=>Navigator.pop(ctx))],
        )
      );
    } else {
      showDialog(
        context: context, 
        builder: (ctx) => ContentDialog(
          title: Text("No Files Selected"),
          content: Text("Please select one or more files from the tree to download."),
          actions: [Button(child: Text("OK"), onPressed: ()=>Navigator.pop(ctx))],
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget dialogContent;
    if (_isLoading) {
      dialogContent = const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProgressRing(),
            SizedBox(height: 20),
            Text('Processing download links... Please wait.'),
          ],
        ),
      );
    } else if (_treeViewItems.isEmpty && _processingError != null) {
      dialogContent = Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Error: $_processingError\nNo files could be retrieved.', textAlign: TextAlign.center),
        ),
      );
    } else {
      dialogContent = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_processingError != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Notice: $_processingError Some files may have encountered issues.',
                style: TextStyle(color: Colors.orange.normal),
              ),
            ),
          if (_treeViewItems.isEmpty)
            const Expanded(
              child: Center(child: Text('No downloadable files found for this mirror.'))
            )
          else
            Expanded(
              child: TreeView(
                items: _treeViewItems,
                selectionMode: TreeViewSelectionMode.multiple,
                onSelectionChanged: (selectedItems) async {
                  if (selectedItems.isNotEmpty) {
                    _selectedTreeItems.clear();
                    for (var item in selectedItems) {
                      if (item.value is DownloadInfo) {
                        _selectedTreeItems.add(item);
                      }
                    }
                  }
                  return;
                },
              ),
            ),
        ],
      );
    }

    return ContentDialog(
      title: Text('Download Files: ${widget.repackTitle}'),
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
      content: SizedBox( 
        width: double.maxFinite,
        height: 400, 
        child: dialogContent,
      ),
      actions: [
        Button(
          child: const Text('Close'),
          onPressed: () => Navigator.pop(context),
        ),
        if (!_isLoading && _treeViewItems.isNotEmpty)
          FilledButton(
            onPressed: _selectedTreeItems.isNotEmpty ? _startDownloadSelected : null,
            child: const Text('Download Selected'),
          ),
      ],
    );
  }
}