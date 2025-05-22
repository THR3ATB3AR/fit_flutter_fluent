import 'dart:async';
import 'package:fit_flutter_fluent/data/download_info.dart'; 
import 'package:flutter_download_manager/flutter_download_manager.dart';
import 'package:flutter/foundation.dart'; 


class DdManager {
  final DownloadManager downloadManager = DownloadManager();

  final StreamController<String> _taskGroupUpdatedController =
      StreamController<String>.broadcast();
  Stream<String> get onTaskGroupUpdated => _taskGroupUpdatedController.stream;

  DdManager._privateConstructor() ;

  Map<String, List<Map<String, dynamic>>> downloadTasks = {};
  static final DdManager _instance = DdManager._privateConstructor();
  static DdManager get instance => _instance;

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
      print(
        "Download task for ${ddInfo.downloadLink} already exists. Status: ${existingTask.status.value}",
      );
    }

    DownloadTask? task = downloadManager.getDownload(ddInfo.downloadLink);

    if (task == null) {
      print(
        "Error: Could not retrieve task for ${ddInfo.downloadLink} after attempting to add/get it.",
      );
      return;
    }

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

  // Zmieniono nazwę dla jasności
  void removeDownloadTaskByUrl(String url) {
  String? titleToRemoveFrom;
  String? updatedTitle; // To notify even if group not removed

  downloadTasks.forEach((title, tasks) {
    int initialCount = tasks.length;
    tasks.removeWhere((taskMap) {
      // Ensure taskMap has 'url' or 'task'
      String? taskUrl;
      if (taskMap['url'] != null) {
        taskUrl = taskMap['url'] as String;
      } else if (taskMap['task'] != null && taskMap['task'] is DownloadTask) {
        taskUrl = (taskMap['task'] as DownloadTask).request.url;
      }
      
      if (taskUrl != null && taskUrl == url) {
        updatedTitle = title; // Found the task in this group
        return true;
      }
      return false;
    });

    if (tasks.isEmpty) {
      titleToRemoveFrom = title;
    } else if (initialCount > tasks.length) {
      // Task was removed, but group still exists
      updatedTitle = title;
    }
  });

  if (titleToRemoveFrom != null) {
    downloadTasks.remove(titleToRemoveFrom);
    _taskGroupUpdatedController.add(titleToRemoveFrom!); 
    print("Group $titleToRemoveFrom became empty and was removed.");
  } else if (updatedTitle != null) {
    _taskGroupUpdatedController.add(updatedTitle!);
     print("Task removed from group $updatedTitle.");
  }
}

Future<void> removeDownloadGroup(String title) async {
  final sanitizedTitle = sanitizeFileName(title);
  if (downloadTasks.containsKey(sanitizedTitle)) {
    final tasksInGroup = List<Map<String, dynamic>>.from(
      downloadTasks[sanitizedTitle]!,
    );
    for (var taskMap in tasksInGroup) {
      final task = taskMap['task'] as DownloadTask;
      // Check if the task is still managed by flutter_download_manager
      if (downloadManager.getDownload(task.request.url) != null) {
          await downloadManager.cancelDownload(task.request.url);
          await downloadManager.removeDownload(task.request.url);
      }
    }
    downloadTasks.remove(sanitizedTitle);
    print("Removed download group: $sanitizedTitle");
    _taskGroupUpdatedController.add(sanitizedTitle); // Notify about removal of group
  }
}

// Ensure you have a dispose method in DdManager for the StreamController
void dispose() {
  _taskGroupUpdatedController.close();
}

  void printDownloadTasks() {
    downloadTasks.forEach((title, tasks) {
      print('Title: $title');
      for (var task in tasks) {
        print(
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

    if (urls.isEmpty) {
      return ValueNotifier<double>(1.0);
    }
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

    if (urls.isEmpty) {
      return Future.value();
    }
    return downloadManager.whenBatchDownloadsComplete(urls);
  }
}
