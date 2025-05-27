import 'dart:async';
import 'package:fit_flutter_fluent/data/download_info.dart';
import 'package:flutter_download_manager/flutter_download_manager.dart'
    show DownloadManager, DownloadTask, DownloadStatus;
import 'package:flutter/foundation.dart';

class DdManager {
  final DownloadManager downloadManager = DownloadManager();

  final StreamController<String> _taskGroupUpdatedController =
      StreamController<String>.broadcast();
  Stream<String> get onTaskGroupUpdated => _taskGroupUpdatedController.stream;

  DdManager._privateConstructor();

  Map<String, List<Map<String, dynamic>>> downloadTasks = {};
  static final DdManager _instance = DdManager._privateConstructor();
  static DdManager get instance => _instance;

  final ValueNotifier<bool> isAnyTaskDownloading = ValueNotifier(false);
  final Map<String, VoidCallback> _statusListeners = {};

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

  void _addStatusListener(DownloadTask task) {
    final url = task.request.url;
    if (_statusListeners.containsKey(url)) {
      task.status.removeListener(_statusListeners[url]!);
    }
    VoidCallback listener = () => _checkActiveDownloads();
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

    _addStatusListener(task); 

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
    removeDownloadTaskByUrl(
      url,
    );
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
        updatedTitle = title;
      }
    });

    if (titleToRemoveFrom != null) {
      downloadTasks.remove(titleToRemoveFrom);
      _taskGroupUpdatedController.add(titleToRemoveFrom!);
      debugPrint("Group $titleToRemoveFrom became empty and was removed.");
    } else if (updatedTitle != null) {
      _taskGroupUpdatedController.add(updatedTitle!);
      debugPrint("Task removed from group $updatedTitle.");
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
      _checkActiveDownloads(); 
    } else {
    }
  }

  void dispose() {
    _taskGroupUpdatedController.close();
    _statusListeners.forEach((url, listener) {
      final task = downloadManager.getDownload(url);
      if (task != null) {
        task.status.removeListener(listener);
      }
    });
    _statusListeners.clear();
    isAnyTaskDownloading.dispose(); 
    debugPrint("DdManager: Disposed.");
  }

  void debugPrintDownloadTasks() {
    downloadTasks.forEach((title, tasks) {
      debugPrint('Title: $title');
      for (var task in tasks) {
        debugPrint(
          '  FileName: ${task['fileName']}, URL: ${task['url']}, Task Status: ${(task['task'] as DownloadTask).status.value}',
        );
      }
    });
  }

  void setMaxConcurrentDownloads(int maxDownloads) {
    downloadManager.maxConcurrentTasks = maxDownloads;
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
      return null;
    }
    final tasksForTitle = downloadTasks[sanitizedTitle]!;
    final List<String> urls =
        tasksForTitle.map((taskMap) => taskMap['url'] as String).toList();
    if (urls.isEmpty) return Future.value();
    return downloadManager.whenBatchDownloadsComplete(urls);
  }
}
