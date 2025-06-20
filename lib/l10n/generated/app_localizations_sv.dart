// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get success => 'Klart';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'Nya och populära repacks har skrotats.';

  @override
  String get error => 'Fel';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'Misslyckades att återställa data: $errorMessage';
  }

  @override
  String get home => 'Hem';

  @override
  String get rescrapeNewPopular => 'Skrapa nytt & populärt';

  @override
  String get newRepacks => 'Nya återfall';

  @override
  String get popularRepacks => 'Populära återfall';

  @override
  String get noCompletedGroupsToClear => 'Inga slutförda grupper att rensa.';

  @override
  String get queued => 'Köad';

  @override
  String get downloading => 'Hämtar:';

  @override
  String get completed => 'Slutförd';

  @override
  String get failed => 'Misslyckades';

  @override
  String get paused => 'Pausad';

  @override
  String get canceled => 'Avbruten';

  @override
  String get dismiss => 'Avfärda';

  @override
  String get confirmClear => 'Bekräfta rensning';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'grupper',
      one: 'grupp',
      zero: 'grupper',
    );
    return 'Är du säker på att du vill ta bort $count slutförd nedladdning $_temp0? Detta kommer också att ta bort filer från disken om de är i dedikerade undermappar som hanteras av appen.';
  }

  @override
  String get clearCompleted => 'Rensa slutförd';

  @override
  String get cancel => 'Avbryt';

  @override
  String completedGroupsCleared(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'grupper',
      one: 'grupp',
      zero: 'grupper',
    );
    return '$count slutförd $_temp0 rensad.';
  }

  @override
  String get downloadManager => 'Ladda ner hanteraren';

  @override
  String get maxConcurrent => 'Max samström';

  @override
  String get noActiveDownloads => 'Inga aktiva hämtningar.';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'Nedladdningar visas här när de har lagts till.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'Avbryt alla nedladdningar i denna grupp';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'Är du säker på att du vill avbryta alla nedladdningar i denna grupp och ta bort dem?';

  @override
  String completedNumberFiles(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'filer',
      one: 'fil',
      zero: 'filer',
    );
    return 'Avslutade $count $_temp0';
  }

  @override
  String overallProgressFilesPercent(num count, Object percent) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'filer',
      one: 'fil',
    );
    return 'Sammanlagt: $percent% ($count $_temp0)';
  }

  @override
  String noActiveTasks(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'filer',
      one: 'fil',
    );
    return 'Inga aktiva uppgifter eller framsteg ej tillgängliga ($count $_temp0)';
  }

  @override
  String cancelGroupName(Object groupName) {
    return 'Avbryt grupp: $groupName';
  }

  @override
  String get removeFromList => 'Ta bort från listan';

  @override
  String get resume => 'Fortsätt';

  @override
  String get pause => 'Pausa';

  @override
  String get errorTaskDataUnavailable => 'Fel: Uppgiftsdata ej tillgänglig';

  @override
  String get unknownFile => 'Okänd fil';

  @override
  String get yesCancelGroup => 'Ja, Annullera grupp';

  @override
  String get no => 'Nej';

  @override
  String get repackLibrary => 'Återuppta bibliotek';

  @override
  String get settings => 'Inställningar';

  @override
  String get unknown => 'Okänd';

  @override
  String get noReleaseNotesAvailable => 'Inga versionsfakta tillgängliga.';

  @override
  String get search => 'Sök';

  @override
  String updateAvailable(Object version) {
    return 'Uppdatering tillgänglig: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'En ny version av FitFlutter finns tillgänglig.';

  @override
  String get viewReleaseNotes => 'Visa versionsfakta';

  @override
  String get releasePage => 'Släpp sida';

  @override
  String get later => 'Senare';

  @override
  String get upgrade => 'Uppgradera';

  @override
  String get downloadsInProgress => 'Nedladdningar pågår';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'Avslutande av ansökan kommer att avbryta alla aktiva nedladdningar. ';

  @override
  String get areYouSureYouWantToClose => 'Är du säker på att du vill stänga?';

  @override
  String get yesCloseCancel => 'Ja, Stäng & Avbryt';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'Användaren valde att stänga; avbryter nedladdningar.';

  @override
  String get keepDownloading => 'Fortsätt ladda ner';

  @override
  String get startingLibrarySync => 'Startar bibliotekets synkronisering...';

  @override
  String get fetchingAllRepackNames => 'Hämtar alla namn på repack...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'sidor',
      one: 'sida',
    );
    return 'Hämtar namn: $page av $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails =>
      'Skrapar saknade detaljer om repack...';

  @override
  String get thisMayTakeAWhile => 'Det kan ta ett tag.';

  @override
  String scrapingMissingRepackDetailsProgress(num current, num total) {
    String _temp0 = intl.Intl.pluralLogic(
      current,
      locale: localeName,
      other: 'repacks',
      one: 'repack',
    );
    return 'Scraping fakta: $current/$total saknas $_temp0';
  }

  @override
  String get repackLibrarySynchronized =>
      'Återupptack-bibliotek synkroniserat.';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'Det gick inte att synkronisera bibliotek: $errorMessage';
  }

  @override
  String get syncLibrary => 'Synkronisera bibliotek';

  @override
  String get syncingLibrary => 'Synkroniserar biblioteket...';

  @override
  String get noRepacksFoundInTheLibrary =>
      'Inga repacks hittades i biblioteket.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'Inga repacks hittades som matchar $search.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'Fönstret är för smalt för att visa objekt korrekt.';

  @override
  String get pleaseResizeTheWindow => 'Vänligen ändra storlek på fönstret.';

  @override
  String get repackUrlIsNotAvailable => 'Repack-URL är inte tillgänglig.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'Kunde inte starta URL: $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return 'Kunde inte starta: $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return 'Ogiltigt URL-format: $url';
  }

  @override
  String get rescrapeDetails => 'Rescrape Detaljer';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return 'Detaljer för $title har återskapats och uppdaterats.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'Misslyckades att återskapa detaljer: $errorMessage';
  }

  @override
  String get errorRescraping => 'Fel vid återskrotning';

  @override
  String get openSourcePage => 'sida med öppen källkod';

  @override
  String noPopularNewRepacksFound(Object type) {
    return 'Inga $type repacks hittades.';
  }

  @override
  String get newest => 'ny';

  @override
  String get popular => 'populär';

  @override
  String get system => 'System';

  @override
  String get yellow => 'Gul';

  @override
  String get orange => 'Orange';

  @override
  String get red => 'Röd';

  @override
  String get magenta => 'Magenta';

  @override
  String get purple => 'Lila';

  @override
  String get blue => 'Blå';

  @override
  String get teal => 'Kricka';

  @override
  String get green => 'Grön';

  @override
  String get confirmForceRescrape => 'Bekräfta Tvinga Rescrape';

  @override
  String
  get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'Detta kommer att ta bort ALLA lokalt lagrade repack-data och ladda ner allt från källan. ';

  @override
  String
  get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'Denna process kan ta mycket lång tid och konsumera betydande nätverksdata. Är du säker?';

  @override
  String get yesRescrapeAll => 'Ja, Skrapa alla';

  @override
  String get startingFullDataRescrape => 'Startar full data rescrape...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'All data har skarpt skrotats om.';

  @override
  String errorMessage(Object error) {
    return 'Fel: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'Misslyckades att tvinga rescrape data: $errorMessage';
  }

  @override
  String get forceRescrapingData => 'Tvinga Rescraping Data';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'Nedladdningar & Installation';

  @override
  String get defaultDownloadPath => 'Standardsökväg för nedladdning';

  @override
  String get maxConcurrentDownloads => 'Max Samtidiga nedladdningar';

  @override
  String get automaticInstallation => 'Automatisk installation';

  @override
  String get enableAutoInstallAfterDownload =>
      'Aktivera automatisk installation efter nedladdning:';

  @override
  String get defaultInstallationPath => 'Standardsökväg för installation';

  @override
  String
  get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      'När aktiverad, kommer färdiga repacks att försöka installera till den angivna sökvägen.';

  @override
  String get appearance => 'Utseende';

  @override
  String get themeMode => 'Tema läge';

  @override
  String get navigationPaneDisplayMode => 'Visningsläge för navigationsruta';

  @override
  String get accentColor => 'Accentfärg';

  @override
  String get windowTransparency => 'Fönster Genomskinlighet';

  @override
  String get local => 'Lokalt';

  @override
  String get applicationUpdates => 'Programuppdateringar';

  @override
  String get updateCheckFrequency => 'Uppdatera kontrollfrekvens';

  @override
  String get currentAppVersion => 'Nuvarande appversion:';

  @override
  String get loading => 'Laddar...';

  @override
  String get latestAvailableVersion => 'Senaste tillgängliga version:';

  @override
  String get youAreOnTheLatestVersion => 'Du är på den senaste versionen';

  @override
  String get checking => 'Kontrollerar...';

  @override
  String get notCheckedYet => ' Inte kontrollerad ännu.';

  @override
  String get checkToSee => ' Markera för att se.';

  @override
  String get youHaveIgnoredThisUpdate => 'Du har ignorerat denna uppdatering.';

  @override
  String get unignoreCheckAgain => 'Ignorera och kontrollera igen';

  @override
  String get checkForUpdatesNow => 'Sök efter uppdateringar nu';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'Uppdatering till version $version är tillgänglig';
  }

  @override
  String get downloadAndInstallUpdate => 'Ladda ner och installera uppdatering';

  @override
  String get viewReleasePage => 'Visa releasesidan';

  @override
  String get dataManagement => 'Datahantering';

  @override
  String get forceRescrapeAllData => 'Tvinga Rescrape alla data';

  @override
  String
  get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'Varning: Denna process kan ta mycket lång tid och konsumera betydande nätverksdata. Använd med försiktighet.';

  @override
  String get rescrapingSeeDialog => 'Rescraping... Se dialogruta';

  @override
  String get forceRescrapeAllDataNow => 'Tvinga Rescrape All Data nu';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'En annan rescraping process är redan igång.';

  @override
  String get clearingAllExistingData => 'Rensar alla befintliga data...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'Skrapar alla namn repack (Fas 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'sidor',
      one: 'sida',
    );
    return 'Skrapning av alla repacknamn (fas 1/4): Sida $page av $totalPages $_temp0';
  }

  @override
  String allRepackNamesScrapedPhase1(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'namn',
      one: 'namn',
      zero: 'namn',
    );
    return 'Alla repacknamn skrapade. ($count $_temp0 (Fas 1/4 klar)';
  }

  @override
  String get scrapingDetailsForEveryRepackPhase2LongestPhase =>
      'Skrapning detaljer för varje repack (Fas 2/4 - Längsta fasen)...';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
    Object current,
    Object total,
  ) {
    return 'Skrapdetaljer för varje repack (fas 2/4): Repack $current i $total';
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
    return 'Alla repackdetaljer skrapade. ($count $_temp0 bearbetad (Fas 2/4 klar)';
  }

  @override
  String get rescrapingNewRepacksPhase3 =>
      'Rescraping nya repacks (Fas 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'Rescraping new repacks (Fas 3/4): Sida $current i $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'Nya repacks skrotade. (Fas 3/4 Färdig)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'Rescraping populära repacks (Fas 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'Rescraping populära repacks (fas 4/4): Artikel $current i $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'Populära repacks rescraped. (Fas 4/4 Komplett)';

  @override
  String get finalizing => 'Slutför...';

  @override
  String get fullRescrapeCompletedSuccessfully =>
      'Fullständig rescrape slutförd!';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'Fel: $errorMessage. Processen stoppades.';
  }

  @override
  String get daily => 'Dagligen';

  @override
  String get weekly => 'Veckovis';

  @override
  String get manual => 'Manuell';

  @override
  String get onEveryStartup => 'Vid varje uppstart';

  @override
  String get light => 'Ljus';

  @override
  String get dark => 'Mörk';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'Inga URL:er hittades i spegelkonfigurationen.';

  @override
  String get failedToProcessUnknownPlugin =>
      'Det gick inte att bearbeta (okänd plugin):';

  @override
  String get problemProcessingSomeLinks =>
      'Problem med att behandla några länkar. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'Fel vid behandling av en eller flera länkar. ';

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
  String get downloadStarted => 'Nedladdning påbörjad';

  @override
  String get ok => 'Ok';

  @override
  String get noFilesSelected => 'Inga filer valda';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'Välj en eller flera filer från trädet att ladda ner.';

  @override
  String get noFilesCouldBeRetrieved => 'Inga filer kunde hämtas.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
    Object processingError,
  ) {
    return 'Observera: $processingError Vissa filer kan ha stött på problem.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'Inga nedladdningsbara filer hittades för denna spegel.';

  @override
  String downloadFilesGame(Object Game) {
    return 'Ladda ner filer: $Game';
  }

  @override
  String get close => 'Stäng';

  @override
  String get downloadSelected => 'Ladda ner vald';

  @override
  String get aboutGame => 'Om spelet';

  @override
  String get features => 'Funktioner';

  @override
  String get selectDownloadOptions => 'Välj nedladdningsalternativ';

  @override
  String get downloadMethod => 'Ladda ner metod:';

  @override
  String get selectMethod => 'Välj metod';

  @override
  String get mirror => 'Spegla:';

  @override
  String get selectMirror => 'Välj spegel';

  @override
  String get downloadLocation => 'Ladda ner plats:';

  @override
  String get enterDownloadLocationOrBrowse =>
      'Ange nedladdningsplats eller bläddra';

  @override
  String get downloadLocationEmpty => 'Ladda ner plats tom';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'Välj eller ange en nedladdningsplats.';

  @override
  String get selectionIncomplete => 'Markeringen är ofullständig';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'Välj en nedladdningsmetod och en spegel.';

  @override
  String get next => 'Nästa';

  @override
  String get download => 'Hämta';

  @override
  String get downloadComplete => 'Nedladdning slutförd!';

  @override
  String get downloadPending => 'Ladda ner väntande...';

  @override
  String get genres => 'Genres';

  @override
  String get company => 'Företag';

  @override
  String get language => 'Språk';

  @override
  String get originalSize => 'Ursprunglig storlek';

  @override
  String get repackSize => 'Omvänd storlek';

  @override
  String get repackInformation => 'Upprepa information';

  @override
  String screenshotsTitle(Object count) {
    return 'Skärmdumpar ($count)';
  }

  @override
  String get errorLoadingImage => 'Fel vid inläsning av bild';

  @override
  String get noScreenshotsAvailable => 'Inga skärmdumpar tillgängliga.';

  @override
  String get noGenresAvailable => 'Inga genrer tillgängliga';

  @override
  String get clear => 'Rensa';

  @override
  String get filterByGenre => 'Filtrera efter genre';

  @override
  String get filter => 'Filtrera';

  @override
  String get gogLibrary => 'GOG bibliotek';

  @override
  String get syncGogLibrary => 'Synkronisera GOG bibliotek';

  @override
  String get startingGogSync => 'Startar GOG bibliotek synk...';

  @override
  String get fetchingGogGames => 'Hämtar GOG spel...';

  @override
  String fetchingGogGameDetails(Object current, Object total) {
    return 'Hämtar detaljer för GOG-spelet $current för $total...';
  }

  @override
  String get gogLibrarySynchronized =>
      'GOG bibliotek har synkroniserats framgångsrikt.';

  @override
  String failedToSyncGogLibrary(Object error) {
    return 'Det gick inte att synkronisera GOG-bibliotek: $error';
  }

  @override
  String get noGogGamesFoundInLibrary =>
      'Inga GOG-spel hittades i biblioteket. Försök att synkronisera för att hämta dem.';

  @override
  String get noGogGamesFoundMatchingSearch =>
      'Inga GOG spel hittades som matchar din sökning och filter kriterier.';

  @override
  String get gogGameDetails => 'GOG speldetaljer';

  @override
  String get userRating => 'Användar betyg';

  @override
  String get downloadSize => 'Ladda ner storlek';

  @override
  String get lastUpdate => 'Senaste uppdatering';

  @override
  String get developer => 'Utvecklare';

  @override
  String get onlyTorrentsAreWorkingForNow =>
      'Endast torrenter arbetar för tillfället.';

  @override
  String get couldNotFindDownloadLinks => 'Kunde inte hitta nedladdningslänkar';
}
