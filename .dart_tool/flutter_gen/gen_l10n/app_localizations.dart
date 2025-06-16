import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_af.dart';
import 'app_localizations_ar.dart';
import 'app_localizations_ca.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_no.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sr.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('af'),
    Locale('ar'),
    Locale('ca'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('fi'),
    Locale('fr'),
    Locale('he'),
    Locale('hu'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('nl'),
    Locale('no'),
    Locale('pl'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('sr'),
    Locale('sv'),
    Locale('tr'),
    Locale('uk'),
    Locale('vi'),
    Locale('zh')
  ];

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @newAndPopularRepacksHaveBeenRescraped.
  ///
  /// In en, this message translates to:
  /// **'New and Popular repacks have been rescraped.'**
  String get newAndPopularRepacksHaveBeenRescraped;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @failedToRescrapeData.
  ///
  /// In en, this message translates to:
  /// **'Failed to rescrape data: {errorMessage}'**
  String failedToRescrapeData(Object errorMessage);

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @rescrapeNewPopular.
  ///
  /// In en, this message translates to:
  /// **'Rescrape New & Popular'**
  String get rescrapeNewPopular;

  /// No description provided for @newRepacks.
  ///
  /// In en, this message translates to:
  /// **'New Repacks'**
  String get newRepacks;

  /// No description provided for @popularRepacks.
  ///
  /// In en, this message translates to:
  /// **'Popular Repacks'**
  String get popularRepacks;

  /// No description provided for @noCompletedGroupsToClear.
  ///
  /// In en, this message translates to:
  /// **'No completed groups to clear.'**
  String get noCompletedGroupsToClear;

  /// No description provided for @queued.
  ///
  /// In en, this message translates to:
  /// **'Queued'**
  String get queued;

  /// No description provided for @downloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading:'**
  String get downloading;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @paused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get paused;

  /// No description provided for @canceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get canceled;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @confirmClear.
  ///
  /// In en, this message translates to:
  /// **'Confirm Clear'**
  String get confirmClear;

  /// No description provided for @confirmRemoveDownloadGroups.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove {count} completed download {count, plural, zero{groups} one{group} other{groups}}? This will also remove files from disk if they are in dedicated subfolders managed by the app.'**
  String confirmRemoveDownloadGroups(num count);

  /// No description provided for @clearCompleted.
  ///
  /// In en, this message translates to:
  /// **'Clear Completed'**
  String get clearCompleted;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @completedGroupsCleared.
  ///
  /// In en, this message translates to:
  /// **'{count} completed {count, plural, zero{groups} one{group} other{groups}} cleared.'**
  String completedGroupsCleared(num count);

  /// No description provided for @downloadManager.
  ///
  /// In en, this message translates to:
  /// **'Download Manager'**
  String get downloadManager;

  /// No description provided for @maxConcurrent.
  ///
  /// In en, this message translates to:
  /// **'Max Concurrent'**
  String get maxConcurrent;

  /// No description provided for @noActiveDownloads.
  ///
  /// In en, this message translates to:
  /// **'No active downloads.'**
  String get noActiveDownloads;

  /// No description provided for @downloadsWillAppearHereOnceAdded.
  ///
  /// In en, this message translates to:
  /// **'Downloads will appear here once added.'**
  String get downloadsWillAppearHereOnceAdded;

  /// No description provided for @cancelAllDownloadsInThisGroup.
  ///
  /// In en, this message translates to:
  /// **'Cancel all downloads in this group'**
  String get cancelAllDownloadsInThisGroup;

  /// No description provided for @areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel all downloads in this group and remove them?'**
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem;

  /// No description provided for @completedNumberFiles.
  ///
  /// In en, this message translates to:
  /// **'Completed {count} {count, plural, zero{files} one{file} other{files}}'**
  String completedNumberFiles(num count);

  /// No description provided for @overallProgressFilesPercent.
  ///
  /// In en, this message translates to:
  /// **'Overall: {percent}% ({count} {count, plural, one{file} other{files}})'**
  String overallProgressFilesPercent(num count, Object percent);

  /// No description provided for @noActiveTasks.
  ///
  /// In en, this message translates to:
  /// **'No active tasks or progress unavailable ({count} {count, plural, one{file} other{files}})'**
  String noActiveTasks(num count);

  /// No description provided for @cancelGroupName.
  ///
  /// In en, this message translates to:
  /// **'Cancel Group: {groupName}'**
  String cancelGroupName(Object groupName);

  /// No description provided for @removeFromList.
  ///
  /// In en, this message translates to:
  /// **'Remove from list'**
  String get removeFromList;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @errorTaskDataUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Error: Task data unavailable'**
  String get errorTaskDataUnavailable;

  /// No description provided for @unknownFile.
  ///
  /// In en, this message translates to:
  /// **'Unknown File'**
  String get unknownFile;

  /// No description provided for @yesCancelGroup.
  ///
  /// In en, this message translates to:
  /// **'Yes, Cancel Group'**
  String get yesCancelGroup;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @repackLibrary.
  ///
  /// In en, this message translates to:
  /// **'Repack Library'**
  String get repackLibrary;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @noReleaseNotesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No release notes available.'**
  String get noReleaseNotesAvailable;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @updateAvailable.
  ///
  /// In en, this message translates to:
  /// **'Update Available: {version}'**
  String updateAvailable(Object version);

  /// No description provided for @aNewVersionOfFitflutterIsAvailable.
  ///
  /// In en, this message translates to:
  /// **'A new version of FitFlutter is available.'**
  String get aNewVersionOfFitflutterIsAvailable;

  /// No description provided for @viewReleaseNotes.
  ///
  /// In en, this message translates to:
  /// **'View Release Notes'**
  String get viewReleaseNotes;

  /// No description provided for @releasePage.
  ///
  /// In en, this message translates to:
  /// **'Release Page'**
  String get releasePage;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @upgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get upgrade;

  /// No description provided for @downloadsInProgress.
  ///
  /// In en, this message translates to:
  /// **'Downloads in Progress'**
  String get downloadsInProgress;

  /// No description provided for @closingTheApplicationWillCancelAllActiveDownloads.
  ///
  /// In en, this message translates to:
  /// **'Closing the application will cancel all active downloads. '**
  String get closingTheApplicationWillCancelAllActiveDownloads;

  /// No description provided for @areYouSureYouWantToClose.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to close?'**
  String get areYouSureYouWantToClose;

  /// No description provided for @yesCloseCancel.
  ///
  /// In en, this message translates to:
  /// **'Yes, Close & Cancel'**
  String get yesCloseCancel;

  /// No description provided for @userChoseToCloseCancellingDownloads.
  ///
  /// In en, this message translates to:
  /// **'User chose to close; cancelling downloads.'**
  String get userChoseToCloseCancellingDownloads;

  /// No description provided for @keepDownloading.
  ///
  /// In en, this message translates to:
  /// **'Keep Downloading'**
  String get keepDownloading;

  /// No description provided for @startingLibrarySync.
  ///
  /// In en, this message translates to:
  /// **'Starting library sync...'**
  String get startingLibrarySync;

  /// No description provided for @fetchingAllRepackNames.
  ///
  /// In en, this message translates to:
  /// **'Fetching all repack names...'**
  String get fetchingAllRepackNames;

  /// No description provided for @fetchingNamesPages.
  ///
  /// In en, this message translates to:
  /// **'Fetching names: {page} of {totalPages} {totalPages, plural, one{page} other{pages}}'**
  String fetchingNamesPages(num page, num totalPages);

  /// No description provided for @scrapingMissingRepackDetails.
  ///
  /// In en, this message translates to:
  /// **'Scraping missing repack details...'**
  String get scrapingMissingRepackDetails;

  /// No description provided for @thisMayTakeAWhile.
  ///
  /// In en, this message translates to:
  /// **'This may take a while.'**
  String get thisMayTakeAWhile;

  /// No description provided for @scrapingMissingRepackDetailsProgress.
  ///
  /// In en, this message translates to:
  /// **'Scraping details: {current}/{total} missing {total, plural, one{repack} other{repacks}}'**
  String scrapingMissingRepackDetailsProgress(num current, num total);

  /// No description provided for @repackLibrarySynchronized.
  ///
  /// In en, this message translates to:
  /// **'Repack library synchronized.'**
  String get repackLibrarySynchronized;

  /// No description provided for @failedToSyncLibrary.
  ///
  /// In en, this message translates to:
  /// **'Failed to sync library: {errorMessage}'**
  String failedToSyncLibrary(Object errorMessage);

  /// No description provided for @syncLibrary.
  ///
  /// In en, this message translates to:
  /// **'Sync Library'**
  String get syncLibrary;

  /// No description provided for @syncingLibrary.
  ///
  /// In en, this message translates to:
  /// **'Syncing Library...'**
  String get syncingLibrary;

  /// No description provided for @noRepacksFoundInTheLibrary.
  ///
  /// In en, this message translates to:
  /// **'No repacks found in the library.'**
  String get noRepacksFoundInTheLibrary;

  /// No description provided for @noRepacksFoundMatchingSearch.
  ///
  /// In en, this message translates to:
  /// **'No repacks found matching {search}.'**
  String noRepacksFoundMatchingSearch(Object search);

  /// No description provided for @theWindowIsTooNarrowToDisplayItemsCorrectly.
  ///
  /// In en, this message translates to:
  /// **'The window is too narrow to display items correctly.'**
  String get theWindowIsTooNarrowToDisplayItemsCorrectly;

  /// No description provided for @pleaseResizeTheWindow.
  ///
  /// In en, this message translates to:
  /// **'Please resize the window.'**
  String get pleaseResizeTheWindow;

  /// No description provided for @repackUrlIsNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Repack URL is not available.'**
  String get repackUrlIsNotAvailable;

  /// No description provided for @couldNotLaunchUrl.
  ///
  /// In en, this message translates to:
  /// **'Could not launch URL: {error}'**
  String couldNotLaunchUrl(Object error);

  /// No description provided for @couldNotLaunch.
  ///
  /// In en, this message translates to:
  /// **'Could not launch: {url}'**
  String couldNotLaunch(Object url);

  /// No description provided for @invalidUrlFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid URL format: {url}'**
  String invalidUrlFormat(Object url);

  /// No description provided for @rescrapeDetails.
  ///
  /// In en, this message translates to:
  /// **'Rescrape Details'**
  String get rescrapeDetails;

  /// No description provided for @detailsHaveBeenRescraped.
  ///
  /// In en, this message translates to:
  /// **'Details for {title} have been rescraped and updated.'**
  String detailsHaveBeenRescraped(Object title);

  /// No description provided for @failedToRescrapeDetails.
  ///
  /// In en, this message translates to:
  /// **'Failed to rescrape details: {errorMessage}'**
  String failedToRescrapeDetails(Object errorMessage);

  /// No description provided for @errorRescraping.
  ///
  /// In en, this message translates to:
  /// **'Error Rescraping'**
  String get errorRescraping;

  /// No description provided for @openSourcePage.
  ///
  /// In en, this message translates to:
  /// **'Open Source Page'**
  String get openSourcePage;

  /// No description provided for @noPopularNewRepacksFound.
  ///
  /// In en, this message translates to:
  /// **'No {type} repacks found.'**
  String noPopularNewRepacksFound(Object type);

  /// No description provided for @newest.
  ///
  /// In en, this message translates to:
  /// **'new'**
  String get newest;

  /// No description provided for @popular.
  ///
  /// In en, this message translates to:
  /// **'popular'**
  String get popular;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @yellow.
  ///
  /// In en, this message translates to:
  /// **'Yellow'**
  String get yellow;

  /// No description provided for @orange.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get orange;

  /// No description provided for @red.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get red;

  /// No description provided for @magenta.
  ///
  /// In en, this message translates to:
  /// **'Magenta'**
  String get magenta;

  /// No description provided for @purple.
  ///
  /// In en, this message translates to:
  /// **'Purple'**
  String get purple;

  /// No description provided for @blue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get blue;

  /// No description provided for @teal.
  ///
  /// In en, this message translates to:
  /// **'Teal'**
  String get teal;

  /// No description provided for @green.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get green;

  /// No description provided for @confirmForceRescrape.
  ///
  /// In en, this message translates to:
  /// **'Confirm Force Rescrape'**
  String get confirmForceRescrape;

  /// No description provided for @thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource.
  ///
  /// In en, this message translates to:
  /// **'This will delete ALL locally stored repack data and re-download everything from the source. '**
  String
      get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource;

  /// No description provided for @thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure.
  ///
  /// In en, this message translates to:
  /// **'This process can take a very long time and consume significant network data. Are you sure?'**
  String
      get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure;

  /// No description provided for @yesRescrapeAll.
  ///
  /// In en, this message translates to:
  /// **'Yes, Rescrape All'**
  String get yesRescrapeAll;

  /// No description provided for @startingFullDataRescrape.
  ///
  /// In en, this message translates to:
  /// **'Starting full data rescrape...'**
  String get startingFullDataRescrape;

  /// No description provided for @allDataHasBeenForcefullyRescraped.
  ///
  /// In en, this message translates to:
  /// **'All data has been forcefully rescraped.'**
  String get allDataHasBeenForcefullyRescraped;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorMessage(Object error);

  /// No description provided for @failedToForceRescrapeData.
  ///
  /// In en, this message translates to:
  /// **'Failed to force rescrape data: {errorMessage}'**
  String failedToForceRescrapeData(Object errorMessage);

  /// No description provided for @forceRescrapingData.
  ///
  /// In en, this message translates to:
  /// **'Force Rescraping Data'**
  String get forceRescrapingData;

  /// No description provided for @percentComplete.
  ///
  /// In en, this message translates to:
  /// **'{percentComplete}% Complete'**
  String percentComplete(Object percentComplete);

  /// No description provided for @downloadsInstallation.
  ///
  /// In en, this message translates to:
  /// **'Downloads & Installation'**
  String get downloadsInstallation;

  /// No description provided for @defaultDownloadPath.
  ///
  /// In en, this message translates to:
  /// **'Default Download Path'**
  String get defaultDownloadPath;

  /// No description provided for @maxConcurrentDownloads.
  ///
  /// In en, this message translates to:
  /// **'Max Concurrent Downloads'**
  String get maxConcurrentDownloads;

  /// No description provided for @automaticInstallation.
  ///
  /// In en, this message translates to:
  /// **'Automatic Installation'**
  String get automaticInstallation;

  /// No description provided for @enableAutoInstallAfterDownload.
  ///
  /// In en, this message translates to:
  /// **'Enable Auto-Install after download:'**
  String get enableAutoInstallAfterDownload;

  /// No description provided for @defaultInstallationPath.
  ///
  /// In en, this message translates to:
  /// **'Default Installation Path'**
  String get defaultInstallationPath;

  /// No description provided for @whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath.
  ///
  /// In en, this message translates to:
  /// **'When enabled, completed repacks will attempt to install to the specified path.'**
  String get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get themeMode;

  /// No description provided for @navigationPaneDisplayMode.
  ///
  /// In en, this message translates to:
  /// **'Navigation Pane Display Mode'**
  String get navigationPaneDisplayMode;

  /// No description provided for @accentColor.
  ///
  /// In en, this message translates to:
  /// **'Accent Color'**
  String get accentColor;

  /// No description provided for @windowTransparency.
  ///
  /// In en, this message translates to:
  /// **'Window Transparency'**
  String get windowTransparency;

  /// No description provided for @local.
  ///
  /// In en, this message translates to:
  /// **'Locale'**
  String get local;

  /// No description provided for @applicationUpdates.
  ///
  /// In en, this message translates to:
  /// **'Application Updates'**
  String get applicationUpdates;

  /// No description provided for @updateCheckFrequency.
  ///
  /// In en, this message translates to:
  /// **'Update Check Frequency'**
  String get updateCheckFrequency;

  /// No description provided for @currentAppVersion.
  ///
  /// In en, this message translates to:
  /// **'Current App Version:'**
  String get currentAppVersion;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @latestAvailableVersion.
  ///
  /// In en, this message translates to:
  /// **'Latest Available Version:'**
  String get latestAvailableVersion;

  /// No description provided for @youAreOnTheLatestVersion.
  ///
  /// In en, this message translates to:
  /// **'You are on the latest version'**
  String get youAreOnTheLatestVersion;

  /// No description provided for @checking.
  ///
  /// In en, this message translates to:
  /// **'Checking...'**
  String get checking;

  /// No description provided for @notCheckedYet.
  ///
  /// In en, this message translates to:
  /// **' Not checked yet.'**
  String get notCheckedYet;

  /// No description provided for @checkToSee.
  ///
  /// In en, this message translates to:
  /// **' Check to see.'**
  String get checkToSee;

  /// No description provided for @youHaveIgnoredThisUpdate.
  ///
  /// In en, this message translates to:
  /// **'You have ignored this update.'**
  String get youHaveIgnoredThisUpdate;

  /// No description provided for @unignoreCheckAgain.
  ///
  /// In en, this message translates to:
  /// **'Unignore & Check Again'**
  String get unignoreCheckAgain;

  /// No description provided for @checkForUpdatesNow.
  ///
  /// In en, this message translates to:
  /// **'Check for Updates Now'**
  String get checkForUpdatesNow;

  /// No description provided for @updateToVersionIsAvaible.
  ///
  /// In en, this message translates to:
  /// **'Update to version {version} is available'**
  String updateToVersionIsAvaible(Object version);

  /// No description provided for @downloadAndInstallUpdate.
  ///
  /// In en, this message translates to:
  /// **'Download and Install Update'**
  String get downloadAndInstallUpdate;

  /// No description provided for @viewReleasePage.
  ///
  /// In en, this message translates to:
  /// **'View Release Page'**
  String get viewReleasePage;

  /// No description provided for @dataManagement.
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get dataManagement;

  /// No description provided for @forceRescrapeAllData.
  ///
  /// In en, this message translates to:
  /// **'Force Rescrape All Data'**
  String get forceRescrapeAllData;

  /// No description provided for @warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution.
  ///
  /// In en, this message translates to:
  /// **'Warning: This process can take a very long time and consume significant network data. Use with caution.'**
  String
      get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution;

  /// No description provided for @rescrapingSeeDialog.
  ///
  /// In en, this message translates to:
  /// **'Rescraping... See Dialog'**
  String get rescrapingSeeDialog;

  /// No description provided for @forceRescrapeAllDataNow.
  ///
  /// In en, this message translates to:
  /// **'Force Rescrape All Data Now'**
  String get forceRescrapeAllDataNow;

  /// No description provided for @anotherRescrapingProcessIsAlreadyRunning.
  ///
  /// In en, this message translates to:
  /// **'Another rescraping process is already running.'**
  String get anotherRescrapingProcessIsAlreadyRunning;

  /// No description provided for @clearingAllExistingData.
  ///
  /// In en, this message translates to:
  /// **'Clearing all existing data...'**
  String get clearingAllExistingData;

  /// No description provided for @scrapingAllRepackNamesPhase1.
  ///
  /// In en, this message translates to:
  /// **'Scraping all repack names (Phase 1/4)...'**
  String get scrapingAllRepackNamesPhase1;

  /// No description provided for @scrapingAllRepackNamesPhase1Progress.
  ///
  /// In en, this message translates to:
  /// **'Scraping all repack names (Phase 1/4): Page {page} of {totalPages} {totalPages, plural, one{page} other{pages}}'**
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages);

  /// No description provided for @allRepackNamesScrapedPhase1.
  ///
  /// In en, this message translates to:
  /// **'All repack names scraped. ({count} {count, plural, zero{names} one{name} other{names}} (Phase 1/4 Complete)'**
  String allRepackNamesScrapedPhase1(num count);

  /// No description provided for @scrapingDetailsForEveryRepackPhase2LongestPhase.
  ///
  /// In en, this message translates to:
  /// **'Scraping details for every repack (Phase 2/4 - Longest Phase)...'**
  String get scrapingDetailsForEveryRepackPhase2LongestPhase;

  /// No description provided for @scrapingDetailsForEveryRepackPhase2Progress.
  ///
  /// In en, this message translates to:
  /// **'Scraping details for every repack (Phase 2/4): Repack {current} of {total}'**
  String scrapingDetailsForEveryRepackPhase2Progress(
      Object current, Object total);

  /// No description provided for @allRepackDetailsScrapedPhase2.
  ///
  /// In en, this message translates to:
  /// **'All repack details scraped. ({count} {count, plural, zero{repacks} one{repack} other{repacks}} processed (Phase 2/4 Complete)'**
  String allRepackDetailsScrapedPhase2(num count);

  /// No description provided for @rescrapingNewRepacksPhase3.
  ///
  /// In en, this message translates to:
  /// **'Rescraping new repacks (Phase 3/4)...'**
  String get rescrapingNewRepacksPhase3;

  /// No description provided for @rescrapingNewRepacksPhase3Progress.
  ///
  /// In en, this message translates to:
  /// **'Rescraping new repacks (Phase 3/4): Page {current} of {total}'**
  String rescrapingNewRepacksPhase3Progress(Object current, Object total);

  /// No description provided for @newRepacksRescrapedPhase3Complete.
  ///
  /// In en, this message translates to:
  /// **'New repacks rescraped. (Phase 3/4 Complete)'**
  String get newRepacksRescrapedPhase3Complete;

  /// No description provided for @rescrapingPopularRepacksPhase4.
  ///
  /// In en, this message translates to:
  /// **'Rescraping popular repacks (Phase 4/4)...'**
  String get rescrapingPopularRepacksPhase4;

  /// No description provided for @rescrapingPopularRepacksPhase4Progress.
  ///
  /// In en, this message translates to:
  /// **'Rescraping popular repacks (Phase 4/4): Item {current} of {total}'**
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total);

  /// No description provided for @popularRepacksRescrapedPhase4Complete.
  ///
  /// In en, this message translates to:
  /// **'Popular repacks rescraped. (Phase 4/4 Complete)'**
  String get popularRepacksRescrapedPhase4Complete;

  /// No description provided for @finalizing.
  ///
  /// In en, this message translates to:
  /// **'Finalizing...'**
  String get finalizing;

  /// No description provided for @fullRescrapeCompletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Full rescrape completed successfully!'**
  String get fullRescrapeCompletedSuccessfully;

  /// No description provided for @errorProcessHalted.
  ///
  /// In en, this message translates to:
  /// **'Error: {errorMessage}. Process halted.'**
  String errorProcessHalted(Object errorMessage);

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @manual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get manual;

  /// No description provided for @onEveryStartup.
  ///
  /// In en, this message translates to:
  /// **'On Every Startup'**
  String get onEveryStartup;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @noUrlsFoundInTheMirrorConfiguration.
  ///
  /// In en, this message translates to:
  /// **'No URLs found in the mirror configuration.'**
  String get noUrlsFoundInTheMirrorConfiguration;

  /// No description provided for @failedToProcessUnknownPlugin.
  ///
  /// In en, this message translates to:
  /// **'Failed to process (Unknown Plugin):'**
  String get failedToProcessUnknownPlugin;

  /// No description provided for @problemProcessingSomeLinks.
  ///
  /// In en, this message translates to:
  /// **'Problem processing some links. '**
  String get problemProcessingSomeLinks;

  /// No description provided for @errorProcessingOneOrMoreLinks.
  ///
  /// In en, this message translates to:
  /// **'Error processing one or more links. '**
  String get errorProcessingOneOrMoreLinks;

  /// No description provided for @filesAddedToDownloadManager.
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, zero{files} one{file} other{files}} added to download manager.'**
  String filesAddedToDownloadManager(num count);

  /// No description provided for @downloadStarted.
  ///
  /// In en, this message translates to:
  /// **'Download Started'**
  String get downloadStarted;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @noFilesSelected.
  ///
  /// In en, this message translates to:
  /// **'No Files Selected'**
  String get noFilesSelected;

  /// No description provided for @pleaseSelectOneOrMoreFilesFromTheTreeToDownload.
  ///
  /// In en, this message translates to:
  /// **'Please select one or more files from the tree to download.'**
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload;

  /// No description provided for @noFilesCouldBeRetrieved.
  ///
  /// In en, this message translates to:
  /// **'No files could be retrieved.'**
  String get noFilesCouldBeRetrieved;

  /// No description provided for @noticeProcessingErrorSomeFilesMayHaveEncounteredIssues.
  ///
  /// In en, this message translates to:
  /// **'Notice: {processingError} Some files may have encountered issues.'**
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
      Object processingError);

  /// No description provided for @noDownloadableFilesFoundForThisMirror.
  ///
  /// In en, this message translates to:
  /// **'No downloadable files found for this mirror.'**
  String get noDownloadableFilesFoundForThisMirror;

  /// No description provided for @downloadFilesGame.
  ///
  /// In en, this message translates to:
  /// **'Download Files: {Game}'**
  String downloadFilesGame(Object Game);

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @downloadSelected.
  ///
  /// In en, this message translates to:
  /// **'Download Selected'**
  String get downloadSelected;

  /// No description provided for @aboutGame.
  ///
  /// In en, this message translates to:
  /// **'About game'**
  String get aboutGame;

  /// No description provided for @features.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get features;

  /// No description provided for @selectDownloadOptions.
  ///
  /// In en, this message translates to:
  /// **'Select download options'**
  String get selectDownloadOptions;

  /// No description provided for @downloadMethod.
  ///
  /// In en, this message translates to:
  /// **'Download Method:'**
  String get downloadMethod;

  /// No description provided for @selectMethod.
  ///
  /// In en, this message translates to:
  /// **'Select method'**
  String get selectMethod;

  /// No description provided for @mirror.
  ///
  /// In en, this message translates to:
  /// **'Mirror:'**
  String get mirror;

  /// No description provided for @selectMirror.
  ///
  /// In en, this message translates to:
  /// **'Select mirror'**
  String get selectMirror;

  /// No description provided for @downloadLocation.
  ///
  /// In en, this message translates to:
  /// **'Download Location:'**
  String get downloadLocation;

  /// No description provided for @enterDownloadLocationOrBrowse.
  ///
  /// In en, this message translates to:
  /// **'Enter download location or browse'**
  String get enterDownloadLocationOrBrowse;

  /// No description provided for @downloadLocationEmpty.
  ///
  /// In en, this message translates to:
  /// **'Download Location Empty'**
  String get downloadLocationEmpty;

  /// No description provided for @pleaseSelectOrEnterADownloadLocation.
  ///
  /// In en, this message translates to:
  /// **'Please select or enter a download location.'**
  String get pleaseSelectOrEnterADownloadLocation;

  /// No description provided for @selectionIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Selection Incomplete'**
  String get selectionIncomplete;

  /// No description provided for @pleaseSelectADownloadMethodAndAMirror.
  ///
  /// In en, this message translates to:
  /// **'Please select a download method and a mirror.'**
  String get pleaseSelectADownloadMethodAndAMirror;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @downloadComplete.
  ///
  /// In en, this message translates to:
  /// **'Download complete!'**
  String get downloadComplete;

  /// No description provided for @downloadPending.
  ///
  /// In en, this message translates to:
  /// **'Download pending...'**
  String get downloadPending;

  /// No description provided for @genres.
  ///
  /// In en, this message translates to:
  /// **'Genres'**
  String get genres;

  /// No description provided for @company.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get company;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @originalSize.
  ///
  /// In en, this message translates to:
  /// **'Original Size'**
  String get originalSize;

  /// No description provided for @repackSize.
  ///
  /// In en, this message translates to:
  /// **'Repack Size'**
  String get repackSize;

  /// No description provided for @repackInformation.
  ///
  /// In en, this message translates to:
  /// **'Repack Information'**
  String get repackInformation;

  /// No description provided for @screenshotsTitle.
  ///
  /// In en, this message translates to:
  /// **'Screenshots ({count})'**
  String screenshotsTitle(Object count);

  /// No description provided for @errorLoadingImage.
  ///
  /// In en, this message translates to:
  /// **'Error loading image'**
  String get errorLoadingImage;

  /// No description provided for @noScreenshotsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No screenshots available.'**
  String get noScreenshotsAvailable;

  /// No description provided for @noGenresAvailable.
  ///
  /// In en, this message translates to:
  /// **'No genres available'**
  String get noGenresAvailable;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @filterByGenre.
  ///
  /// In en, this message translates to:
  /// **'Filter by Genre'**
  String get filterByGenre;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'af',
        'ar',
        'ca',
        'cs',
        'da',
        'de',
        'el',
        'en',
        'es',
        'fi',
        'fr',
        'he',
        'hu',
        'it',
        'ja',
        'ko',
        'nl',
        'no',
        'pl',
        'pt',
        'ro',
        'ru',
        'sr',
        'sv',
        'tr',
        'uk',
        'vi',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return AppLocalizationsAf();
    case 'ar':
      return AppLocalizationsAr();
    case 'ca':
      return AppLocalizationsCa();
    case 'cs':
      return AppLocalizationsCs();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fi':
      return AppLocalizationsFi();
    case 'fr':
      return AppLocalizationsFr();
    case 'he':
      return AppLocalizationsHe();
    case 'hu':
      return AppLocalizationsHu();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'nl':
      return AppLocalizationsNl();
    case 'no':
      return AppLocalizationsNo();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'sr':
      return AppLocalizationsSr();
    case 'sv':
      return AppLocalizationsSv();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
