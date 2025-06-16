// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get success => 'Success';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'New and Popular repacks have been rescraped.';

  @override
  String get error => 'Error';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'Failed to rescrape data: $errorMessage';
  }

  @override
  String get home => 'Home';

  @override
  String get rescrapeNewPopular => 'Rescrape New & Popular';

  @override
  String get newRepacks => 'New Repacks';

  @override
  String get popularRepacks => 'Popular Repacks';

  @override
  String get noCompletedGroupsToClear => 'No completed groups to clear.';

  @override
  String get queued => 'Queued';

  @override
  String get downloading => 'Downloading:';

  @override
  String get completed => 'Completed';

  @override
  String get failed => 'Failed';

  @override
  String get paused => 'Paused';

  @override
  String get canceled => 'Canceled';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get confirmClear => 'Confirm Clear';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'groups',
      one: 'group',
      zero: 'groups',
    );
    return 'Are you sure you want to remove $count completed download $_temp0? This will also remove files from disk if they are in dedicated subfolders managed by the app.';
  }

  @override
  String get clearCompleted => 'Clear Completed';

  @override
  String get cancel => 'Cancel';

  @override
  String completedGroupsCleared(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'groups',
      one: 'group',
      zero: 'groups',
    );
    return '$count completed $_temp0 cleared.';
  }

  @override
  String get downloadManager => 'Download Manager';

  @override
  String get maxConcurrent => 'Max Concurrent';

  @override
  String get noActiveDownloads => 'No active downloads.';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'Downloads will appear here once added.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'Cancel all downloads in this group';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'Are you sure you want to cancel all downloads in this group and remove them?';

  @override
  String completedNumberFiles(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'files',
      one: 'file',
      zero: 'files',
    );
    return 'Completed $count $_temp0';
  }

  @override
  String overallProgressFilesPercent(num count, Object percent) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'files',
      one: 'file',
    );
    return 'Overall: $percent% ($count $_temp0)';
  }

  @override
  String noActiveTasks(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'files',
      one: 'file',
    );
    return 'No active tasks or progress unavailable ($count $_temp0)';
  }

  @override
  String cancelGroupName(Object groupName) {
    return 'Cancel Group: $groupName';
  }

  @override
  String get removeFromList => 'Remove from list';

  @override
  String get resume => 'Resume';

  @override
  String get pause => 'Pause';

  @override
  String get errorTaskDataUnavailable => 'Error: Task data unavailable';

  @override
  String get unknownFile => 'Unknown File';

  @override
  String get yesCancelGroup => 'Yes, Cancel Group';

  @override
  String get no => 'No';

  @override
  String get repackLibrary => 'Repack Library';

  @override
  String get settings => 'Settings';

  @override
  String get unknown => 'Unknown';

  @override
  String get noReleaseNotesAvailable => 'No release notes available.';

  @override
  String get search => 'Search';

  @override
  String updateAvailable(Object version) {
    return 'Update Available: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'A new version of FitFlutter is available.';

  @override
  String get viewReleaseNotes => 'View Release Notes';

  @override
  String get releasePage => 'Release Page';

  @override
  String get later => 'Later';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get downloadsInProgress => 'Downloads in Progress';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'Closing the application will cancel all active downloads. ';

  @override
  String get areYouSureYouWantToClose => 'Are you sure you want to close?';

  @override
  String get yesCloseCancel => 'Yes, Close & Cancel';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'User chose to close; cancelling downloads.';

  @override
  String get keepDownloading => 'Keep Downloading';

  @override
  String get startingLibrarySync => 'Starting library sync...';

  @override
  String get fetchingAllRepackNames => 'Fetching all repack names...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      totalPages,
      locale: localeName,
      other: 'pages',
      one: 'page',
    );
    return 'Fetching names: $page of $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails =>
      'Scraping missing repack details...';

  @override
  String get thisMayTakeAWhile => 'This may take a while.';

  @override
  String scrapingMissingRepackDetailsProgress(num current, num total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'repacks',
      one: 'repack',
    );
    return 'Scraping details: $current/$total missing $_temp0';
  }

  @override
  String get repackLibrarySynchronized => 'Repack library synchronized.';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'Failed to sync library: $errorMessage';
  }

  @override
  String get syncLibrary => 'Sync Library';

  @override
  String get syncingLibrary => 'Syncing Library...';

  @override
  String get noRepacksFoundInTheLibrary => 'No repacks found in the library.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'No repacks found matching $search.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'The window is too narrow to display items correctly.';

  @override
  String get pleaseResizeTheWindow => 'Please resize the window.';

  @override
  String get repackUrlIsNotAvailable => 'Repack URL is not available.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'Could not launch URL: $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return 'Could not launch: $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return 'Invalid URL format: $url';
  }

  @override
  String get rescrapeDetails => 'Rescrape Details';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return 'Details for $title have been rescraped and updated.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'Failed to rescrape details: $errorMessage';
  }

  @override
  String get errorRescraping => 'Error Rescraping';

  @override
  String get openSourcePage => 'Open Source Page';

  @override
  String noPopularNewRepacksFound(Object type) {
    return 'No $type repacks found.';
  }

  @override
  String get newest => 'new';

  @override
  String get popular => 'popular';

  @override
  String get system => 'System';

  @override
  String get yellow => 'Yellow';

  @override
  String get orange => 'Orange';

  @override
  String get red => 'Red';

  @override
  String get magenta => 'Magenta';

  @override
  String get purple => 'Purple';

  @override
  String get blue => 'Blue';

  @override
  String get teal => 'Teal';

  @override
  String get green => 'Green';

  @override
  String get confirmForceRescrape => 'Confirm Force Rescrape';

  @override
  String get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'This will delete ALL locally stored repack data and re-download everything from the source. ';

  @override
  String get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'This process can take a very long time and consume significant network data. Are you sure?';

  @override
  String get yesRescrapeAll => 'Yes, Rescrape All';

  @override
  String get startingFullDataRescrape => 'Starting full data rescrape...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'All data has been forcefully rescraped.';

  @override
  String errorMessage(Object error) {
    return 'Error: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'Failed to force rescrape data: $errorMessage';
  }

  @override
  String get forceRescrapingData => 'Force Rescraping Data';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'Downloads & Installation';

  @override
  String get defaultDownloadPath => 'Default Download Path';

  @override
  String get maxConcurrentDownloads => 'Max Concurrent Downloads';

  @override
  String get automaticInstallation => 'Automatic Installation';

  @override
  String get enableAutoInstallAfterDownload =>
      'Enable Auto-Install after download:';

  @override
  String get defaultInstallationPath => 'Default Installation Path';

  @override
  String get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      'When enabled, completed repacks will attempt to install to the specified path.';

  @override
  String get appearance => 'Appearance';

  @override
  String get themeMode => 'Theme mode';

  @override
  String get navigationPaneDisplayMode => 'Navigation Pane Display Mode';

  @override
  String get accentColor => 'Accent Color';

  @override
  String get windowTransparency => 'Window Transparency';

  @override
  String get local => 'Locale';

  @override
  String get applicationUpdates => 'Application Updates';

  @override
  String get updateCheckFrequency => 'Update Check Frequency';

  @override
  String get currentAppVersion => 'Current App Version:';

  @override
  String get loading => 'Loading...';

  @override
  String get latestAvailableVersion => 'Latest Available Version:';

  @override
  String get youAreOnTheLatestVersion => 'You are on the latest version';

  @override
  String get checking => 'Checking...';

  @override
  String get notCheckedYet => ' Not checked yet.';

  @override
  String get checkToSee => ' Check to see.';

  @override
  String get youHaveIgnoredThisUpdate => 'You have ignored this update.';

  @override
  String get unignoreCheckAgain => 'Unignore & Check Again';

  @override
  String get checkForUpdatesNow => 'Check for Updates Now';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'Update to version $version is available';
  }

  @override
  String get downloadAndInstallUpdate => 'Download and Install Update';

  @override
  String get viewReleasePage => 'View Release Page';

  @override
  String get dataManagement => 'Data Management';

  @override
  String get forceRescrapeAllData => 'Force Rescrape All Data';

  @override
  String get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'Warning: This process can take a very long time and consume significant network data. Use with caution.';

  @override
  String get rescrapingSeeDialog => 'Rescraping... See Dialog';

  @override
  String get forceRescrapeAllDataNow => 'Force Rescrape All Data Now';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'Another rescraping process is already running.';

  @override
  String get clearingAllExistingData => 'Clearing all existing data...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'Scraping all repack names (Phase 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      totalPages,
      locale: localeName,
      other: 'pages',
      one: 'page',
    );
    return 'Scraping all repack names (Phase 1/4): Page $page of $totalPages $_temp0';
  }

  @override
  String allRepackNamesScrapedPhase1(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'names',
      one: 'name',
      zero: 'names',
    );
    return 'All repack names scraped. ($count $_temp0 (Phase 1/4 Complete)';
  }

  @override
  String get scrapingDetailsForEveryRepackPhase2LongestPhase =>
      'Scraping details for every repack (Phase 2/4 - Longest Phase)...';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
      Object current, Object total) {
    return 'Scraping details for every repack (Phase 2/4): Repack $current of $total';
  }

  @override
  String allRepackDetailsScrapedPhase2(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'repacks',
      one: 'repack',
      zero: 'repacks',
    );
    return 'All repack details scraped. ($count $_temp0 processed (Phase 2/4 Complete)';
  }

  @override
  String get rescrapingNewRepacksPhase3 =>
      'Rescraping new repacks (Phase 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'Rescraping new repacks (Phase 3/4): Page $current of $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'New repacks rescraped. (Phase 3/4 Complete)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'Rescraping popular repacks (Phase 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'Rescraping popular repacks (Phase 4/4): Item $current of $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'Popular repacks rescraped. (Phase 4/4 Complete)';

  @override
  String get finalizing => 'Finalizing...';

  @override
  String get fullRescrapeCompletedSuccessfully =>
      'Full rescrape completed successfully!';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'Error: $errorMessage. Process halted.';
  }

  @override
  String get daily => 'Daily';

  @override
  String get weekly => 'Weekly';

  @override
  String get manual => 'Manual';

  @override
  String get onEveryStartup => 'On Every Startup';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'No URLs found in the mirror configuration.';

  @override
  String get failedToProcessUnknownPlugin =>
      'Failed to process (Unknown Plugin):';

  @override
  String get problemProcessingSomeLinks => 'Problem processing some links. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'Error processing one or more links. ';

  @override
  String filesAddedToDownloadManager(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'files',
      one: 'file',
      zero: 'files',
    );
    return '$count $_temp0 added to download manager.';
  }

  @override
  String get downloadStarted => 'Download Started';

  @override
  String get ok => 'OK';

  @override
  String get noFilesSelected => 'No Files Selected';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'Please select one or more files from the tree to download.';

  @override
  String get noFilesCouldBeRetrieved => 'No files could be retrieved.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
      Object processingError) {
    return 'Notice: $processingError Some files may have encountered issues.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'No downloadable files found for this mirror.';

  @override
  String downloadFilesGame(Object Game) {
    return 'Download Files: $Game';
  }

  @override
  String get close => 'Close';

  @override
  String get downloadSelected => 'Download Selected';

  @override
  String get aboutGame => 'About game';

  @override
  String get features => 'Features';

  @override
  String get selectDownloadOptions => 'Select download options';

  @override
  String get downloadMethod => 'Download Method:';

  @override
  String get selectMethod => 'Select method';

  @override
  String get mirror => 'Mirror:';

  @override
  String get selectMirror => 'Select mirror';

  @override
  String get downloadLocation => 'Download Location:';

  @override
  String get enterDownloadLocationOrBrowse =>
      'Enter download location or browse';

  @override
  String get downloadLocationEmpty => 'Download Location Empty';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'Please select or enter a download location.';

  @override
  String get selectionIncomplete => 'Selection Incomplete';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'Please select a download method and a mirror.';

  @override
  String get next => 'Next';

  @override
  String get download => 'Download';

  @override
  String get downloadComplete => 'Download complete!';

  @override
  String get downloadPending => 'Download pending...';

  @override
  String get genres => 'Genres';

  @override
  String get company => 'Company';

  @override
  String get language => 'Language';

  @override
  String get originalSize => 'Original Size';

  @override
  String get repackSize => 'Repack Size';

  @override
  String get repackInformation => 'Repack Information';

  @override
  String screenshotsTitle(Object count) {
    return 'Screenshots ($count)';
  }

  @override
  String get errorLoadingImage => 'Error loading image';

  @override
  String get noScreenshotsAvailable => 'No screenshots available.';

  @override
  String get noGenresAvailable => 'No genres available';

  @override
  String get clear => 'Clear';

  @override
  String get filterByGenre => 'Filter by Genre';

  @override
  String get filter => 'Filter';
}
