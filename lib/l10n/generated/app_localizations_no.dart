// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian (`no`).
class AppLocalizationsNo extends AppLocalizations {
  AppLocalizationsNo([String locale = 'no']) : super(locale);

  @override
  String get success => 'Vellykket';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'Nye og populære repakker har blitt omskyndt.';

  @override
  String get error => 'Feil';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'Kan ikke rescrape data: $errorMessage';
  }

  @override
  String get home => 'Hjem';

  @override
  String get rescrapeNewPopular => 'Skap nye & populære';

  @override
  String get newRepacks => 'Nye Reparasjoner';

  @override
  String get popularRepacks => 'Populære rester';

  @override
  String get noCompletedGroupsToClear => 'Ingen avsluttede grupper å fjerne.';

  @override
  String get queued => 'Køet';

  @override
  String get downloading => 'Laster ned:';

  @override
  String get completed => 'Fullført';

  @override
  String get failed => 'Mislyktes';

  @override
  String get paused => 'Pauset';

  @override
  String get canceled => 'Avbrutt';

  @override
  String get dismiss => 'Avvis';

  @override
  String get confirmClear => 'Bekreft tømming';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'grupper',
      one: 'Grupper',
      zero: 'Grupper',
    );
    return 'Er du sikker på at du vil fjerne $count fullførte nedlastingen $_temp0? Dette vil også fjerne filer fra disken hvis de er i dedikerte undermapper administrert av appen.';
  }

  @override
  String get clearCompleted => 'Fjern fullført';

  @override
  String get cancel => 'Avbryt';

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
  String get downloadManager => 'Nedlastingshjelper';

  @override
  String get maxConcurrent => 'Maks samspill';

  @override
  String get noActiveDownloads => 'Ingen aktive nedlastinger.';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'Nedlastet vil vises her når lagt til.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'Avbryt alle nedlastinger i denne gruppen';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'Er du sikker på at du vil avbryte alle nedlastinger i denne gruppen og fjerne dem?';

  @override
  String completedNumberFiles(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'filer',
      one: 'Filen',
      zero: 'filer',
    );
    return 'Fullført $count $_temp0';
  }

  @override
  String overallProgressFilesPercent(num count, Object percent) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'filer',
      one: 'Fil',
    );
    return 'Totalt : $percent% ($count $_temp0';
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
    return 'Avbryt gruppe: $groupName';
  }

  @override
  String get removeFromList => 'Fjern fra listen';

  @override
  String get resume => 'Fortsett';

  @override
  String get pause => 'pause';

  @override
  String get errorTaskDataUnavailable =>
      'Feil: Oppgavedata er ikke tilgjengelige';

  @override
  String get unknownFile => 'Ukjent fil';

  @override
  String get yesCancelGroup => 'Ja, avbryt gruppe';

  @override
  String get no => 'Nei';

  @override
  String get repackLibrary => 'Reparer bibliotek';

  @override
  String get settings => 'Innstillinger';

  @override
  String get unknown => 'Ukjent';

  @override
  String get noReleaseNotesAvailable => 'Ingen utgivelsesnotater tilgjengelig.';

  @override
  String get search => 'Søk';

  @override
  String updateAvailable(Object version) {
    return 'Oppdatering tilgjengelig: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'En ny versjon av FitFlutter er tilgjengelig.';

  @override
  String get viewReleaseNotes => 'Se utgivelsesnotater';

  @override
  String get releasePage => 'Utgivelsesside';

  @override
  String get later => 'Senere';

  @override
  String get upgrade => 'Oppgrader';

  @override
  String get downloadsInProgress => 'Nedlastinger i gang';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'Om du lukker programmet, vil alle aktive nedlastinger bli slettet. ';

  @override
  String get areYouSureYouWantToClose => 'Er du sikker på at du vil avslutte?';

  @override
  String get yesCloseCancel => 'Ja, lukk og Avbryt';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'Bruker velger å lukke, kansellere nedlastinger.';

  @override
  String get keepDownloading => 'Fortsett å laste ned';

  @override
  String get startingLibrarySync => 'Starter bibliotekets synkronisering...';

  @override
  String get fetchingAllRepackNames => 'Henter navn på alle repakker...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'sider',
      one: 'Side',
    );
    return 'Henter navn: $page av $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails =>
      'Scraping manglende repack detaljer...';

  @override
  String get thisMayTakeAWhile => 'Dette kan ta en stund.';

  @override
  String scrapingMissingRepackDetailsProgress(num current, num total) {
    String _temp0 = intl.Intl.pluralLogic(
      current,
      locale: localeName,
      other: 'repacks',
      one: 'repakke',
    );
    return 'Scraping detaljer: $current/$total mangler $_temp0';
  }

  @override
  String get repackLibrarySynchronized => 'Repeter biblioteket synkronisert.';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'Kan ikke synkronisere biblioteket: $errorMessage';
  }

  @override
  String get syncLibrary => 'Synkroniser bibliotek';

  @override
  String get syncingLibrary => 'Synkroniserer bibliotek...';

  @override
  String get noRepacksFoundInTheLibrary =>
      'Ingen repacks finnes i biblioteket.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'Ingen repacks funnet samsvarer med $search.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'Vinduet er for smalt til å vise korrekt element.';

  @override
  String get pleaseResizeTheWindow => 'Vennligst endre størrelse på vinduet.';

  @override
  String get repackUrlIsNotAvailable => 'Repack-URL er ikke tilgjengelig.';

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
    return 'Ugyldig URL-format: $url';
  }

  @override
  String get rescrapeDetails => 'Rescrape detaljer';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return 'Detaljer for $title er omskrapet og oppdatert.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'Kan ikke rescrape detaljer: $errorMessage';
  }

  @override
  String get errorRescraping => 'Feil under omskraping';

  @override
  String get openSourcePage => 'Åpen kildekode-side';

  @override
  String noPopularNewRepacksFound(Object type) {
    return 'Ingen $type repacks funnet.';
  }

  @override
  String get newest => 'ny';

  @override
  String get popular => 'populær';

  @override
  String get system => 'Systemadministrasjon';

  @override
  String get yellow => 'Gul';

  @override
  String get orange => 'Oransje';

  @override
  String get red => 'Rød';

  @override
  String get magenta => 'Magentarød';

  @override
  String get purple => 'Lilla';

  @override
  String get blue => 'Blå';

  @override
  String get teal => 'Blågrønn';

  @override
  String get green => 'Grønn';

  @override
  String get confirmForceRescrape => 'Bekreft Tving Rescrape';

  @override
  String
  get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'Dette vil slette ALLE lagrede repakkedata og laste ned alt fra kilden. ';

  @override
  String
  get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'Denne prosessen kan ta veldig lang tid og forbruke betydelige nettverksdata. Er du sikker?';

  @override
  String get yesRescrapeAll => 'Ja, skall ut alle';

  @override
  String get startingFullDataRescrape => 'Starter full data omskrape...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'Alle data har blitt kraftig omskrapet.';

  @override
  String errorMessage(Object error) {
    return 'Feil: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'Kan ikke tvinge rescrape-data: $errorMessage';
  }

  @override
  String get forceRescrapingData => 'Tving omstart av data';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'Nedlastinger og installasjon';

  @override
  String get defaultDownloadPath => 'Standard nedlastingssti';

  @override
  String get maxConcurrentDownloads => 'Maks samtidige nedlastinger';

  @override
  String get automaticInstallation => 'Automatisk installasjon';

  @override
  String get enableAutoInstallAfterDownload =>
      'Aktiver automatisk installering etter nedlasting:';

  @override
  String get defaultInstallationPath => 'Standard installasjons-sti';

  @override
  String
  get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      'Når aktivert, vil fullførte repacks forsøke å installere til den angitte stien.';

  @override
  String get appearance => 'Utseende';

  @override
  String get themeMode => 'Tema modus';

  @override
  String get navigationPaneDisplayMode => 'Navigasjonskjøter Visningsmodus';

  @override
  String get accentColor => 'Inngående farge';

  @override
  String get windowTransparency => 'Vindu er gjennomsiktighet';

  @override
  String get local => 'Språk';

  @override
  String get applicationUpdates =>
      'Programoppdateringer (Automatic Translation)';

  @override
  String get updateCheckFrequency => 'Oppdaterings kontrollfrekvens';

  @override
  String get currentAppVersion => 'Gjeldende App versjon:';

  @override
  String get loading => 'Laster...';

  @override
  String get latestAvailableVersion => 'Siste tilgjengelige versjon:';

  @override
  String get youAreOnTheLatestVersion => 'Du er på den nyeste versjonen';

  @override
  String get checking => 'Kontrollerer...';

  @override
  String get notCheckedYet => ' Ikke sjekket enda.';

  @override
  String get checkToSee => ' Sjekk for å se.';

  @override
  String get youHaveIgnoredThisUpdate => 'Du har ignorert denne oppdateringen.';

  @override
  String get unignoreCheckAgain => 'Unignore & sjekk igjen';

  @override
  String get checkForUpdatesNow => 'Se etter oppdateringer nå';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'Oppdatering til versjon $version er tilgjengelig';
  }

  @override
  String get downloadAndInstallUpdate => 'Last ned og installer oppdatering';

  @override
  String get viewReleasePage => 'Vis utgivelsessiden';

  @override
  String get dataManagement => 'Administrasjon av data';

  @override
  String get forceRescrapeAllData => 'Tving «Rescrape» alle data';

  @override
  String
  get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'Advarsel: Denne prosessen kan ta svært lang tid og bruke betydelige nettverksdata. Bruk med forsiktighet.';

  @override
  String get rescrapingSeeDialog => 'Rescraping... Se vinduet';

  @override
  String get forceRescrapeAllDataNow => 'Tving «Rescrape» all data nå';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'En annen omskraping pågår allerede.';

  @override
  String get clearingAllExistingData => 'Sletter alle eksisterende data...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'Skraping av alle repakkenavn (Fase 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'sider',
      one: 'Side',
    );
    return 'Skraper alle reaknavnene (Fase 1/4): Side $page av $totalPages $_temp0';
  }

  @override
  String allRepackNamesScrapedPhase1(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'navn',
      one: 'navn',
      zero: 'navn',
    );
    return 'Alle repakkens navn skrapet. ($count $_temp0 (Fase 1/4 Fullført)';
  }

  @override
  String get scrapingDetailsForEveryRepackPhase2LongestPhase =>
      'Scraping detaljer for hver repakke (Fase 2/4 - lengste fase)';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
    Object current,
    Object total,
  ) {
    return 'Scraping for hver repack (Fase 2/4): Repack $current av $total';
  }

  @override
  String allRepackDetailsScrapedPhase2(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'repacks',
      one: 'repakke',
      zero: 'repacks',
    );
    return 'Alle detaljer om pakke skrapet. ($count $_temp0 behandlet (Fase 2/4 Komplett)';
  }

  @override
  String get rescrapingNewRepacksPhase3 => 'Skraper nye repakker (Fase 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'Videreføring av nye repakker (Fase 3/4): Side $current av $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'Nye repacks rescraped. (Fase 3/4 fullført)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'Rescraping populære repakker (fase 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'Utvikling av populære repakker (fase 4/4): Gjenstand $current av $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'Populære repacks resraped. (Fase 4/4 fullført)';

  @override
  String get finalizing => 'Fullfører...';

  @override
  String get fullRescrapeCompletedSuccessfully => 'Full rescrape fullført!';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'Feil: $errorMessage. Prosess stanset.';
  }

  @override
  String get daily => 'Daglig';

  @override
  String get weekly => 'Ukentlig';

  @override
  String get manual => 'Manuell';

  @override
  String get onEveryStartup => 'Ved hver oppstart';

  @override
  String get light => 'Lys';

  @override
  String get dark => 'Mørk';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'Ingen URL-er funnet i speilkonfigurasjonen.';

  @override
  String get failedToProcessUnknownPlugin =>
      'Mislyktes i å prosessere (ukjent plugin):';

  @override
  String get problemProcessingSomeLinks =>
      'Problem med behandling av noen lenker. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'Feil under behandling av én eller flere lenker. ';

  @override
  String filesAddedToDownloadManager(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'filer',
      one: 'Fil',
      zero: 'filer',
    );
    return '$count $_temp0 lagt til i nedlastingshåndterer.';
  }

  @override
  String get downloadStarted => 'Nedlastingen har startet';

  @override
  String get ok => 'Ok';

  @override
  String get noFilesSelected => 'Ingen filer valgt';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'Velg en eller flere filer fra treet for å laste ned.';

  @override
  String get noFilesCouldBeRetrieved => 'Ingen filer kunne hentes.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
    Object processingError,
  ) {
    return 'Merk: $processingError Noen filer kan ha oppstått problemer.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'Ingen nedlastbare filer funnet i dette speilet.';

  @override
  String downloadFilesGame(Object Game) {
    return 'Last ned filer: $Game';
  }

  @override
  String get close => 'Lukk';

  @override
  String get downloadSelected => 'Last ned valgte';

  @override
  String get aboutGame => 'Om spillet';

  @override
  String get features => 'Funksjoner';

  @override
  String get selectDownloadOptions => 'Velg alternativer for nedlasting';

  @override
  String get downloadMethod => 'Metode for nedlasting:';

  @override
  String get selectMethod => 'Velg metode';

  @override
  String get mirror => 'Speilvend:';

  @override
  String get selectMirror => 'Velg speil';

  @override
  String get downloadLocation => 'Last ned plassering:';

  @override
  String get enterDownloadLocationOrBrowse =>
      'Angi nedlastingssted eller bla gjennom';

  @override
  String get downloadLocationEmpty => 'Nedlastingsplasseringen er tom';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'Velg eller skriv inn et nedlastingssted.';

  @override
  String get selectionIncomplete => 'Utvalg ufullstendig';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'Vennligst velg en nedlastingsmetode og et speil.';

  @override
  String get next => 'Neste';

  @override
  String get download => 'Nedlasting';

  @override
  String get downloadComplete => 'Nedlasting fullført!';

  @override
  String get downloadPending => 'Nedlasting venter...';

  @override
  String get genres => 'Genres';

  @override
  String get company => 'Firma';

  @override
  String get language => 'Språk';

  @override
  String get originalSize => 'Opprinnelig størrelse';

  @override
  String get repackSize => 'Repakk størrelse';

  @override
  String get repackInformation => 'Reparer informasjon';

  @override
  String screenshotsTitle(Object count) {
    return 'Skjermbilder ($count)';
  }

  @override
  String get errorLoadingImage => 'Feil ved lasting av bilde';

  @override
  String get noScreenshotsAvailable => 'Ingen skjermbilder tilgjengelig.';

  @override
  String get noGenresAvailable => 'Ingen sjangre tilgjengelig';

  @override
  String get clear => 'Tøm';

  @override
  String get filterByGenre => 'Filtrer etter Sjanger';

  @override
  String get filter => 'Filtrer';

  @override
  String get gogLibrary => 'GOG Bibliotek';

  @override
  String get syncGogLibrary => 'Synkroniser GOG bibliotek';

  @override
  String get startingGogSync => 'Starter GOG-bibliotekets synkronisering...';

  @override
  String get fetchingGogGames => 'Henter GOG-spill...';

  @override
  String fetchingGogGameDetails(Object current, Object total) {
    return 'Henter detaljer for GOG spill $current av $total...';
  }

  @override
  String get gogLibrarySynchronized => 'Biblioteket har blitt synkronisert.';

  @override
  String failedToSyncGogLibrary(Object error) {
    return 'Kan ikke synkronisere GOG bibliotek: $error';
  }

  @override
  String get noGogGamesFoundInLibrary =>
      'Ingen GOG-spill funnet i biblioteket. Prøv å synkronisere for å hente dem.';

  @override
  String get noGogGamesFoundMatchingSearch =>
      'Ingen GOG-spill funnet som samsvarer med søke- og filterkriteriene.';

  @override
  String get gogGameDetails => 'GOG spilldetaljer';

  @override
  String get userRating => 'Bruker Vurdering';

  @override
  String get downloadSize => 'Nedlasting Størrelse';

  @override
  String get lastUpdate => 'Siste oppdatering';

  @override
  String get developer => 'Utvikler';

  @override
  String get onlyTorrentsAreWorkingForNow =>
      'Kun torrenter jobber for øyeblikket.';

  @override
  String get couldNotFindDownloadLinks => 'Kunne ikke finne nedlastingslenker';
}
