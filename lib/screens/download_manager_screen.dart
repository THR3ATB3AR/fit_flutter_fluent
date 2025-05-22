import 'dart:async';
import 'package:fit_flutter_fluent/services/dd_manager.dart'; 
import 'package:flutter_download_manager/flutter_download_manager.dart' as fdm;
import 'package:fluent_ui/fluent_ui.dart';


Color getStatusColor(BuildContext context, fdm.DownloadStatus status) {
  final theme = FluentTheme.of(context);
  switch (status) {
    case fdm.DownloadStatus.queued:
      return Colors.yellow.normal;
    case fdm.DownloadStatus.downloading:
      return theme.accentColor;
    case fdm.DownloadStatus.completed:
      return Colors.green.normal;
    case fdm.DownloadStatus.failed:
      return Colors.red.normal;
    case fdm.DownloadStatus.paused:
      return Colors.orange.normal;
    case fdm.DownloadStatus.canceled:
      return Colors.grey[100];
  }
}

String getStatusText(fdm.DownloadStatus status) {
  switch (status) {
    case fdm.DownloadStatus.queued:
      return "Queued";
    case fdm.DownloadStatus.downloading:
      return "Downloading";
    case fdm.DownloadStatus.completed:
      return "Completed";
    case fdm.DownloadStatus.failed:
      return "Failed";
    case fdm.DownloadStatus.paused:
      return "Paused";
    case fdm.DownloadStatus.canceled:
      return "Canceled";
  }
}

IconData getStatusIcon(fdm.DownloadStatus status) {
  switch (status) {
    case fdm.DownloadStatus.queued:
      return FluentIcons.clock;
    case fdm.DownloadStatus.downloading:
      return FluentIcons.download;
    case fdm.DownloadStatus.completed:
      return FluentIcons.check_mark;
    case fdm.DownloadStatus.failed:
      return FluentIcons.error_badge;
    case fdm.DownloadStatus.paused:
      return FluentIcons.pause;
    case fdm.DownloadStatus.canceled:
      return FluentIcons.blocked12;
  }
}

class DownloadManagerScreen extends StatefulWidget {
  const DownloadManagerScreen({super.key});

  @override
  State<DownloadManagerScreen> createState() => _DownloadManagerScreenState();
}

class _DownloadManagerScreenState extends State<DownloadManagerScreen> {
  final DdManager _ddManager = DdManager.instance;
  StreamSubscription? _groupUpdateSubscription;
  Map<String, List<Map<String, dynamic>>> _currentDownloadTasks = {};

  @override
  void initState() {
    super.initState();
    _currentDownloadTasks = Map.from(_ddManager.downloadTasks); 
    _groupUpdateSubscription = _ddManager.onTaskGroupUpdated.listen((_) {
      if (mounted) {
        setState(() {
          _currentDownloadTasks = Map.from(_ddManager.downloadTasks);
        });
      }
    });
  }

  @override
  void dispose() {
    _groupUpdateSubscription?.cancel();
    super.dispose();
  }

  void _showMaxConcurrentDownloadsDialog() {
    final controller = TextEditingController(
      text: _ddManager.downloadManager.maxConcurrentTasks.toString(),
    );
    showDialog(
      context: context,
      builder:
          (ctx) => ContentDialog(
            title: const Text('Set Max Concurrent Downloads'),
            content: TextBox(
              controller: controller,
              placeholder: 'Number of downloads',
              keyboardType: TextInputType.number,
            ),
            actions: [
              Button(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(ctx),
              ),
              FilledButton(
                child: const Text('Set'),
                onPressed: () {
                  final val = int.tryParse(controller.text);
                  if (val != null && val > 0) {
                    _ddManager.setMaxConcurrentDownloads(val);
                    Navigator.pop(ctx);
                  } else {
                  }
                },
              ),
            ],
          ),
    );
  }

