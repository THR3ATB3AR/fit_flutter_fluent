import 'dart:async';
import 'package:fit_flutter_fluent/services/dd_manager.dart';
import 'package:flutter_download_manager/flutter_download_manager.dart' as fdm;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

String getStatusText(fdm.DownloadStatus status, BuildContext context) {
  switch (status) {
    case fdm.DownloadStatus.queued:
      return AppLocalizations.of(context)!.queued;
    case fdm.DownloadStatus.downloading:
      return AppLocalizations.of(context)!.downloading;
    case fdm.DownloadStatus.completed:
      return AppLocalizations.of(context)!.completed;
    case fdm.DownloadStatus.failed:
      return AppLocalizations.of(context)!.failed;
    case fdm.DownloadStatus.paused:
      return AppLocalizations.of(context)!.paused;
    case fdm.DownloadStatus.canceled:
      return AppLocalizations.of(context)!.canceled;
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
      } else if (batchProgressNotifier == null || entry.value.isEmpty) {}
    }

    if (titlesToRemove.isEmpty) {
      await displayInfoBar(
        context,
        builder: (context, close) {
          return InfoBar(
            title: Text(AppLocalizations.of(context)!.noCompletedGroupsToClear),
            severity: InfoBarSeverity.info,
            action: Button(
              onPressed: close,
              child: Text(AppLocalizations.of(context)!.dismiss),
            ),
          );
        },
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => ContentDialog(
            title: Text(AppLocalizations.of(context)!.confirmClear),
            content: Text(
              AppLocalizations.of(
                context,
              )!.confirmRemoveDownloadGroups(titlesToRemove.length),
            ),
            actions: [
              Button(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () => Navigator.pop(ctx, false),
              ),
              FilledButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                ),
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(AppLocalizations.of(context)!.clearCompleted),
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
            title: Text(
              AppLocalizations.of(
                context,
              )!.completedGroupsCleared(titlesToRemove.length),
            ),
            severity: InfoBarSeverity.success,
            action: Button(
              onPressed: close,
              child: Text(AppLocalizations.of(context)!.dismiss),
            ),
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
        title: Text(AppLocalizations.of(context)!.downloadManager),
        commandBar: CommandBar(
          mainAxisAlignment: MainAxisAlignment.end,
          primaryItems: [
            CommandBarButton(
              icon: const Icon(FluentIcons.settings),
              label: Text(AppLocalizations.of(context)!.maxConcurrent),
              onPressed: () {
                context.go('/settings?section=maxConcurrentDownloads');
              },
            ),
            CommandBarButton(
              icon: const Icon(FluentIcons.clear_selection),
              label: Text(AppLocalizations.of(context)!.clearCompleted),
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
                      AppLocalizations.of(context)!.noActiveDownloads,
                      style: theme.typography.subtitle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(
                        context,
                      )!.downloadsWillAppearHereOnceAdded,
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
                    key: ValueKey(title),
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
        key: ValueKey('expander_$groupTitle'),
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
                                    ? AppLocalizations.of(
                                      context,
                                    )!.completedNumberFiles(tasks.length)
                                    : AppLocalizations.of(
                                      context,
                                    )!.overallProgressFilesPercent(
                                      (progress * 100).toStringAsFixed(0),
                                      tasks.length,
                                    ),
                                style:
                                    FluentTheme.of(context).typography.caption,
                              ),
                            ],
                          );
                        },
                      )
                    else
                      Text(
                        AppLocalizations.of(
                          context,
                        )!.noActiveTasks(tasks.length),
                        style: FluentTheme.of(context).typography.caption,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Tooltip(
                message:
                    AppLocalizations.of(context)!.cancelAllDownloadsInThisGroup,
                child: IconButton(
                  icon: Icon(FluentIcons.remove_from_trash, color: Colors.red),
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder:
                          (ctx) => ContentDialog(
                            title: Text(
                              AppLocalizations.of(
                                context,
                              )!.cancelGroupName(groupTitle),
                            ),
                            content: Text(
                              AppLocalizations.of(
                                context,
                              )!.areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem,
                            ),
                            actions: [
                              Button(
                                child: Text(AppLocalizations.of(context)!.no),
                                onPressed: () => Navigator.pop(ctx, false),
                              ),
                              FilledButton(
                                onPressed: () => Navigator.pop(ctx, true),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Colors.red,
                                  ),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.yesCancelGroup,
                                ),
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
                      taskData['fileName'] as String? ??
                      AppLocalizations.of(context)!.unknownFile;
                  final url = taskData['url'] as String? ?? '';

                  if (task == null) {
                    return ListTile(
                      title: Text(fileName),
                      subtitle: Text(
                        AppLocalizations.of(context)!.errorTaskDataUnavailable,
                      ),
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
              return ProgressBar(value: progressValue * 100, strokeWidth: 6);
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
                        getStatusText(statusValue, context),
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
                        message: AppLocalizations.of(context)!.pause,
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
                        message: AppLocalizations.of(context)!.resume,
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
                        message: AppLocalizations.of(context)!.cancel,
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
                        message: AppLocalizations.of(context)!.removeFromList,
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
