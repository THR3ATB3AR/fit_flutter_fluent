// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get success => 'Επιτυχία';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'Νέες και δημοφιλείς επισκευές έχουν αναστηλωθεί.';

  @override
  String get error => 'Σφάλμα';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'Failed to rescrape data: $errorMessage';
  }

  @override
  String get home => 'Αρχική';

  @override
  String get rescrapeNewPopular => 'Rescrape Νέο & Δημοφιλές';

  @override
  String get newRepacks => 'Νέα Πακέτα';

  @override
  String get popularRepacks => 'Δημοφιλή Repacks';

  @override
  String get noCompletedGroupsToClear =>
      'Δεν υπάρχουν ολοκληρωμένες ομάδες για να καθαρίσετε.';

  @override
  String get queued => 'Σε Αναμονή';

  @override
  String get downloading => 'Λήψη:';

  @override
  String get completed => 'Ολοκληρώθηκε';

  @override
  String get failed => 'Απέτυχε';

  @override
  String get paused => 'Παύση';

  @override
  String get canceled => 'Ακυρώθηκε';

  @override
  String get dismiss => 'Απόρριψη';

  @override
  String get confirmClear => 'Επιβεβαίωση Καθαρισμού';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ομάδες',
      one: 'ομάδα',
      zero: 'ομάδες',
    );
    return 'Είστε βέβαιοι ότι θέλετε να αφαιρέσετε $count ολοκληρωμένη λήψη $_temp0? Αυτό θα αφαιρέσει επίσης αρχεία από το δίσκο αν βρίσκονται σε ειδικούς υποφακέλους που διαχειρίζεται η εφαρμογή.';
  }

  @override
  String get clearCompleted => 'Εκκαθάριση Ολοκληρωμένων';

  @override
  String get cancel => 'Ακύρωση';

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
  String get downloadManager => 'Διαχειριστής Λήψεων';

  @override
  String get maxConcurrent => 'Μέγιστη Ταυτόχρονη';

  @override
  String get noActiveDownloads => 'Δεν υπάρχουν ενεργές λήψεις';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'Οι λήψεις θα εμφανιστούν εδώ μόλις προστεθούν.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'Ακύρωση όλων των λήψεων σε αυτήν την ομάδα';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'Είστε βέβαιοι ότι θέλετε να ακυρώσετε όλες τις λήψεις σε αυτή την ομάδα και να τις αφαιρέσετε?';

  @override
  String completedNumberFiles(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'αρχεία',
      one: 'αρχείο',
      zero: 'αρχεία',
    );
    return 'Ολοκληρώθηκε $count $_temp0';
  }

  @override
  String overallProgressFilesPercent(num count, Object percent) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'αρχεία',
      one: 'αρχείο',
    );
    return 'Συνολικά: $percent% ($count $_temp0';
  }

  @override
  String noActiveTasks(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'αρχεία',
      one: 'αρχείο',
    );
    return 'Καμία ενεργή εργασία ή πρόοδος δεν είναι διαθέσιμη ($count $_temp0';
  }

  @override
  String cancelGroupName(Object groupName) {
    return 'Cancel Group: $groupName';
  }

  @override
  String get removeFromList => 'Αφαίρεση από τη λίστα';

  @override
  String get resume => 'Συνέχιση';

  @override
  String get pause => 'Παύση';

  @override
  String get errorTaskDataUnavailable =>
      'Σφάλμα: Μη διαθέσιμα δεδομένα εργασίας';

  @override
  String get unknownFile => 'Άγνωστο Αρχείο';

  @override
  String get yesCancelGroup => 'Ναι, Ακύρωση Ομάδας';

  @override
  String get no => 'Όχι';

  @override
  String get repackLibrary => 'Επαναφόρτιση Βιβλιοθήκης';

  @override
  String get settings => 'Ρυθμίσεις';

  @override
  String get unknown => 'Άγνωστο';

  @override
  String get noReleaseNotesAvailable => 'Μη διαθέσιμες σημειώσεις έκδοσης.';

  @override
  String get search => 'Αναζήτηση';

  @override
  String updateAvailable(Object version) {
    return 'Διαθέσιμη Ενημέρωση: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'Μια νέα έκδοση του FitFlutter είναι διαθέσιμη.';

  @override
  String get viewReleaseNotes => 'Προβολή Σημειώσεων Έκδοσης';

  @override
  String get releasePage => 'Σελίδα Κυκλοφορίας';

  @override
  String get later => 'Αργότερα';

  @override
  String get upgrade => 'Αναβάθμιση';

  @override
  String get downloadsInProgress => 'Λήψεις σε εξέλιξη';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'Κλείσιμο της εφαρμογής θα ακυρώσει όλες τις ενεργές λήψεις. ';

  @override
  String get areYouSureYouWantToClose =>
      'Είστε βέβαιοι ότι θέλετε να κλείσετε?';

  @override
  String get yesCloseCancel => 'Ναι, Κλείσιμο & Ακύρωση';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'Ο χρήστης επέλεξε να κλείσει· ακύρωση λήψεων.';

  @override
  String get keepDownloading => 'Διατήρηση Λήψης';

  @override
  String get startingLibrarySync => 'Έναρξη συγχρονισμού βιβλιοθήκης...';

  @override
  String get fetchingAllRepackNames =>
      'Λήψη όλων των ονομάτων επανασυσκευασίας...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'σελίδες',
      one: 'σελίδα',
    );
    return 'Λήψη ονομάτων: $page από $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails =>
      'Απόκλιση λείπει repack λεπτομέρειες...';

  @override
  String get thisMayTakeAWhile => 'Αυτό μπορεί να διαρκέσει λίγο.';

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
  String get repackLibrarySynchronized => 'Συγχρονισμός βιβλιοθήκης Repack.';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'Failed to sync library: $errorMessage';
  }

  @override
  String get syncLibrary => 'Συγχρονισμός Βιβλιοθήκης';

  @override
  String get syncingLibrary => 'Συγχρονισμός Βιβλιοθήκης...';

  @override
  String get noRepacksFoundInTheLibrary =>
      'Δεν βρέθηκαν επισκευές στη βιβλιοθήκη.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'Δεν βρέθηκαν επισκευές που να ταιριάζουν με $search.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'Το παράθυρο είναι πολύ στενό για να εμφανίζονται σωστά τα αντικείμενα.';

  @override
  String get pleaseResizeTheWindow =>
      'Παρακαλώ αλλάξτε το μέγεθος του παραθύρου.';

  @override
  String get repackUrlIsNotAvailable => 'Το URL Repack δεν είναι διαθέσιμο.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'Δεν ήταν δυνατή η εκκίνηση του URL: $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return 'Could not launch: $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return 'Μη έγκυρη μορφή URL: $url';
  }

  @override
  String get rescrapeDetails => 'Λεπτομέρειες Rescrape';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return 'Λεπτομέρειες για το $title έχουν ανασχηματιστεί και ενημερωθεί.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'Failed to rescrape details: $errorMessage';
  }

  @override
  String get errorRescraping => 'Σφάλμα Rescraping';

  @override
  String get openSourcePage => 'Σελίδα Ανοιχτού Κώδικα';

  @override
  String noPopularNewRepacksFound(Object type) {
    return 'Δεν βρέθηκαν $type repacks.';
  }

  @override
  String get newest => 'νέο';

  @override
  String get popular => 'δημοφιλής';

  @override
  String get system => 'Σύστημα';

  @override
  String get yellow => 'Κίτρινο';

  @override
  String get orange => 'Πορτοκαλί';

  @override
  String get red => 'Κόκκινο';

  @override
  String get magenta => 'Ματζέντα';

  @override
  String get purple => 'Μωβ';

  @override
  String get blue => 'Μπλε';

  @override
  String get teal => 'Τιρκουάζ';

  @override
  String get green => 'Πράσινο';

  @override
  String get confirmForceRescrape => 'Επιβεβαίωση Ανασυγκρότησης';

  @override
  String
  get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'Αυτό θα διαγράψει ΟΛΑ τα αποθηκευμένα τοπικά δεδομένα επανασυσκευασίας και θα τα κατεβάσετε ξανά από την πηγή. ';

  @override
  String
  get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'Αυτή η διαδικασία μπορεί να διαρκέσει πολύ καιρό και να καταναλώνουν σημαντικά δεδομένα δικτύου. Είστε σίγουροι?';

  @override
  String get yesRescrapeAll => 'Ναι, Rescrape Όλα';

  @override
  String get startingFullDataRescrape =>
      'Έναρξη πλήρους ανάπαυσης δεδομένων...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'Όλα τα δεδομένα έχουν ανασχηματιστεί δυναμικά.';

  @override
  String errorMessage(Object error) {
    return 'Error: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'Failed to force rescrape data: $errorMessage';
  }

  @override
  String get forceRescrapingData => 'Εξαναγκασμός Ανασυγκρότησης Δεδομένων';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'Λήψεις & Εγκατάσταση';

  @override
  String get defaultDownloadPath => 'Προεπιλεγμένη Διαδρομή Λήψεων';

  @override
  String get maxConcurrentDownloads => 'Μέγιστες Ταυτόχρονες Λήψεις';

  @override
  String get automaticInstallation => 'Αυτόματη Εγκατάσταση';

  @override
  String get enableAutoInstallAfterDownload =>
      'Ενεργοποίηση αυτόματης εγκατάστασης μετά τη λήψη:';

  @override
  String get defaultInstallationPath => 'Προεπιλεγμένη Διαδρομή Εγκατάστασης';

  @override
  String
  get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      'Όταν ενεργοποιηθεί, οι ολοκληρωμένες επισκευές θα προσπαθήσουν να εγκαταστήσουν στην καθορισμένη διαδρομή.';

  @override
  String get appearance => 'Εμφάνιση';

  @override
  String get themeMode => 'Λειτουργία θέματος';

  @override
  String get navigationPaneDisplayMode =>
      'Λειτουργία Προβολής Πίνακα Πλοήγησης';

  @override
  String get accentColor => 'Χρώμα Έμφασης';

  @override
  String get windowTransparency => 'Διαφάνεια Παραθύρου';

  @override
  String get local => 'Τοπική';

  @override
  String get applicationUpdates => 'Ενημερώσεις Εφαρμογών';

  @override
  String get updateCheckFrequency => 'Συχνότητα Ελέγχου Ενημερώσεων';

  @override
  String get currentAppVersion => 'Τρέχουσα Έκδοση Εφαρμογής:';

  @override
  String get loading => 'Φόρτωση...';

  @override
  String get latestAvailableVersion => 'Τελευταία Διαθέσιμη Έκδοση:';

  @override
  String get youAreOnTheLatestVersion => 'Είστε στην τελευταία έκδοση';

  @override
  String get checking => 'Έλεγχος...';

  @override
  String get notCheckedYet => ' Δεν έχει ελεγχθεί ακόμα.';

  @override
  String get checkToSee => ' Επιλέξτε για να δείτε.';

  @override
  String get youHaveIgnoredThisUpdate => 'Αγνοήσατε αυτήν την ενημέρωση.';

  @override
  String get unignoreCheckAgain => 'Unignore & Έλεγχος Ξανά';

  @override
  String get checkForUpdatesNow => 'Έλεγχος για ενημερώσεις τώρα';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'Η ενημέρωση στην έκδοση $version είναι διαθέσιμη';
  }

  @override
  String get downloadAndInstallUpdate => 'Λήψη και εγκατάσταση ενημέρωσης';

  @override
  String get viewReleasePage => 'Προβολή Σελίδας Κυκλοφορίας';

  @override
  String get dataManagement => 'Διαχείριση Δεδομένων';

  @override
  String get forceRescrapeAllData => 'Εξαναγκασμός Rescrape Όλων Των Δεδομένων';

  @override
  String
  get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'Προειδοποίηση: Αυτή η διαδικασία μπορεί να διαρκέσει πολύ καιρό και να καταναλώσει σημαντικά δεδομένα δικτύου. Χρησιμοποιήστε τα με προσοχή.';

  @override
  String get rescrapingSeeDialog => 'Επανεκκίνηση... Δείτε Το Διάλογο';

  @override
  String get forceRescrapeAllDataNow =>
      'Εξαναγκασμός Rescrape Όλα Τα Δεδομένα Τώρα';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'Μια άλλη διαδικασία αναβίωσης εκτελείται ήδη.';

  @override
  String get clearingAllExistingData =>
      'Εκκαθάριση όλων των υπαρχόντων δεδομένων...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'Ξύσιμο όλων των ονομάτων repack (Φάση 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'σελίδες',
      one: 'σελίδα',
    );
    return 'Αποξύπνημα όλων των ονομάτων repack (Φάση 1/4): Σελίδα $page του $totalPages $_temp0';
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
      'Λεπτομέρειες απόξεσης για κάθε επανασυσκευασία (Φάση 2/4 - Μεγαλύτερη φάση)...';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
    Object current,
    Object total,
  ) {
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
      'Αναζωογόνηση νέων επισκευών (Φάση 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'Αναβίωση νέων επισκευών (Φάση 3/4): Page $current of $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'Νέες επισκευές που έχουν υποστεί ανάμιξη. (Φάση 3/4)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'Αναζωογόνηση δημοφιλών επισκευών (Φάση 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'Rescraping popular repacks (Phase 4/4): Item $current of $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'Δημοφιλείς επισκευές που έχουν αναχιαστεί. (Φάση 4/4 Πλήρης)';

  @override
  String get finalizing => 'Ολοκλήρωση...';

  @override
  String get fullRescrapeCompletedSuccessfully =>
      'Πλήρης rescrape ολοκληρώθηκε με επιτυχία!';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'Error: $errorMessage. Process halted.';
  }

  @override
  String get daily => 'Καθημερινά';

  @override
  String get weekly => 'Εβδομαδιαία';

  @override
  String get manual => 'Χειροκίνητα';

  @override
  String get onEveryStartup => 'Σε Κάθε Εκκίνηση';

  @override
  String get light => 'Φωτεινό';

  @override
  String get dark => 'Σκοτεινό';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'Δεν βρέθηκαν διευθύνσεις URL στις ρυθμίσεις ειδώλου.';

  @override
  String get failedToProcessUnknownPlugin =>
      'Αποτυχία επεξεργασίας (Άγνωστο Πρόσθετο):';

  @override
  String get problemProcessingSomeLinks =>
      'Πρόβλημα επεξεργασίας ορισμένων συνδέσεων. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'Σφάλμα κατά την επεξεργασία ενός ή περισσότερων συνδέσμων. ';

  @override
  String filesAddedToDownloadManager(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'αρχεία',
      one: 'αρχείο',
      zero: 'αρχεία',
    );
    return '$count $_temp0 προστέθηκαν στο διαχειριστή λήψης.';
  }

  @override
  String get downloadStarted => 'Η Λήψη Ξεκίνησε';

  @override
  String get ok => 'Εντάξει';

  @override
  String get noFilesSelected => 'Δεν Επιλέχθηκαν Αρχεία';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'Παρακαλώ επιλέξτε ένα ή περισσότερα αρχεία από το δέντρο για λήψη.';

  @override
  String get noFilesCouldBeRetrieved => 'Δεν ήταν δυνατή η ανάκτηση αρχείων.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
    Object processingError,
  ) {
    return 'Notice: $processingError Some files may have encountered issues.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'Δεν βρέθηκαν αρχεία με δυνατότητα λήψης για αυτόν τον καθρέφτη.';

  @override
  String downloadFilesGame(Object Game) {
    return 'Download Files: $Game';
  }

  @override
  String get close => 'Κλείσιμο';

  @override
  String get downloadSelected => 'Λήψη Επιλεγμένων';

  @override
  String get aboutGame => 'Σχετικά με το παιχνίδι';

  @override
  String get features => 'Χαρακτηριστικά';

  @override
  String get selectDownloadOptions => 'Επιλέξτε επιλογές λήψης';

  @override
  String get downloadMethod => 'Μέθοδος Λήψης:';

  @override
  String get selectMethod => 'Επιλογή μεθόδου';

  @override
  String get mirror => 'Καθρέφτης:';

  @override
  String get selectMirror => 'Επιλογή καθρέφτη';

  @override
  String get downloadLocation => 'Τοποθεσία Λήψης:';

  @override
  String get enterDownloadLocationOrBrowse =>
      'Εισάγετε τοποθεσία λήψης ή περιηγηθείτε';

  @override
  String get downloadLocationEmpty => 'Κενή Τοποθεσία Λήψης';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'Παρακαλώ επιλέξτε ή εισάγετε μια τοποθεσία λήψης.';

  @override
  String get selectionIncomplete => 'Επιλογή Ελλιπής';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'Παρακαλώ επιλέξτε μια μέθοδο λήψης και έναν καθρέφτη.';

  @override
  String get next => 'Επόμενο';

  @override
  String get download => 'Λήψη';

  @override
  String get downloadComplete => 'Η λήψη ολοκληρώθηκε!';

  @override
  String get downloadPending => 'Λήψη σε εκκρεμότητα...';

  @override
  String get genres => 'Genres';

  @override
  String get company => 'Εταιρεία';

  @override
  String get language => 'Γλώσσα';

  @override
  String get originalSize => 'Αρχικό Μέγεθος';

  @override
  String get repackSize => 'Μέγεθος Επαναπακέτου';

  @override
  String get repackInformation => 'Πληροφορίες Repack';

  @override
  String screenshotsTitle(Object count) {
    return 'Screenshots ($count)';
  }

  @override
  String get errorLoadingImage => 'Σφάλμα φόρτωσης εικόνας';

  @override
  String get noScreenshotsAvailable =>
      'Δεν υπάρχουν διαθέσιμα στιγμιότυπα οθόνης.';

  @override
  String get noGenresAvailable => 'Δεν υπάρχουν διαθέσιμα είδη';

  @override
  String get clear => 'Εκκαθάριση';

  @override
  String get filterByGenre => 'Φιλτράρισμα ανά είδος';

  @override
  String get filter => 'Φίλτρο';
}
