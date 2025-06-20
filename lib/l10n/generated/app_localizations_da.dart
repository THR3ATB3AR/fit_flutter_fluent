// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get success => 'Succes';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'Nye og populære repacks er blevet recraped.';

  @override
  String get error => 'Fejl';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'Mislykkedes at gendanne data: $errorMessage';
  }

  @override
  String get home => 'Hjem';

  @override
  String get rescrapeNewPopular => 'Rescrape Ny & Populær';

  @override
  String get newRepacks => 'Nye Gentagelser';

  @override
  String get popularRepacks => 'Populære Gentagelser';

  @override
  String get noCompletedGroupsToClear => 'Ingen færdige grupper at rydde.';

  @override
  String get queued => 'I Kø';

  @override
  String get downloading => 'Downloader:';

  @override
  String get completed => 'Afsluttet';

  @override
  String get failed => 'Mislykkedes';

  @override
  String get paused => 'Pauset';

  @override
  String get canceled => 'Annulleret';

  @override
  String get dismiss => 'Afvis';

  @override
  String get confirmClear => 'Bekræft Ryd';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'grupper',
      one: 'gruppe',
      zero: 'grupper',
    );
    return 'Er du sikker på, at du vil fjerne $count fuldført download $_temp0? Dette vil også fjerne filer fra disken, hvis de er i dedikerede undermapper håndteret af appen.';
  }

  @override
  String get clearCompleted => 'Ryd Fuldført';

  @override
  String get cancel => 'Annuller';

  @override
  String completedGroupsCleared(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'grupper',
      one: 'gruppe',
      zero: 'grupper',
    );
    return '$count fuldført $_temp0 ryddet.';
  }

  @override
  String get downloadManager => 'Download Manager';

  @override
  String get maxConcurrent => 'Maks. Samtidige';

  @override
  String get noActiveDownloads => 'Ingen aktive downloads.';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'Downloads vises her når de er tilføjet.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'Annuller alle downloads i denne gruppe';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'Er du sikker på du vil annullere alle downloads i denne gruppe og fjerne dem?';

  @override
  String completedNumberFiles(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'filer',
      one: 'fil',
      zero: 'filer',
    );
    return 'Fuldført $count $_temp0';
  }

  @override
  String overallProgressFilesPercent(num count, Object percent) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'filer',
      one: 'fil',
    );
    return 'Samlet: $percent% ($count $_temp0)';
  }

  @override
  String noActiveTasks(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'filer',
      one: 'fil',
    );
    return 'Ingen aktive opgaver eller fremskridt utilgængelige ($count $_temp0)';
  }

  @override
  String cancelGroupName(Object groupName) {
    return 'Annuller Gruppe: $groupName';
  }

  @override
  String get removeFromList => 'Fjern fra liste';

  @override
  String get resume => 'Genoptag';

  @override
  String get pause => 'Pause';

  @override
  String get errorTaskDataUnavailable => 'Fejl: Opgave data utilgængelige';

  @override
  String get unknownFile => 'Ukendt Fil';

  @override
  String get yesCancelGroup => 'Ja, Annuller Gruppe';

  @override
  String get no => 'Nej';

  @override
  String get repackLibrary => 'Repack Bibliotek';

  @override
  String get settings => 'Indstillinger';

  @override
  String get unknown => 'Ukendt';

  @override
  String get noReleaseNotesAvailable => 'Ingen udgivelsesnoter tilgængelige.';

  @override
  String get search => 'Søg';

  @override
  String updateAvailable(Object version) {
    return 'Opdatering Tilgængelig: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'En ny version af FitFlutter er tilgængelig.';

  @override
  String get viewReleaseNotes => 'Vis Udgivelsesnoter';

  @override
  String get releasePage => 'Udgivelsesside';

  @override
  String get later => 'Senere';

  @override
  String get upgrade => 'Opgradér';

  @override
  String get downloadsInProgress => 'Download i gang';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'Lukning af programmet annullerer alle aktive downloads. ';

  @override
  String get areYouSureYouWantToClose => 'Er du sikker på, at du vil lukke?';

  @override
  String get yesCloseCancel => 'Ja, Luk & Annullér';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'Bruger valgte at lukke; annullerer downloads.';

  @override
  String get keepDownloading => 'Fortsæt Downloading';

  @override
  String get startingLibrarySync => 'Starter biblioteks synkronisering...';

  @override
  String get fetchingAllRepackNames => 'Henter alle repacknavne...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'sider',
      one: 'side',
    );
    return 'Henter navne: $page af $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails =>
      'Ombryder manglende repack detaljer...';

  @override
  String get thisMayTakeAWhile => 'Det kan tage et stykke tid.';

  @override
  String scrapingMissingRepackDetailsProgress(num current, num total) {
    String _temp0 = intl.Intl.pluralLogic(
      current,
      locale: localeName,
      other: 'repacks',
      one: 'repack',
    );
    return 'Scraping detaljer: $current/$total mangler $_temp0';
  }

  @override
  String get repackLibrarySynchronized => 'Repack bibliotek synkroniseret.';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'Kunne ikke synkronisere bibliotek: $errorMessage';
  }

  @override
  String get syncLibrary => 'Synkroniser Bibliotek';

  @override
  String get syncingLibrary => 'Synkroniserer Bibliotek...';

  @override
  String get noRepacksFoundInTheLibrary =>
      'Ingen repacks fundet i biblioteket.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'Ingen repacks fundet matchende $search.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'Vinduet er for smalt til at vise elementer korrekt.';

  @override
  String get pleaseResizeTheWindow => 'Ændr venligst størrelsen på vinduet.';

  @override
  String get repackUrlIsNotAvailable => 'Repack URL er ikke tilgængelig.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'Kunne ikke starte URL: $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return 'Kunne ikke starte: $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return 'Ugyldigt URL-format: $url';
  }

  @override
  String get rescrapeDetails => 'Rescrape Detaljer';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return 'Detaljer for $title er blevet ændret og opdateret.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'Kunne ikke nulstille detaljer: $errorMessage';
  }

  @override
  String get errorRescraping => 'Fejl Under Genoprettelse';

  @override
  String get openSourcePage => 'Open Source Side';

  @override
  String noPopularNewRepacksFound(Object type) {
    return 'Ingen $type repacks fundet.';
  }

  @override
  String get newest => 'ny';

  @override
  String get popular => 'populær';

  @override
  String get system => 'System';

  @override
  String get yellow => 'Gul';

  @override
  String get orange => 'Orange';

  @override
  String get red => 'Rød';

  @override
  String get magenta => 'Magentarød';

  @override
  String get purple => 'Lilla';

  @override
  String get blue => 'Blå';

  @override
  String get teal => 'Grønblåt';

  @override
  String get green => 'Grøn';

  @override
  String get confirmForceRescrape => 'Bekræft Kraft Rescrape';

  @override
  String
  get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'Dette vil slette ALLE lokalt lagrede repack data og re-downloade alt fra kilden. ';

  @override
  String
  get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'Denne proces kan tage meget lang tid og forbruge betydelige netværksdata. Er du sikker?';

  @override
  String get yesRescrapeAll => 'Ja, Rescrape Alle';

  @override
  String get startingFullDataRescrape => 'Starter fuld data rescrap...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'Alle data er blevet kraftigt regraderet.';

  @override
  String errorMessage(Object error) {
    return 'Fejl: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'Mislykkedes at tvinge rescrape data: $errorMessage';
  }

  @override
  String get forceRescrapingData => 'Gennemtving Gendannelse Af Data';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'Download & Installation';

  @override
  String get defaultDownloadPath => 'Standard Download Sti';

  @override
  String get maxConcurrentDownloads => 'Maks. Samtidige Downloads';

  @override
  String get automaticInstallation => 'Automatisk Installation';

  @override
  String get enableAutoInstallAfterDownload =>
      'Aktiver automatisk installation efter download:';

  @override
  String get defaultInstallationPath => 'Standard Installationssti';

  @override
  String
  get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      'Når aktiveret, vil fuldførte repacks forsøge at installere på den angivne sti.';

  @override
  String get appearance => 'Udseende';

  @override
  String get themeMode => 'Tema tilstand';

  @override
  String get navigationPaneDisplayMode => 'Navigation Pane Visningstilstand';

  @override
  String get accentColor => 'Accent Farve';

  @override
  String get windowTransparency => 'Vindue Gennemsigtighed';

  @override
  String get local => 'Landestandard';

  @override
  String get applicationUpdates => 'Applikation Opdateringer';

  @override
  String get updateCheckFrequency => 'Opdater Tjek Frekvens';

  @override
  String get currentAppVersion => 'Nuværende App Version:';

  @override
  String get loading => 'Indlæser...';

  @override
  String get latestAvailableVersion => 'Seneste Tilgængelige Version:';

  @override
  String get youAreOnTheLatestVersion => 'Du er på den seneste version';

  @override
  String get checking => 'Kontrollerer...';

  @override
  String get notCheckedYet => ' Ikke tjekket endnu.';

  @override
  String get checkToSee => ' Vælg for at se.';

  @override
  String get youHaveIgnoredThisUpdate => 'Du har ignoreret denne opdatering.';

  @override
  String get unignoreCheckAgain => 'Unignore & Tjek Igen';

  @override
  String get checkForUpdatesNow => 'Søg efter opdateringer nu';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'Opdatering til version $version er tilgængelig';
  }

  @override
  String get downloadAndInstallUpdate => 'Download og installer opdatering';

  @override
  String get viewReleasePage => 'Vis Udgivelsesside';

  @override
  String get dataManagement => 'Datahåndtering';

  @override
  String get forceRescrapeAllData => 'Gennemtving Gendan Alle Data';

  @override
  String
  get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'Advarsel: Denne proces kan tage meget lang tid og forbruge betydelige netværksdata. Bruges med forsigtighed.';

  @override
  String get rescrapingSeeDialog => 'Rescraping... Se Dialog';

  @override
  String get forceRescrapeAllDataNow => 'Gennemtving Gendan Alle Data Nu';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'En anden omlægningsproces er allerede i gang.';

  @override
  String get clearingAllExistingData => 'Rydder alle eksisterende data...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'Scraping alle repack navne (fase 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'sider',
      one: 'side',
    );
    return 'Scraping alle repack navne (fase 1/4): Side $page af $totalPages $_temp0';
  }

  @override
  String allRepackNamesScrapedPhase1(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'navne',
      one: 'navn',
      zero: 'navne',
    );
    return 'Alle repack navne skrabet. ($count $_temp0 (fase 1/4 komplet)';
  }

  @override
  String get scrapingDetailsForEveryRepackPhase2LongestPhase =>
      'Scraping detaljer for hver repack (fase 2/4 - længste fase) ...';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
    Object current,
    Object total,
  ) {
    return 'Scraping detaljer for hvert svar (fase 2/4): Repack $current af $total';
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
    return 'Alle repack detaljer skrabet. ($count $_temp0 behandlet (fase 2/4 komplet)';
  }

  @override
  String get rescrapingNewRepacksPhase3 =>
      'Rescraping nye repacks (fase 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'Genoprettelse af nye repacks (fase 3/4): Side $current af $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'Nye repacks recraped. (Phase 3/4 komplet)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'Rescraping populære repacks (Phase 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'Rescraping populære repacks (fase 4/4): Vare $current af $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'Populære repacks recraped. (fase 4/4 komplet)';

  @override
  String get finalizing => 'Afslutter...';

  @override
  String get fullRescrapeCompletedSuccessfully =>
      'Fuld rescrape gennemført med succes!';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'Fejl: $errorMessage. Proces standset.';
  }

  @override
  String get daily => 'Dagligt';

  @override
  String get weekly => 'Ugentlig';

  @override
  String get manual => 'Manuelt';

  @override
  String get onEveryStartup => 'Ved Hver Opstart';

  @override
  String get light => 'Lys';

  @override
  String get dark => 'Mørk';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'Ingen URL\'er fundet i spejlkonfigurationen.';

  @override
  String get failedToProcessUnknownPlugin =>
      'Mislykkedes at behandle (Ukendt plugin):';

  @override
  String get problemProcessingSomeLinks =>
      'Problem med at behandle nogle links. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'Fejl ved behandling af et eller flere links. ';

  @override
  String filesAddedToDownloadManager(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'filer',
      one: 'fil',
      zero: 'filer',
    );
    return '$count $_temp0 tilføjet til download manager.';
  }

  @override
  String get downloadStarted => 'Download Startet';

  @override
  String get ok => 'Ok';

  @override
  String get noFilesSelected => 'Ingen Filer Valgt';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'Vælg venligst en eller flere filer fra træet, der skal downloades.';

  @override
  String get noFilesCouldBeRetrieved => 'Ingen filer kunne hentes.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
    Object processingError,
  ) {
    return 'Bemærk: $processingError Nogle filer kan have stødt på problemer.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'Ingen filer fundet til download for dette filspejl.';

  @override
  String downloadFilesGame(Object Game) {
    return 'Download Filer: $Game';
  }

  @override
  String get close => 'Luk';

  @override
  String get downloadSelected => 'Download Valgte';

  @override
  String get aboutGame => 'Om spillet';

  @override
  String get features => 'Funktioner';

  @override
  String get selectDownloadOptions => 'Vælg download-muligheder';

  @override
  String get downloadMethod => 'Download Metode:';

  @override
  String get selectMethod => 'Vælg metode';

  @override
  String get mirror => 'Spejl:';

  @override
  String get selectMirror => 'Vælg spejl';

  @override
  String get downloadLocation => 'Download Placering:';

  @override
  String get enterDownloadLocationOrBrowse =>
      'Indtast download-placering eller gennemse';

  @override
  String get downloadLocationEmpty => 'Download Placering Tom';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'Vælg eller indtast en download-placering.';

  @override
  String get selectionIncomplete => 'Markering Ufuldstændig';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'Vælg venligst en downloadmetode og et filspejl.';

  @override
  String get next => 'Næste';

  @override
  String get download => 'Hent';

  @override
  String get downloadComplete => 'Download fuldført!';

  @override
  String get downloadPending => 'Download afventende...';

  @override
  String get genres => 'Genres';

  @override
  String get company => 'Virksomhed';

  @override
  String get language => 'Sprog';

  @override
  String get originalSize => 'Oprindelig Størrelse';

  @override
  String get repackSize => 'Repack Størrelse';

  @override
  String get repackInformation => 'Repack Information';

  @override
  String screenshotsTitle(Object count) {
    return 'Skærmbilleder ($count)';
  }

  @override
  String get errorLoadingImage => 'Fejl under indlæsning af billede';

  @override
  String get noScreenshotsAvailable => 'Ingen screenshots tilgængelige.';

  @override
  String get noGenresAvailable => 'Ingen genrer tilgængelige';

  @override
  String get clear => 'Ryd';

  @override
  String get filterByGenre => 'Filtrer efter genre';

  @override
  String get filter => 'Filtrer';

  @override
  String get gogLibrary => 'GOG Bibliotek';

  @override
  String get syncGogLibrary => 'Synkroniser GOG Bibliotek';

  @override
  String get startingGogSync => 'Starter GOG bibliotek synkronisering...';

  @override
  String get fetchingGogGames => 'Henter GOG spil...';

  @override
  String fetchingGogGameDetails(Object current, Object total) {
    return 'Henter detaljer for GOG spil $current af $total...';
  }

  @override
  String get gogLibrarySynchronized =>
      'GOG bibliotek er synkroniseret med succes.';

  @override
  String failedToSyncGogLibrary(Object error) {
    return 'Synkronisering af GOG bibliotek mislykkedes: $error';
  }

  @override
  String get noGogGamesFoundInLibrary =>
      'Ingen GOG spil fundet i biblioteket. Prøv at synkronisere for at hente dem.';

  @override
  String get noGogGamesFoundMatchingSearch =>
      'Ingen GOG spil fundet matcher dine søgnings- og filterkriterier.';

  @override
  String get gogGameDetails => 'GOG Spil Detaljer';

  @override
  String get userRating => 'Bruger Bedømmelse';

  @override
  String get downloadSize => 'Download Størrelse';

  @override
  String get lastUpdate => 'Seneste Opdatering';

  @override
  String get developer => 'Udvikler';

  @override
  String get onlyTorrentsAreWorkingForNow => 'Kun torrents arbejder for nu.';

  @override
  String get couldNotFindDownloadLinks => 'Could not find download links';
}