  Future<void> _clearAllCompletedGroups() async {
    final titlesToRemove = <String>[];
    for (var entry in _currentDownloadTasks.entries) {
      final title = entry.key;
      final batchProgressNotifier = _ddManager.getBatchProgressForTitle(title);
      if (batchProgressNotifier != null && batchProgressNotifier.value == 1.0) {
        bool allTasksActuallyCompleted = entry.value.every((taskData) {
          final task = taskData['task'] as fdm.DownloadTask?;
          return task?.status.value == fdm.DownloadStatus.completed;
        });
        if (allTasksActuallyCompleted) {
          titlesToRemove.add(title);
        }
      } else if (batchProgressNotifier == null || entry.value.isEmpty) {
      }
    }

    if (titlesToRemove.isEmpty) {
      await displayInfoBar(
        context,
        builder: (context, close) {
          return InfoBar(
            title: const Text('No completed groups to clear.'),
            severity: InfoBarSeverity.info,
            isLong: true,
            action: Button(onPressed: close, child: const Text('Dismiss')),
          );
        },
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => ContentDialog(
            title: const Text('Confirm Clear'),
            content: Text(
              'Are you sure you want to remove ${titlesToRemove.length} completed download group(s)? This will also remove files from disk if they are in dedicated subfolders managed by the app.',
            ),
            actions: [
              Button(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(ctx, false),
              ),
              FilledButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                ),
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Clear Completed'),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      for (final title in titlesToRemove) {
        await _ddManager.removeDownloadGroup(title);
      }
      await displayInfoBar(
        context,
        builder: (context, close) {
          return InfoBar(
            title: Text('${titlesToRemove.length} completed group(s) cleared.'),
            severity: InfoBarSeverity.success,
            isLong: true,
            action: Button(onPressed: close, child: const Text('Dismiss')),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final List<String> groupTitles = _currentDownloadTasks.keys.toList();

    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Download Manager'),
        commandBar: CommandBar(
          mainAxisAlignment: MainAxisAlignment.end,
          primaryItems: [
            CommandBarButton(
              icon: const Icon(FluentIcons.settings),
              label: const Text('Max Concurrent'),
              onPressed: _showMaxConcurrentDownloadsDialog,
            ),
            CommandBarButton(
              icon: const Icon(FluentIcons.clear_selection),
              label: const Text('Clear Completed'),
              onPressed: _clearAllCompletedGroups,
            ),
          ],
        ),
      ),
      content:
          groupTitles.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FluentIcons.download_document,
                      size: 48,
                      color: theme.inactiveColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No active downloads.',
                      style: theme.typography.subtitle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Downloads will appear here once added.',
                      style: theme.typography.body,
                    ),
                  ],
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: groupTitles.length,
                itemBuilder: (context, index) {
                  final title = groupTitles[index];
                  final tasksInGroup = _currentDownloadTasks[title]!;
                  return _DownloadGroupItem(
                    key: ValueKey(
                      title,
                    ), 
                    groupTitle: title, 
                    tasks: tasksInGroup,
                    ddManager: _ddManager,
                  );
                },
              ),
    );
  }
}

class _DownloadGroupItem extends StatelessWidget {
  final String groupTitle;
  final List<Map<String, dynamic>> tasks;
  final DdManager ddManager;

  const _DownloadGroupItem({
    super.key,
    required this.groupTitle,
    required this.tasks,
    required this.ddManager,
  });

