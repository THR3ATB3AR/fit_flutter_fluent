// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get success => 'Onnistui';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'Uusia ja suosittuja repacks on uusittu.';

  @override
  String get error => 'Virhe';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'Tietojen uudelleencrape epäonnistui: $errorMessage';
  }

  @override
  String get home => 'Koti';

  @override
  String get rescrapeNewPopular => 'Uudelleennimeä Uusi & Suosittu';

  @override
  String get newRepacks => 'Uudet Repacks';

  @override
  String get popularRepacks => 'Suositut Repaketit';

  @override
  String get noCompletedGroupsToClear =>
      'Ei valmiiksi valmistuneita ryhmiä selvitettäväksi.';

  @override
  String get queued => 'Jonossa';

  @override
  String get downloading => 'Ladataan:';

  @override
  String get completed => 'Valmis';

  @override
  String get failed => 'Epäonnistui';

  @override
  String get paused => 'Keskeytetty';

  @override
  String get canceled => 'Peruttu';

  @override
  String get dismiss => 'Hylkää';

  @override
  String get confirmClear => 'Vahvista Tyhjennys';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ryhmät',
      one: 'group',
      zero: 'groups',
    );
    return 'Are you sure you want to remove $count completed download $_temp0? Tämä poistaa myös tiedostoja levyltä, jos ne ovat sovelluksen hallinnoimissa alakansioissa.';
  }

  @override
  String get clearCompleted => 'Tyhjennä Valmiit';

  @override
  String get cancel => 'Peruuta';

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
  String get downloadManager => 'Latausten Hallinta';

  @override
  String get maxConcurrent => 'Maksimi Samanaikainen';

  @override
  String get noActiveDownloads => 'Ei aktiivisia latauksia.';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'Lataukset näkyvät täällä kun ne on lisätty.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'Peruuta kaikki tämän ryhmän lataukset';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'Oletko varma, että haluat peruuttaa kaikki tämän ryhmän lataukset ja poistaa ne?';

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
    return 'Peruuta Ryhmä: $groupName';
  }

  @override
  String get removeFromList => 'Poista luettelosta';

  @override
  String get resume => 'Jatka';

  @override
  String get pause => 'Tauko';

  @override
  String get errorTaskDataUnavailable =>
      'Virhe: Tehtävän tiedot eivät ole käytettävissä';

  @override
  String get unknownFile => 'Tuntematon Tiedosto';

  @override
  String get yesCancelGroup => 'Kyllä, Peruuta Ryhmä';

  @override
  String get no => 'Ei';

  @override
  String get repackLibrary => 'Pakkaa Kirjasto';

  @override
  String get settings => 'Asetukset';

  @override
  String get unknown => 'Tuntematon';

  @override
  String get noReleaseNotesAvailable => 'Julkaisutietoja ei ole saatavilla.';

  @override
  String get search => 'Etsi';

  @override
  String updateAvailable(Object version) {
    return 'Päivitä Saatavilla: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'FitFlutterin uusi versio on saatavilla.';

  @override
  String get viewReleaseNotes => 'Näytä Julkaisutiedot';

  @override
  String get releasePage => 'Julkaisu Sivu';

  @override
  String get later => 'Myöhemmin';

  @override
  String get upgrade => 'Päivitä';

  @override
  String get downloadsInProgress => 'Lataukset käynnissä';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'Sovelluksen sulkeminen peruuttaa kaikki aktiiviset lataukset. ';

  @override
  String get areYouSureYouWantToClose => 'Oletko varma, että haluat sulkea?';

  @override
  String get yesCloseCancel => 'Kyllä, Sulje & Peruuta';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'Käyttäjä päätti sulkea; peruutetaan lataukset.';

  @override
  String get keepDownloading => 'Jatka Lataamista';

  @override
  String get startingLibrarySync => 'Käynnistetään kirjaston synkronointi...';

  @override
  String get fetchingAllRepackNames => 'Haetaan kaikkia repack-nimiä...';

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
      'Puretaan puuttuvia repack-tietoja...';

  @override
  String get thisMayTakeAWhile => 'Tämä voi kestää jonkin aikaa.';

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
  String get repackLibrarySynchronized => 'Repack-kirjasto synkronoitu.';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'Kirjaston synkronointi epäonnistui: $errorMessage';
  }

  @override
  String get syncLibrary => 'Synkronoi Kirjasto';

  @override
  String get syncingLibrary => 'Synkronoidaan Kirjastoa...';

  @override
  String get noRepacksFoundInTheLibrary =>
      'Kirjastosta ei löytynyt repaketteja.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'Vastaavaa pakettia ei löytynyt $search.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'Ikkuna on liian kapea näyttääkseen kohteita oikein.';

  @override
  String get pleaseResizeTheWindow => 'Ole hyvä ja muokkaa ikkunaa.';

  @override
  String get repackUrlIsNotAvailable => 'Repack URL ei ole käytettävissä.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'URL-osoitetta ei voitu käynnistää: $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return 'Ei voitu käynnistää: $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return 'Virheellinen URL-muoto: $url';
  }

  @override
  String get rescrapeDetails => 'Uudelleennimeämisen Tiedot';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return '$title tiedot on uusittu ja päivitetty.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'Tietoja ei voitu uudelleen: $errorMessage';
  }

  @override
  String get errorRescraping => 'Virhe Romuttamisessa';

  @override
  String get openSourcePage => 'Avaa Lähdesivu';

  @override
  String noPopularNewRepacksFound(Object type) {
    return '$type repakettia ei löytynyt.';
  }

  @override
  String get newest => 'uusi';

  @override
  String get popular => 'suosittu';

  @override
  String get system => 'Järjestelmä';

  @override
  String get yellow => 'Keltainen';

  @override
  String get orange => 'Oranssi';

  @override
  String get red => 'Punainen';

  @override
  String get magenta => 'Purppura';

  @override
  String get purple => 'Violetti';

  @override
  String get blue => 'Sininen';

  @override
  String get teal => 'Sinappi';

  @override
  String get green => 'Vihreä';

  @override
  String get confirmForceRescrape => 'Vahvista Uudelleennimeäminen';

  @override
  String get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'Tämä poistaa KAIKKI paikallisesti tallennetut tiedot ja lataa kaikki uudelleen lähteestä. ';

  @override
  String get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'Tämä prosessi voi kestää hyvin kauan ja kuluttaa merkittäviä verkkotietoja. Oletko varma?';

  @override
  String get yesRescrapeAll => 'Kyllä, Uudelleennimeä Kaikki';

  @override
  String get startingFullDataRescrape =>
      'Aloitetaan täydet tiedot uudelleennimeä...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'Kaikki tiedot on tiukasti uusittu.';

  @override
  String errorMessage(Object error) {
    return 'Virhe: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'Rescrape datan pakottaminen epäonnistui: $errorMessage';
  }

  @override
  String get forceRescrapingData => 'Pakota Rescraping Data';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'Lataukset Ja Asennus';

  @override
  String get defaultDownloadPath => 'Oletus Latauspolku';

  @override
  String get maxConcurrentDownloads => 'Maksimi Samanaikaiset Lataukset';

  @override
  String get automaticInstallation => 'Automaattinen Asennus';

  @override
  String get enableAutoInstallAfterDownload =>
      'Ota käyttöön automaattinen asennus latauksen jälkeen:';

  @override
  String get defaultInstallationPath => 'Asennuksen Oletuspolku';

  @override
  String get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      'Kun käytössä, valmiit repaketit yrittävät asentaa määritellylle polulle.';

  @override
  String get appearance => 'Ulkoasu';

  @override
  String get themeMode => 'Teeman tila';

  @override
  String get navigationPaneDisplayMode => 'Navigointipaneelin Näyttötila';

  @override
  String get accentColor => 'Korostettu Väri';

  @override
  String get windowTransparency => 'Ikkunan Läpinäkyvyys';

  @override
  String get local => 'Lokaatio';

  @override
  String get applicationUpdates => 'Sovelluksen Päivitykset';

  @override
  String get updateCheckFrequency => 'Päivityksen Tarkistustiheys';

  @override
  String get currentAppVersion => 'Nykyinen Sovelluksen Versio:';

  @override
  String get loading => 'Ladataan...';

  @override
  String get latestAvailableVersion => 'Viimeisin Käytettävissä Oleva Versio:';

  @override
  String get youAreOnTheLatestVersion => 'Olet viimeisessä versiossa';

  @override
  String get checking => 'Tarkistetaan...';

  @override
  String get notCheckedYet => ' Ei vielä tarkistettu.';

  @override
  String get checkToSee => ' Tarkista nähtäväksi.';

  @override
  String get youHaveIgnoredThisUpdate => 'Olet ohittanut tämän päivityksen.';

  @override
  String get unignoreCheckAgain => 'Tasoita & Tarkista Uudelleen';

  @override
  String get checkForUpdatesNow => 'Tarkista päivitykset nyt';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'Päivitä versioon $version on saatavilla';
  }

  @override
  String get downloadAndInstallUpdate => 'Lataa ja asenna päivitys';

  @override
  String get viewReleasePage => 'Näytä Julkaisusivu';

  @override
  String get dataManagement => 'Tietojen Hallinta';

  @override
  String get forceRescrapeAllData => 'Pakota Uudelleennimeämään Kaikki Tiedot';

  @override
  String get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'Varoitus: Tämä prosessi voi kestää hyvin kauan ja kuluttaa merkittäviä verkkotietoja. Käytä varoen.';

  @override
  String get rescrapingSeeDialog => 'Rajoitetaan... Katso Dialogi';

  @override
  String get forceRescrapeAllDataNow =>
      'Pakota Uudelleennimeämään Kaikki Tiedot Nyt';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'Toinen uusintaprosessi on jo käynnissä.';

  @override
  String get clearingAllExistingData =>
      'Tyhjennetään kaikki olemassa olevat tiedot...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'Tarkistetaan kaikki repack-nimet (vaihe 1/4)...';

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
      'Scraping yksityiskohdat jokaiselle repack (vaihe 2/4 - Pisin vaihe)...';

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
      'Uudelleennimeä uusia paketteja (vaihe 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'Rescraping new repacks (Phase 3/4): Page $current of $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'Uudet repacks rescraped. (faasi 3/4 Complete)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'Luodaan suosittuja repaketteja (vaihe 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'Rescraping popular repacks (Phase 4/4): Item $current of $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'Suosittuja repacks rescraped. (faasi 4/4 Complete)';

  @override
  String get finalizing => 'Viimeistetään...';

  @override
  String get fullRescrapeCompletedSuccessfully =>
      'Täysi rescrape suoritettu onnistuneesti!';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'Virhe: $errorMessage. Prosessi pysäytetty.';
  }

  @override
  String get daily => 'Päivittäin';

  @override
  String get weekly => 'Viikoittain';

  @override
  String get manual => 'Manuaalinen';

  @override
  String get onEveryStartup => 'Jokaisella Käynnistyksellä';

  @override
  String get light => 'Vaalea';

  @override
  String get dark => 'Tumma';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'Peilin kokoonpanossa ei löytynyt URL-osoitteita.';

  @override
  String get failedToProcessUnknownPlugin =>
      'Käsittely epäonnistui (Tuntematon lisäosa):';

  @override
  String get problemProcessingSomeLinks =>
      'Ongelma joidenkin linkkien käsittelyssä. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'Virhe yhden tai useamman linkin käsittelyssä. ';

  @override
  String filesAddedToDownloadManager(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'tiedostoja',
      one: 'tiedosto',
      zero: 'tiedostoja',
    );
    return '$count $_temp0 lisätty lataushallintaan.';
  }

  @override
  String get downloadStarted => 'Lataus Aloitettu';

  @override
  String get ok => 'Ok';

  @override
  String get noFilesSelected => 'Ei Valittuja Tiedostoja';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'Valitse yksi tai useampi tiedosto puusta ladattavaksi.';

  @override
  String get noFilesCouldBeRetrieved => 'Yhtään tiedostoa ei voitu hakea.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
      Object processingError) {
    return 'Huomautus: $processingError Joitakin tiedostoja on saattanut kohdata ongelmia.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'Tälle peilille ei löytynyt ladattavia tiedostoja.';

  @override
  String downloadFilesGame(Object Game) {
    return 'Lataa Tiedostot: $Game';
  }

  @override
  String get close => 'Sulje';

  @override
  String get downloadSelected => 'Lataa Valitut';

  @override
  String get aboutGame => 'Tietoja pelistä';

  @override
  String get features => 'Ominaisuudet';

  @override
  String get selectDownloadOptions => 'Valitse latausasetukset';

  @override
  String get downloadMethod => 'Lataustapa:';

  @override
  String get selectMethod => 'Valitse menetelmä';

  @override
  String get mirror => 'Peili:';

  @override
  String get selectMirror => 'Valitse peili';

  @override
  String get downloadLocation => 'Lataa Sijainti:';

  @override
  String get enterDownloadLocationOrBrowse => 'Syötä lataussijainti tai selaa';

  @override
  String get downloadLocationEmpty => 'Lataa Sijainti Tyhjä';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'Valitse tai kirjoita latauspaikka.';

  @override
  String get selectionIncomplete => 'Valinta Epätäydellinen';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'Ole hyvä ja valitse latausmenetelmä ja peili.';

  @override
  String get next => 'Seuraava';

  @override
  String get download => 'Lataa';

  @override
  String get downloadComplete => 'Lataus valmis!';

  @override
  String get downloadPending => 'Lataa odottava...';

  @override
  String get genres => 'Genres';

  @override
  String get company => 'Yritys';

  @override
  String get language => 'Kieli';

  @override
  String get originalSize => 'Alkuperäinen Koko';

  @override
  String get repackSize => 'Repackin Koko';

  @override
  String get repackInformation => 'Repack Information';

  @override
  String screenshotsTitle(Object count) {
    return 'Screenshots ($count)';
  }

  @override
  String get errorLoadingImage => 'Virhe ladattaessa kuvaa';

  @override
  String get noScreenshotsAvailable => 'Kuvakaappauksia ei ole saatavilla.';

  @override
  String get noGenresAvailable => 'Lajityyppejä ei saatavilla';

  @override
  String get clear => 'Tyhjennä';

  @override
  String get filterByGenre => 'Suodata lajin mukaan';

  @override
  String get filter => 'Suodatin';
}
