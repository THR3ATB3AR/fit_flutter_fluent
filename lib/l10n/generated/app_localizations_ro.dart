// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get success => 'Succes';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'Repachetele noi și populare au fost reclasificate.';

  @override
  String get error => 'Eroare';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'Rescraparea datelor a eșuat: $errorMessage';
  }

  @override
  String get home => 'Acasă';

  @override
  String get rescrapeNewPopular => 'Rescrapă nouă și populară';

  @override
  String get newRepacks => 'Repachete noi';

  @override
  String get popularRepacks => 'Repachete populare';

  @override
  String get noCompletedGroupsToClear =>
      'Nu sunt grupuri completate pentru ștergere.';

  @override
  String get queued => 'În aşteptare';

  @override
  String get downloading => 'Descărcări:';

  @override
  String get completed => 'Completat';

  @override
  String get failed => 'Eșuat';

  @override
  String get paused => 'Pauză';

  @override
  String get canceled => 'Anulat';

  @override
  String get dismiss => 'Renunţaţi';

  @override
  String get confirmClear => 'Confirmă curățarea';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'grupuri',
      one: 'grup',
      zero: 'grupuri',
    );
    return 'Sunteți sigur că doriți să eliminați descărcarea completă a lui $count $_temp0? Acest lucru va elimina, de asemenea, fișierele de pe disc dacă sunt în subdosare dedicate gestionate de aplicație.';
  }

  @override
  String get clearCompleted => 'Curăță Finalizată';

  @override
  String get cancel => 'Anulează';

  @override
  String completedGroupsCleared(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Grupurile',
      one: 'grup',
      zero: 'grupuri',
    );
    return '$count completat $_temp0 au fost șterse.';
  }

  @override
  String get downloadManager => 'Manager descărcări';

  @override
  String get maxConcurrent => 'Concurență Maximă';

  @override
  String get noActiveDownloads => 'Nici o descărcare activă.';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'Descărcările vor apărea aici odată adăugate.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'Anulează toate descărcările din acest grup';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'Sigur doriți să anulați toate descărcările din acest grup și să le ștergeți?';

  @override
  String completedNumberFiles(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '',
      one: 'fişiere',
      zero: 'fişiere',
    );
    return 'Completat $count $_temp0';
  }

  @override
  String overallProgressFilesPercent(num count, Object percent) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'fişiere',
      one: 'fişier',
    );
    return 'Total: $percent% ($count $_temp0';
  }

  @override
  String noActiveTasks(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'fişiere',
      one: 'fişier',
    );
    return 'Nici o sarcină activă sau progres indisponibil ($count $_temp0';
  }

  @override
  String cancelGroupName(Object groupName) {
    return 'Anulare grup: $groupName';
  }

  @override
  String get removeFromList => 'Elimină din listă';

  @override
  String get resume => 'Reluare';

  @override
  String get pause => 'Întrerupeți';

  @override
  String get errorTaskDataUnavailable =>
      'Eroare: date de sarcină indisponibile';

  @override
  String get unknownFile => 'Fișier necunoscut';

  @override
  String get yesCancelGroup => 'Da, anulează grupul';

  @override
  String get no => 'Nr';

  @override
  String get repackLibrary => 'Reîmpachetează biblioteca';

  @override
  String get settings => 'Setări';

  @override
  String get unknown => 'Necunoscut';

  @override
  String get noReleaseNotesAvailable =>
      'Nu există note de lansare disponibile.';

  @override
  String get search => 'Caută';

  @override
  String updateAvailable(Object version) {
    return 'Actualizare disponibilă: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'O nouă versiune de FitFlutter este disponibilă.';

  @override
  String get viewReleaseNotes => 'Vezi notele de lansare';

  @override
  String get releasePage => 'Pagina de lansare';

  @override
  String get later => 'Mai târziu';

  @override
  String get upgrade => 'Actualizează';

  @override
  String get downloadsInProgress => 'Descărcări în curs';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'Închiderea aplicației va anula toate descărcările active. ';

  @override
  String get areYouSureYouWantToClose =>
      'Sunteţi sigur că doriţi să închideţi?';

  @override
  String get yesCloseCancel => 'Da, închide și anulează';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'Utilizatorul a ales să închidă; anularea descărcărilor.';

  @override
  String get keepDownloading => 'Descărcare în continuare';

  @override
  String get startingLibrarySync => 'Pornire sincronizare bibliotecă...';

  @override
  String get fetchingAllRepackNames =>
      'Preluarea tuturor numelor de reîmpachetare...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'paginile',
      one: 'pagina',
    );
    return 'Preluare nume: $page de $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails =>
      'Răzuire detalii reîmpachetare lipsă...';

  @override
  String get thisMayTakeAWhile => 'Acest lucru poate dura o vreme.';

  @override
  String scrapingMissingRepackDetailsProgress(num current, num total) {
    String _temp0 = intl.Intl.pluralLogic(
      current,
      locale: localeName,
      other: 'reîmprospătați',
      one: 'Reîmpachetați',
    );
    return 'Detalii răzuire: $current/$total lipsește $_temp0';
  }

  @override
  String get repackLibrarySynchronized => 'Repack biblioteca sincronizată.';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'Sincronizarea bibliotecii a eșuat: $errorMessage';
  }

  @override
  String get syncLibrary => 'Sincronizează biblioteca';

  @override
  String get syncingLibrary => 'Se sincronizează biblioteca...';

  @override
  String get noRepacksFoundInTheLibrary =>
      'Nu s-au găsit repachete în bibliotecă.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'Nu s-au găsit repachete care să corespundă $search.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'Fereastra este prea îngustă pentru a afișa elementele corect.';

  @override
  String get pleaseResizeTheWindow => 'Vă rugăm redimensionați fereastra.';

  @override
  String get repackUrlIsNotAvailable =>
      'URL-ul pentru Repack nu este disponibil.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'URL-ul nu a putut fi lansat: $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return 'Nu s-a putut lansa: $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return 'Format URL invalid: $url';
  }

  @override
  String get rescrapeDetails => 'Detalii Rescrape';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return 'Detalii pentru $title au fost reclasificate și actualizate.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'Redenumirea detaliilor: $errorMessage nu a reușit';
  }

  @override
  String get errorRescraping => 'Rescrapare eroare';

  @override
  String get openSourcePage => 'Pagina sursă deschisă';

  @override
  String noPopularNewRepacksFound(Object type) {
    return 'Nu s-au găsit pachete $type';
  }

  @override
  String get newest => 'nou';

  @override
  String get popular => 'popular';

  @override
  String get system => 'Sistem';

  @override
  String get yellow => 'Galben';

  @override
  String get orange => 'Portocaliu';

  @override
  String get red => 'Roșu';

  @override
  String get magenta => 'Magenta';

  @override
  String get purple => 'Violet';

  @override
  String get blue => 'Albastru';

  @override
  String get teal => 'Turcoaz';

  @override
  String get green => 'Verde';

  @override
  String get confirmForceRescrape => 'Confirmare Cursă forţată';

  @override
  String
  get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'Aceasta va şterge TOATE datele de reambalare stocate local şi va redescărca totul de la sursă. ';

  @override
  String
  get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'Acest proces poate dura foarte mult timp și poate consuma date de rețea semnificative. Ești sigur?';

  @override
  String get yesRescrapeAll => 'Da, Rescrape Toate';

  @override
  String get startingFullDataRescrape =>
      'Pornire rescrapare completă a datelor...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'Toate datele au fost respinse cu forțare.';

  @override
  String errorMessage(Object error) {
    return 'Eroare: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'Nu a reușit să forțeze datele de răzuire: $errorMessage';
  }

  @override
  String get forceRescrapingData => 'Forțează Rescraping Date';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'Descărcări & Instalare';

  @override
  String get defaultDownloadPath => 'Calea implicită de descărcare';

  @override
  String get maxConcurrentDownloads => 'Maxim de descărcări Concurente';

  @override
  String get automaticInstallation => 'Instalare automată';

  @override
  String get enableAutoInstallAfterDownload =>
      'Activează Auto-Instalarea după descărcare:';

  @override
  String get defaultInstallationPath => 'Calea implicită de instalare';

  @override
  String
  get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      'Când este activată, repachetele complete vor încerca să se instaleze la calea specificată.';

  @override
  String get appearance => 'Aspectul';

  @override
  String get themeMode => 'Mod temă';

  @override
  String get navigationPaneDisplayMode => 'Modul de afişare panou de navigare';

  @override
  String get accentColor => 'Culoare accent';

  @override
  String get windowTransparency => 'Transparența ferestrei';

  @override
  String get local => 'Localizare';

  @override
  String get applicationUpdates => 'Actualizări ale aplicației';

  @override
  String get updateCheckFrequency => 'Frecvență verificare actualizare';

  @override
  String get currentAppVersion => 'Versiunea curentă a aplicației:';

  @override
  String get loading => 'Încărcare...';

  @override
  String get latestAvailableVersion => 'Ultima versiune disponibilă:';

  @override
  String get youAreOnTheLatestVersion => 'Sunteți pe cea mai recentă versiune';

  @override
  String get checking => 'Verificare...';

  @override
  String get notCheckedYet => ' Nu s-a verificat încă.';

  @override
  String get checkToSee => ' Verificați pentru a vedea.';

  @override
  String get youHaveIgnoredThisUpdate => 'Ați ignorat această actualizare.';

  @override
  String get unignoreCheckAgain => 'Ignoră și verifică din nou';

  @override
  String get checkForUpdatesNow => 'Verifică actualizările acum';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'Actualizare la versiunea $version este disponibilă';
  }

  @override
  String get downloadAndInstallUpdate => 'Descărcați și instalați actualizarea';

  @override
  String get viewReleasePage => 'Vezi pagina de lansare';

  @override
  String get dataManagement => 'Gestionarea datelor';

  @override
  String get forceRescrapeAllData => 'Forțează Rescrape Toate Datele';

  @override
  String
  get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'Atenție: Acest proces poate dura foarte mult timp și poate consuma date de rețea semnificative. Utilizați cu prudență.';

  @override
  String get rescrapingSeeDialog => 'Rescrapare... Vezi Dialog';

  @override
  String get forceRescrapeAllDataNow => 'Forțează acum Rescrape Toate Datele';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'Un alt proces de refacere este deja în desfășurare.';

  @override
  String get clearingAllExistingData =>
      'Ștergerea tuturor datelor existente...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'Răzuieşte toate numele de reambalare (faza 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'paginile',
      one: 'pagina',
    );
    return 'Răzuiește toate numele (faza 1/4): $page de $totalPages $_temp0';
  }

  @override
  String allRepackNamesScrapedPhase1(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Numele',
      one: 'Nume',
      zero: 'Nume',
    );
    return 'Toate numele reîmpachetate. ($count $_temp0 (Fagură 1/4 completă)';
  }

  @override
  String get scrapingDetailsForEveryRepackPhase2LongestPhase =>
      'Detalii de răzuire pentru fiecare repack (faza 2/4 - cea mai lungă fază)...';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
    Object current,
    Object total,
  ) {
    return 'Detalii răzuire pentru fiecare reambalare (faza 2/4): Reambalare $current de $total';
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
      'Rescrapare repachete noi (faza 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'Rescrapare noi repachete (faza 3/4): $current $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'Reambalaje noi rescăzute. (Faza 3/4 completă)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'Rescrapare repachete populare (faza 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'Rescrapare repachete populare (faza 4/4): $current de $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'Repachete populare rescăzute. (faza 4/4 complete)';

  @override
  String get finalizing => 'Finalizare...';

  @override
  String get fullRescrapeCompletedSuccessfully =>
      'Rescrapare completă cu succes!';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'Eroare: $errorMessage. Procesul a fost oprit.';
  }

  @override
  String get daily => 'Zilnic';

  @override
  String get weekly => 'Săptămânal';

  @override
  String get manual => 'Manual';

  @override
  String get onEveryStartup => 'La fiecare pornire';

  @override
  String get light => 'Lumină';

  @override
  String get dark => 'Întunecat';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'Nu s-au găsit URL-uri în configurația oglindei.';

  @override
  String get failedToProcessUnknownPlugin =>
      'Procesare eșuată (Plugin necunoscut):';

  @override
  String get problemProcessingSomeLinks =>
      'Problemă la procesarea unor legături. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'Eroare la procesarea uneia sau mai multor linkuri. ';

  @override
  String filesAddedToDownloadManager(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'fişiere',
      one: 'fişier',
      zero: 'fişiere',
    );
    return '$count $_temp0 adăugat la managerul de descărcare.';
  }

  @override
  String get downloadStarted => 'Descărcare începută';

  @override
  String get ok => 'Ok';

  @override
  String get noFilesSelected => 'Niciun fișier selectat';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'Te rugăm să selectezi unul sau mai multe fișiere din copac pentru a fi descărcate.';

  @override
  String get noFilesCouldBeRetrieved =>
      'Nici un fişier nu a putut fi recuperat.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
    Object processingError,
  ) {
    return 'Observație: $processingError Unele fișiere au întâlnit probleme.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'Nu s-au găsit fișiere descărcabile pentru această oglindă.';

  @override
  String downloadFilesGame(Object Game) {
    return 'Descărcare fişiere: $Game';
  }

  @override
  String get close => 'Inchide';

  @override
  String get downloadSelected => 'Descarcă cele selectate';

  @override
  String get aboutGame => 'Despre joc';

  @override
  String get features => 'Caracteristici';

  @override
  String get selectDownloadOptions => 'Selectați opțiunile de descărcare';

  @override
  String get downloadMethod => 'Metoda de descărcare:';

  @override
  String get selectMethod => 'Selectează metoda';

  @override
  String get mirror => 'Oglindire:';

  @override
  String get selectMirror => 'Selectați oglinda';

  @override
  String get downloadLocation => 'Locaţie de descărcare:';

  @override
  String get enterDownloadLocationOrBrowse =>
      'Introduceți locația descărcării sau navigați';

  @override
  String get downloadLocationEmpty => 'Locaţia de descărcare goală';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'Vă rugăm să selectaţi sau să introduceţi un loc de descărcare.';

  @override
  String get selectionIncomplete => 'Selecţie incompletă';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'Vă rugăm să selectaţi o metodă de descărcare şi o oglindă.';

  @override
  String get next => 'Următoarea';

  @override
  String get download => 'Descărcare';

  @override
  String get downloadComplete => 'Descărcare completă!';

  @override
  String get downloadPending => 'Descărcare în aşteptare...';

  @override
  String get genres => 'Genres';

  @override
  String get company => 'Companie';

  @override
  String get language => 'Limba';

  @override
  String get originalSize => 'Dimensiune originală';

  @override
  String get repackSize => 'Dimensiunea reîmpachetării';

  @override
  String get repackInformation => 'Informații despre Repack';

  @override
  String screenshotsTitle(Object count) {
    return 'Screenshots ($count)';
  }

  @override
  String get errorLoadingImage => 'Eroare la încărcarea imaginii';

  @override
  String get noScreenshotsAvailable => 'Nici o captură de ecran disponibilă.';

  @override
  String get noGenresAvailable => 'Niciun gen disponibil';

  @override
  String get clear => 'Curăță';

  @override
  String get filterByGenre => 'Filtrare după gen';

  @override
  String get filter => 'Filtrare';
}