  @override
  Widget build(BuildContext context) {
    final batchProgressNotifier = ddManager.getBatchProgressForTitle(
      groupTitle,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Expander(
        key: ValueKey(
          'expander_$groupTitle',
        ), 
        header: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupTitle,
                      style: FluentTheme.of(context).typography.subtitle,
                    ),
                    if (batchProgressNotifier != null)
                      ValueListenableBuilder<double>(
                        valueListenable: batchProgressNotifier,
                        builder: (context, progress, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              ProgressBar(value: progress * 100),
                              const SizedBox(height: 4),
                              Text(
                                progress == 1.0
                                    ? 'Completed (${tasks.length} files)'
                                    : 'Overall: ${(progress * 100).toStringAsFixed(0)}% (${tasks.length} files)',
                                style:
                                    FluentTheme.of(context).typography.caption,
                              ),
                            ],
                          );
                        },
                      )
                    else
                      Text(
                        'No active tasks or progress unavailable (${tasks.length} files)',
                        style: FluentTheme.of(context).typography.caption,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Tooltip(
                message: 'Cancel all downloads in this group',
                child: IconButton(
                  icon: Icon(FluentIcons.remove_from_trash, color: Colors.red),
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder:
                          (ctx) => ContentDialog(
                            title: Text('Cancel Group: $groupTitle?'),
                            content: const Text(
                              'Are you sure you want to cancel all downloads in this group and remove them?',
                            ),
                            actions: [
                              Button(
                                child: const Text('No'),
                                onPressed: () => Navigator.pop(ctx, false),
                              ),
                              FilledButton(
                                onPressed: () => Navigator.pop(ctx, true),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                                ),
                                child: const Text('Yes, Cancel Group'),
                              ),
                            ],
                          ),
                    );
                    if (confirmed == true) {
                      await ddManager.removeDownloadGroup(groupTitle);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        content: Container(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 8.0,
            right: 8.0,
            bottom: 8.0,
          ),
          child: Column(
            children:
                tasks.map((taskData) {
                  final task = taskData['task'] as fdm.DownloadTask?;
                  final fileName =
                      taskData['fileName'] as String? ?? 'Unknown File';
                  final url = taskData['url'] as String? ?? '';

                  if (task == null) {
                    return ListTile(
                      title: Text(fileName),
                      subtitle: const Text('Error: Task data unavailable'),
                    );
                  }
                  return _DownloadFileItem(
                    key: ValueKey(url), 
                    task: task,
                    fileName: fileName,
                    ddManager: ddManager,
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}

class _DownloadFileItem extends StatelessWidget {
  final fdm.DownloadTask task;
  final String fileName;
  final DdManager ddManager;

  const _DownloadFileItem({
    super.key,
    required this.task,
    required this.fileName,
    required this.ddManager,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Card(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fileName,
            style: theme.typography.bodyStrong,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<double>(
            valueListenable: task.progress,
            builder: (context, progressValue, child) {
              return ProgressBar(
                value: progressValue * 100,
                strokeWidth: 6, 
              );
            },
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder<fdm.DownloadStatus>(
                valueListenable: task.status,
                builder: (context, statusValue, child) {
                  return Row(
                    children: [
                      Icon(
                        getStatusIcon(statusValue),
                        size: 16,
                        color: theme.inactiveColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        getStatusText(statusValue),
                        style: theme.typography.caption?.copyWith(
                          color: theme.inactiveColor,
                        ),
                      ),
                      if (statusValue == fdm.DownloadStatus.downloading ||
                          statusValue == fdm.DownloadStatus.paused ||
                          statusValue == fdm.DownloadStatus.completed)
                        ValueListenableBuilder<double>(
                          valueListenable: task.progress,
                          builder: (context, progressVal, _) {
                            return Text(
                              ' (${(progressVal * 100).toStringAsFixed(0)}%)',
                              style: theme.typography.caption?.copyWith(
                                color: theme.inactiveColor,
                              ),
                            );
                          },
                        ),
                    ],
                  );
                },
              ),
              ValueListenableBuilder<fdm.DownloadStatus>(
                valueListenable: task.status,
                builder: (context, statusValue, child) {
                  List<Widget> actions = [];
                  if (statusValue == fdm.DownloadStatus.downloading ||
                      statusValue == fdm.DownloadStatus.queued) {
                    actions.add(
                      Tooltip(
                        message: 'Pause',
                        child: IconButton(
                          icon: const Icon(FluentIcons.pause),
                          onPressed:
                              () => ddManager.pauseDownload(task.request.url),
                        ),
                      ),
                    );
                  } else if (statusValue == fdm.DownloadStatus.paused) {
                    actions.add(
                      Tooltip(
                        message: 'Resume',
                        child: IconButton(
                          icon: const Icon(FluentIcons.play),
                          onPressed:
                              () => ddManager.resumeDownload(task.request.url),
                        ),
                      ),
                    );
                  }

                  if (statusValue != fdm.DownloadStatus.completed &&
                      statusValue != fdm.DownloadStatus.canceled &&
                      statusValue != fdm.DownloadStatus.failed) {
                    actions.add(
                      Tooltip(
                        message: 'Cancel',
                        child: IconButton(
                          icon: Icon(
                            FluentIcons.cancel,
                            color: Colors.red.normal,
                          ),
                          onPressed:
                              () => ddManager.cancelDownload(task.request.url),
                        ),
                      ),
                    );
                  } else if (statusValue == fdm.DownloadStatus.failed ||
                      statusValue == fdm.DownloadStatus.canceled) {
                    actions.add(
                      Tooltip(
                        message: 'Remove from list',
                        child: IconButton(
                          icon: Icon(
                            FluentIcons.delete,
                            color: Colors.red.normal,
                          ),
                          onPressed:
                              () => ddManager.removeDownloadTaskByUrl(
                                task.request.url,
                              ),
                        ),
                      ),
                    );
                  }

                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children:
                        actions
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: e,
                              ),
                            )
                            .toList(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
