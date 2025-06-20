// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get success => 'Geslaagd';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'Nieuwe en Populaire repacks zijn teruggedraaid.';

  @override
  String get error => 'Foutmelding';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'Herpakken van gegevens mislukt: $errorMessage';
  }

  @override
  String get home => 'Startpagina';

  @override
  String get rescrapeNewPopular => 'Rescrape Nieuw & Populair';

  @override
  String get newRepacks => 'Nieuwe Repacks';

  @override
  String get popularRepacks => 'Populaire Repacks';

  @override
  String get noCompletedGroupsToClear => 'Geen voltooide groepen om te wissen.';

  @override
  String get queued => 'Wachtrij';

  @override
  String get downloading => 'Downloaden:';

  @override
  String get completed => 'Voltooid';

  @override
  String get failed => 'Mislukt';

  @override
  String get paused => 'Gepauzeerd';

  @override
  String get canceled => 'Geannuleerd';

  @override
  String get dismiss => 'Uitschakelen';

  @override
  String get confirmClear => 'Bevestig wissen';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'groepen',
      one: 'Groep',
      zero: 'Groeps',
    );
    return 'Weet u zeker dat u $count voltooide download wilt verwijderen ${_temp0}Dit zal ook bestanden van de schijf verwijderen als deze in speciale submappen zijn die door de app worden beheerd.';
  }

  @override
  String get clearCompleted => 'Verwijder voltooide';

  @override
  String get cancel => 'annuleren';

  @override
  String completedGroupsCleared(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'groep',
      one: 'groep',
      zero: 'groepen',
    );
    return '$count voltooid $_temp0 gewist.';
  }

  @override
  String get downloadManager => 'Download beheerder';

  @override
  String get maxConcurrent => 'Max gelijkstroom';

  @override
  String get noActiveDownloads => 'Geen actieve downloads.';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'Downloads verschijnen hier eenmaal toegevoegd.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'Annuleer alle downloads in deze groep';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'Weet u zeker dat u alle downloads in deze groep wilt annuleren en verwijderen?';

  @override
  String completedNumberFiles(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'bestanden',
      one: 'bestand',
      zero: 'bestanden',
    );
    return '$count $_temp0';
  }

  @override
  String overallProgressFilesPercent(num count, Object percent) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'bestand',
      one: 'bestand',
    );
    return 'Overal: $percent% ($count $_temp0)';
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
    return 'Annuleer groep: $groupName';
  }

  @override
  String get removeFromList => 'Verwijderen uit lijst';

  @override
  String get resume => 'Hervatten';

  @override
  String get pause => 'Onderbreken';

  @override
  String get errorTaskDataUnavailable => 'Fout: Taak gegevens niet beschikbaar';

  @override
  String get unknownFile => 'Onbekend bestand';

  @override
  String get yesCancelGroup => 'Ja, annuleer groep';

  @override
  String get no => 'Neen';

  @override
  String get repackLibrary => 'Bibliotheek hernemen';

  @override
  String get settings => 'Instellingen';

  @override
  String get unknown => 'onbekend';

  @override
  String get noReleaseNotesAvailable => 'Geen release notities beschikbaar.';

  @override
  String get search => 'Zoeken';

  @override
  String updateAvailable(Object version) {
    return 'Update beschikbaar: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'Er is een nieuwe versie van FitFlutter beschikbaar.';

  @override
  String get viewReleaseNotes => 'Uitgaveopmerkingen bekijken';

  @override
  String get releasePage => 'Pagina vrijgeven';

  @override
  String get later => 'Later';

  @override
  String get upgrade => 'Upgraden';

  @override
  String get downloadsInProgress => 'Bezig met downloaden';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'Sluiten van de applicatie zal alle actieve downloads annuleren. ';

  @override
  String get areYouSureYouWantToClose => 'Weet je zeker dat je wilt afsluiten?';

  @override
  String get yesCloseCancel => 'Ja, sluiten en annuleren';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'Gebruiker gekozen om te sluiten; download wordt geannuleerd.';

  @override
  String get keepDownloading => 'Blijf downloaden';

  @override
  String get startingLibrarySync =>
      'Bibliotheeksynchronisatie wordt gestart...';

  @override
  String get fetchingAllRepackNames => 'Alle repack namen ophalen...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'pagina\'s',
      one: 'pagina',
    );
    return 'Namen ophalen: $page van $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails =>
      'Ontbrekende repack details scrapen...';

  @override
  String get thisMayTakeAWhile => 'Dit kan een tijdje duren.';

  @override
  String scrapingMissingRepackDetailsProgress(num current, num total) {
    String _temp0 = intl.Intl.pluralLogic(
      current,
      locale: localeName,
      other: 'Herpakt',
      one: 'Terugpakken',
    );
    return 'Scraping details: $current/$total ontbreekt $_temp0';
  }

  @override
  String get repackLibrarySynchronized =>
      'Herhaal bibliotheek gesynchroniseerd.';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'Kan bibliotheek niet synchroniseren: $errorMessage';
  }

  @override
  String get syncLibrary => 'Synchroniseer bibliotheek';

  @override
  String get syncingLibrary => 'Bibliotheek synchroniseren...';

  @override
  String get noRepacksFoundInTheLibrary =>
      'Geen herpakken gevonden in de bibliotheek.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'Geen pakketten gevonden die overeenkomen met $search.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'Het venster is te klein om items goed weer te geven.';

  @override
  String get pleaseResizeTheWindow => 'Gelieve het raam te verkleinen.';

  @override
  String get repackUrlIsNotAvailable => 'Herhaal URL is niet beschikbaar.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'URL kon niet worden opgestart: $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return 'Kan niet starten: $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return 'Ongeldige URL-formaat: $url';
  }

  @override
  String get rescrapeDetails => 'Rescrape Details';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return 'Details voor $title zijn opnieuw ingetrokken en bijgewerkt.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'Kan details niet opnieuw oprapen: $errorMessage';
  }

  @override
  String get errorRescraping => 'Fout Rescraping';

  @override
  String get openSourcePage => 'Open source pagina';

  @override
  String noPopularNewRepacksFound(Object type) {
    return 'Geen $type repacks gevonden.';
  }

  @override
  String get newest => 'Nieuw';

  @override
  String get popular => 'populair';

  @override
  String get system => 'Systeem';

  @override
  String get yellow => 'Geel';

  @override
  String get orange => 'Oranje';

  @override
  String get red => 'Rood';

  @override
  String get magenta => 'Magenta';

  @override
  String get purple => 'Paars';

  @override
  String get blue => 'Blauw';

  @override
  String get teal => 'Groenblauw';

  @override
  String get green => 'Groen';

  @override
  String get confirmForceRescrape => 'Bevestig Rescrape Kracht';

  @override
  String
  get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'Dit zal ALLE lokaal opgeslagen repack-gegevens verwijderen en opnieuw downloaden van alles van de bron. ';

  @override
  String
  get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'Dit proces kan heel lang duren en verbruikt significante netwerkgegevens. Weet je het zeker?';

  @override
  String get yesRescrapeAll => 'Ja, Rescrape Alles';

  @override
  String get startingFullDataRescrape =>
      'Volledige gegevensverwerking wordt gestart...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'Alle gegevens zijn met kracht teruggedraaid.';

  @override
  String errorMessage(Object error) {
    return 'Fout: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'Forceer rescrape gegevens: $errorMessage';
  }

  @override
  String get forceRescrapingData => 'Forceer Rescraping gegevens';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'Downloads & Installatie';

  @override
  String get defaultDownloadPath => 'Standaard Download pad';

  @override
  String get maxConcurrentDownloads => 'Max gelijktijdige downloads';

  @override
  String get automaticInstallation => 'Automatische installatie';

  @override
  String get enableAutoInstallAfterDownload =>
      'Auto-installatie inschakelen na download:';

  @override
  String get defaultInstallationPath => 'Standaard installatiepad';

  @override
  String
  get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      'Wanneer ingeschakeld, zullen voltooide herpakken proberen te installeren naar het opgegeven pad.';

  @override
  String get appearance => 'Uiterlijk';

  @override
  String get themeMode => 'Thema modus';

  @override
  String get navigationPaneDisplayMode => 'Navigatie Pane Weergave Modus';

  @override
  String get accentColor => 'Accent kleur';

  @override
  String get windowTransparency => 'Transparantie venster';

  @override
  String get local => 'Lokalisatie';

  @override
  String get applicationUpdates => 'Applicatie updates';

  @override
  String get updateCheckFrequency => 'Controle frequentie bijwerken';

  @override
  String get currentAppVersion => 'Huidige App Versie:';

  @override
  String get loading => 'Laden...';

  @override
  String get latestAvailableVersion => 'Laatst beschikbare versie:';

  @override
  String get youAreOnTheLatestVersion => 'U bent op de laatste versie';

  @override
  String get checking => 'Controleren...';

  @override
  String get notCheckedYet => ' Nog niet gecontroleerd.';

  @override
  String get checkToSee => ' Controleer om te zien.';

  @override
  String get youHaveIgnoredThisUpdate => 'Je hebt deze update genegeerd.';

  @override
  String get unignoreCheckAgain => 'Onbekenden & Opnieuw controleren';

  @override
  String get checkForUpdatesNow => 'Nu controleren op updates';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'Update naar versie $version is beschikbaar';
  }

  @override
  String get downloadAndInstallUpdate => 'Download en installeer Update';

  @override
  String get viewReleasePage => 'Bekijk Release Pagina';

  @override
  String get dataManagement => 'Data beheer';

  @override
  String get forceRescrapeAllData => 'Forceer Rescrape Alle gegevens';

  @override
  String
  get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'Waarschuwing: Dit proces kan zeer lang duren en aanzienlijke netwerkgegevens verbruiken. Wees voorzichtig.';

  @override
  String get rescrapingSeeDialog => 'Rescrapen... Zie dialoogvenster';

  @override
  String get forceRescrapeAllDataNow => 'Forceer nu Rescrape Alle gegevens';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'Er is al een nieuw proces aan de gang.';

  @override
  String get clearingAllExistingData => 'Alle bestaande gegevens wissen...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'Alle repack-namen overschrijven (Phase 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'pagina',
      one: 'Pagina',
    );
    return 'Versnel alle repack namen (Phase 1/4): Pagina $page van $totalPages $_temp0';
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
      'Scrap-details voor elke repack (Phase 2/4 - Langste Fase)...';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
    Object current,
    Object total,
  ) {
    return 'Scrap-details voor elke repack (Phase 2/4): Repack $current of $total';
  }

  @override
  String allRepackDetailsScrapedPhase2(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'herpakt',
      one: 'repack',
      zero: 'repacks',
    );
    return 'Alle repack details zijn gescraped. ($count $_temp0 verwerkt (Phase 2/4 Voltooid)';
  }

  @override
  String get rescrapingNewRepacksPhase3 =>
      'Herpakken nieuwe repacks (Phase 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'Nieuwe herpakken (Phase 3/4): Pagina $current van $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'Nieuwe repacks zijn teruggezet. (Phase 3/4 Voltooid)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'Herpakken van populaire repacks (Phase 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'Rescraping populaire repacks (Phase 4/4): Item $current van $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'Populaire repacks gescraped. (Phase 4/4 Voltooid)';

  @override
  String get finalizing => 'Afronden...';

  @override
  String get fullRescrapeCompletedSuccessfully =>
      'Volledige rescrape succesvol voltooid!';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'Fout: $errorMessage. Proces gestopt.';
  }

  @override
  String get daily => 'Dagelijks';

  @override
  String get weekly => 'wekelijks';

  @override
  String get manual => 'Handleiding';

  @override
  String get onEveryStartup => 'Bij elke opstart';

  @override
  String get light => 'Licht';

  @override
  String get dark => 'Donker';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'Geen URL\'s gevonden in de spiegelconfiguratie.';

  @override
  String get failedToProcessUnknownPlugin =>
      'Verwerken (onbekende Plugin) is mislukt:';

  @override
  String get problemProcessingSomeLinks =>
      'Probleem bij het verwerken van links. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'Fout bij het verwerken van een of meer links. ';

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
  String get downloadStarted => 'Download gestart';

  @override
  String get ok => 'Ok';

  @override
  String get noFilesSelected => 'Geen bestanden geselecteerd';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'Selecteer een of meer bestanden uit de te downloaden structuur.';

  @override
  String get noFilesCouldBeRetrieved =>
      'Er konden geen bestanden worden opgehaald.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
    Object processingError,
  ) {
    return 'Let op: $processingError Sommige bestanden kunnen problemen hebben.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'Geen downloadbare bestanden gevonden voor deze spiegel.';

  @override
  String downloadFilesGame(Object Game) {
    return 'Download bestanden: $Game';
  }

  @override
  String get close => 'Afsluiten';

  @override
  String get downloadSelected => 'Download selectie';

  @override
  String get aboutGame => 'Over spel';

  @override
  String get features => 'Eigenschappen';

  @override
  String get selectDownloadOptions => 'Downloadopties selecteren';

  @override
  String get downloadMethod => 'Download methode:';

  @override
  String get selectMethod => 'Selecteer methode';

  @override
  String get mirror => 'Spiegel:';

  @override
  String get selectMirror => 'Selecteer spiegel';

  @override
  String get downloadLocation => 'Download locatie:';

  @override
  String get enterDownloadLocationOrBrowse =>
      'Voer downloadlocatie in of blader';

  @override
  String get downloadLocationEmpty => 'Downloadlocatie is leeg';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'Selecteer of voer een downloadlocatie in.';

  @override
  String get selectionIncomplete => 'Selectie onvolledig';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'Selecteer een downloadmethode en een mirror.';

  @override
  String get next => 'Volgende';

  @override
  String get download => 'downloaden';

  @override
  String get downloadComplete => 'Download voltooid!';

  @override
  String get downloadPending => 'Download in behandeling...';

  @override
  String get genres => 'Genres';

  @override
  String get company => 'Bedrijfsnaam';

  @override
  String get language => 'Taal';

  @override
  String get originalSize => 'Oorspronkelijke grootte';

  @override
  String get repackSize => 'Herhaling grootte';

  @override
  String get repackInformation => 'Herhaling Informatie';

  @override
  String screenshotsTitle(Object count) {
    return 'Screenshots ($count)';
  }

  @override
  String get errorLoadingImage => 'Fout bij laden afbeelding';

  @override
  String get noScreenshotsAvailable => 'Geen schermafbeeldingen beschikbaar.';

  @override
  String get noGenresAvailable => 'Geen genres beschikbaar';

  @override
  String get clear => 'Verwijderen';

  @override
  String get filterByGenre => 'Filteren op genre';

  @override
  String get filter => 'Filteren';

  @override
  String get gogLibrary => 'GOG Library';

  @override
  String get syncGogLibrary => 'Sync GOG Library';

  @override
  String get startingGogSync => 'Starting GOG library sync...';

  @override
  String get fetchingGogGames => 'Fetching GOG games...';

  @override
  String fetchingGogGameDetails(Object current, Object total) {
    return 'Fetching details for GOG game $current of $total...';
  }

  @override
  String get gogLibrarySynchronized =>
      'GOG library has been successfully synchronized.';

  @override
  String failedToSyncGogLibrary(Object error) {
    return 'Failed to synchronize GOG library: $error';
  }

  @override
  String get noGogGamesFoundInLibrary =>
      'No GOG games found in the library. Try syncing to fetch them.';

  @override
  String get noGogGamesFoundMatchingSearch =>
      'No GOG games found matching your search and filter criteria.';

  @override
  String get gogGameDetails => 'GOG Game Details';

  @override
  String get userRating => 'User Rating';

  @override
  String get downloadSize => 'Download Size';

  @override
  String get lastUpdate => 'Last Update';

  @override
  String get developer => 'Developer';

  @override
  String get onlyTorrentsAreWorkingForNow =>
      'Only torrents are working for now.';
}
