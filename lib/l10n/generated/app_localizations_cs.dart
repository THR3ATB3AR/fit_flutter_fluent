// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get success => 'Úspěšně';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'Nové a Populární reklam byly překrývány.';

  @override
  String get error => 'Chyba';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'Nepodařilo se rescrape data: $errorMessage';
  }

  @override
  String get home => 'Domů';

  @override
  String get rescrapeNewPopular => 'Rescrape Nový & Populární';

  @override
  String get newRepacks => 'Nové repozitáře';

  @override
  String get popularRepacks => 'Populární repozitáře';

  @override
  String get noCompletedGroupsToClear => 'Žádné dokončené skupiny k vymazání.';

  @override
  String get queued => 'Ve frontě';

  @override
  String get downloading => 'Stahování:';

  @override
  String get completed => 'Dokončeno';

  @override
  String get failed => 'Selhalo';

  @override
  String get paused => 'Pozastaveno';

  @override
  String get canceled => 'Zrušeno';

  @override
  String get dismiss => 'Odmítnout';

  @override
  String get confirmClear => 'Potvrdit odstranění';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'skupiny',
      one: 'skupina',
      zero: 'skupiny',
    );
    return 'Jste si jisti, že chcete odstranit $count dokončené stahování $_temp0? Toto také odstraní soubory z disku, pokud jsou ve specializovaných podsložkách spravovaných aplikací.';
  }

  @override
  String get clearCompleted => 'Vymazání dokončeno';

  @override
  String get cancel => 'Zrušit';

  @override
  String completedGroupsCleared(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'skupiny',
      one: 'skupina',
      zero: 'skupiny',
    );
    return '$count dokončeno $_temp0 vymazány.';
  }

  @override
  String get downloadManager => 'Správce stahování';

  @override
  String get maxConcurrent => 'Max souběžně';

  @override
  String get noActiveDownloads => 'Žádné aktivní stahování.';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'Stahování se zobrazí po přidání.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'Zrušit všechna stahování v této skupině';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'Jste si jisti, že chcete zrušit všechna stahování v této skupině a odstranit je?';

  @override
  String completedNumberFiles(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'soubory',
      one: 'soubor',
      zero: 'soubory',
    );
    return 'Dokončeno $count $_temp0';
  }

  @override
  String overallProgressFilesPercent(num count, Object percent) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'soubory',
      one: 'soubor',
    );
    return 'Celkem: $percent% ($count $_temp0)';
  }

  @override
  String noActiveTasks(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'soubory',
      one: 'soubor',
    );
    return 'Žádné aktivní úkoly nebo postup není k dispozici ($count $_temp0)';
  }

  @override
  String cancelGroupName(Object groupName) {
    return 'Zrušit skupinu: $groupName';
  }

  @override
  String get removeFromList => 'Odstranit ze seznamu';

  @override
  String get resume => 'Pokračovat';

  @override
  String get pause => 'Pozastavit';

  @override
  String get errorTaskDataUnavailable => 'Chyba: Data úkolů nejsou k dispozici';

  @override
  String get unknownFile => 'Neznámý soubor';

  @override
  String get yesCancelGroup => 'Ano, zrušit skupinu';

  @override
  String get no => 'Ne';

  @override
  String get repackLibrary => 'Knihovna repozitářů';

  @override
  String get settings => 'Nastavení';

  @override
  String get unknown => 'Neznámý';

  @override
  String get noReleaseNotesAvailable =>
      'Nejsou k dispozici žádné poznámky k vydání.';

  @override
  String get search => 'Hledat';

  @override
  String updateAvailable(Object version) {
    return 'Aktualizace k dispozici: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'Je k dispozici nová verze FitFlutter.';

  @override
  String get viewReleaseNotes => 'Zobrazit poznámky k vydání';

  @override
  String get releasePage => 'Stránka vydání';

  @override
  String get later => 'Později';

  @override
  String get upgrade => 'Vylepšit';

  @override
  String get downloadsInProgress => 'Probíhá stahování';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'Uzavření aplikace zruší všechna aktivní stahování. ';

  @override
  String get areYouSureYouWantToClose => 'Opravdu chcete zavřít?';

  @override
  String get yesCloseCancel => 'Ano, zavřít a zrušit';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'Uživatel se rozhodl zavřít; ruší stahování.';

  @override
  String get keepDownloading => 'Pokračovat v stahování';

  @override
  String get startingLibrarySync => 'Spouštění synchronizace knihovny...';

  @override
  String get fetchingAllRepackNames => 'Načítání všech jmen reppacků...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'stránky',
      one: 'stránka',
    );
    return 'Načítám jména: $page z $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails =>
      'Scrapuji chybějící detaily reppacku...';

  @override
  String get thisMayTakeAWhile => 'Může to chvíli trvat.';

  @override
  String scrapingMissingRepackDetailsProgress(num current, num total) {
    String _temp0 = intl.Intl.pluralLogic(
      current,
      locale: localeName,
      other: 'rebalování',
      one: 'repack',
    );
    return 'Detaily seskupování: $current/$total chybí $_temp0';
  }

  @override
  String get repackLibrarySynchronized =>
      'Knihovna repozitáře synchronizována.';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'Synchronizace knihovny selhala: $errorMessage';
  }

  @override
  String get syncLibrary => 'Synchronizovat knihovnu';

  @override
  String get syncingLibrary => 'Synchronizace knihovny...';

  @override
  String get noRepacksFoundInTheLibrary =>
      'V knihovně nebyly nalezeny žádné repacky.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'Nebyly nalezeny žádné rebaly odpovídající $search.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'Okno je příliš úzké pro správné zobrazení předmětů.';

  @override
  String get pleaseResizeTheWindow => 'Změňte velikost okna.';

  @override
  String get repackUrlIsNotAvailable => 'URL repozitáře není k dispozici.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'Nelze spustit URL: $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return 'Nelze spustit: $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return 'Neplatný formát URL: $url';
  }

  @override
  String get rescrapeDetails => 'Detaily Rescrape';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return 'Podrobnosti o $title byly překrývány a aktualizovány.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'Nepodařilo se rescrape detaily: $errorMessage';
  }

  @override
  String get errorRescraping => 'Chyba při překrývání';

  @override
  String get openSourcePage => 'Otevřít zdrojovou stránku';

  @override
  String noPopularNewRepacksFound(Object type) {
    return 'Nebyly nalezeny žádné repakety $type.';
  }

  @override
  String get newest => 'nový';

  @override
  String get popular => 'populární';

  @override
  String get system => 'Systém';

  @override
  String get yellow => 'Žlutá';

  @override
  String get orange => 'Oranžová';

  @override
  String get red => 'Červená';

  @override
  String get magenta => 'Purpurová';

  @override
  String get purple => 'Fialová';

  @override
  String get blue => 'Modrá';

  @override
  String get teal => 'Modrozelený';

  @override
  String get green => 'Zelená';

  @override
  String get confirmForceRescrape => 'Potvrdit vynucené opakování';

  @override
  String
  get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'Tímto smažete VŠECHNY lokálně uložená data repack a znovu stáhnete vše ze zdroje. ';

  @override
  String
  get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'Tento proces může trvat velmi dlouho a spotřebovávat významná síťová data. Jste si jisti?';

  @override
  String get yesRescrapeAll => 'Ano, opakovat vše';

  @override
  String get startingFullDataRescrape => 'Spouštění úplné recrape...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'Všechna data byla násilně přepsána.';

  @override
  String errorMessage(Object error) {
    return 'Chyba: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'Nepodařilo se vynutit rescrape data: $errorMessage';
  }

  @override
  String get forceRescrapingData => 'Vynutit přepnutí dat';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'Stahování a instalace';

  @override
  String get defaultDownloadPath => 'Výchozí cesta ke stažení';

  @override
  String get maxConcurrentDownloads => 'Maximální počet souběžných stahování';

  @override
  String get automaticInstallation => 'Automatická instalace';

  @override
  String get enableAutoInstallAfterDownload =>
      'Povolit automatickou instalaci po stažení:';

  @override
  String get defaultInstallationPath => 'Výchozí cesta instalace';

  @override
  String
  get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      'Pokud je povoleno, dokončené republičky se pokusí nainstalovat na zadanou cestu.';

  @override
  String get appearance => 'Vzhled';

  @override
  String get themeMode => 'Režim motivu';

  @override
  String get navigationPaneDisplayMode => 'Režim zobrazení navigačního panelu';

  @override
  String get accentColor => 'Barva zvýraznění';

  @override
  String get windowTransparency => 'Průhlednost okna';

  @override
  String get local => 'Místní prostředí';

  @override
  String get applicationUpdates => 'Aktualizace aplikace';

  @override
  String get updateCheckFrequency => 'Frekvence kontroly aktualizací';

  @override
  String get currentAppVersion => 'Aktuální verze aplikace:';

  @override
  String get loading => 'Načítám...';

  @override
  String get latestAvailableVersion => 'Poslední dostupná verze:';

  @override
  String get youAreOnTheLatestVersion => 'Jste na nejnovější verzi';

  @override
  String get checking => 'Kontroluje...';

  @override
  String get notCheckedYet => ' Zatím nezaškrtnuto.';

  @override
  String get checkToSee => ' Zaškrtněte pro zobrazení.';

  @override
  String get youHaveIgnoredThisUpdate => 'Tuto aktualizaci jste ignorovali.';

  @override
  String get unignoreCheckAgain => 'Zrušit ignorování a znovu zkontrolovat';

  @override
  String get checkForUpdatesNow => 'Zkontrolovat aktualizace';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'Aktualizace na verzi $version je k dispozici';
  }

  @override
  String get downloadAndInstallUpdate => 'Stáhnout a nainstalovat aktualizaci';

  @override
  String get viewReleasePage => 'Zobrazit stránku vydání';

  @override
  String get dataManagement => 'Správa dat';

  @override
  String get forceRescrapeAllData => 'Vynutit Rescrape všechna data';

  @override
  String
  get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'Varování: Tento proces může trvat velmi dlouho a spotřebovávat významná síťová data. Používejte s opatrností.';

  @override
  String get rescrapingSeeDialog => 'Překódování... Viz dialog';

  @override
  String get forceRescrapeAllDataNow => 'Vynutit Rescrape všechna data nyní';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'Již běží další proces recrapingu.';

  @override
  String get clearingAllExistingData => 'Vymazání všech existujících dat...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'Vymazání všech názvů repack (Phase 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'stránky',
      one: 'stránka',
    );
    return 'Vykreslování všech jmen repack (Základ 1/4): Strana $page z $totalPages $_temp0';
  }

  @override
  String allRepackNamesScrapedPhase1(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'jména',
      one: 'jméno',
      zero: 'jména',
    );
    return 'Všechny názvy repack smazány. ($count $_temp0 (Dokončeno 1/4)';
  }

  @override
  String get scrapingDetailsForEveryRepackPhase2LongestPhase =>
      'Scraping detaily pro každý repack (fáze 2/4 - nejdelší fáze)...';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
    Object current,
    Object total,
  ) {
    return 'Detaily o každém repack (Phase 2/4): repozitář $current z $total';
  }

  @override
  String allRepackDetailsScrapedPhase2(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'rebalování',
      one: 'repack',
      zero: 'přebalte',
    );
    return 'Všechny detaily repack byly odstraněny. ($count $_temp0 zpracováno (třetí a čtvrtá fáze)';
  }

  @override
  String get rescrapingNewRepacksPhase3 =>
      'Rescraping new repacks (Phase 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'Překódování nových rebalíků (3. základna): Strana $current z $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'Nové rebalíky překrývají. (Dokončeno 3/4)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'Rescraping populární repacky (Phase 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'Překrývání populárních repacků (věc 4/4): položka $current z $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'Populární reklam překrývají. (Dokončeno 4/4)';

  @override
  String get finalizing => 'Dokončování...';

  @override
  String get fullRescrapeCompletedSuccessfully =>
      'Kompletní reskrapka byla úspěšně dokončena!';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'Chyba: $errorMessage. Proces byl zastaven.';
  }

  @override
  String get daily => 'Denní';

  @override
  String get weekly => 'Týdenní';

  @override
  String get manual => 'Ruční';

  @override
  String get onEveryStartup => 'Při každém spuštění';

  @override
  String get light => 'Světlý';

  @override
  String get dark => 'Tmavý';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'V konfiguraci zrcadla nebyly nalezeny žádné URL adresy.';

  @override
  String get failedToProcessUnknownPlugin =>
      'Nepodařilo se zpracovat (Neznámý plugin):';

  @override
  String get problemProcessingSomeLinks =>
      'Problém se zpracováním některých odkazů. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'Chyba při zpracování jednoho nebo více odkazů. ';

  @override
  String filesAddedToDownloadManager(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'soubory',
      one: 'soubor',
      zero: 'soubory',
    );
    return '$count $_temp0 přidán do správce stahování.';
  }

  @override
  String get downloadStarted => 'Stahování zahájeno';

  @override
  String get ok => 'OK';

  @override
  String get noFilesSelected => 'Nebyly vybrány žádné soubory';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'Vyberte prosím jeden nebo více souborů ze stromu ke stažení.';

  @override
  String get noFilesCouldBeRetrieved => 'Nelze načíst žádné soubory.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
    Object processingError,
  ) {
    return 'Upozornění: $processingError Některé soubory mohly narazit na problémy.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'Pro toto zrcadlo nebyly nalezeny žádné soubory ke stažení.';

  @override
  String downloadFilesGame(Object Game) {
    return 'Stáhnout soubory: $Game';
  }

  @override
  String get close => 'Zavřít';

  @override
  String get downloadSelected => 'Stáhnout vybrané';

  @override
  String get aboutGame => 'O hře';

  @override
  String get features => 'Vlastnosti';

  @override
  String get selectDownloadOptions => 'Vyberte možnosti stahování';

  @override
  String get downloadMethod => 'Metoda stahování:';

  @override
  String get selectMethod => 'Vyberte metodu';

  @override
  String get mirror => 'Zrcadlo:';

  @override
  String get selectMirror => 'Vybrat zrcadlo';

  @override
  String get downloadLocation => 'Umístění stahování:';

  @override
  String get enterDownloadLocationOrBrowse =>
      'Zadejte umístění ke stažení nebo procházejte';

  @override
  String get downloadLocationEmpty => 'Poloha stahování je prázdná';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'Vyberte prosím nebo zadejte umístění ke stažení.';

  @override
  String get selectionIncomplete => 'Výběr nedokončen';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'Vyberte prosím metodu stahování a zrcadlo.';

  @override
  String get next => 'Další';

  @override
  String get download => 'Stáhnout';

  @override
  String get downloadComplete => 'Stahování dokončeno!';

  @override
  String get downloadPending => 'Probíhá stahování...';

  @override
  String get genres => 'Genres';

  @override
  String get company => 'Článek 2';

  @override
  String get language => 'Jazyk';

  @override
  String get originalSize => 'Původní velikost';

  @override
  String get repackSize => 'Velikost repozitáře';

  @override
  String get repackInformation => 'Informace o repozitáři';

  @override
  String screenshotsTitle(Object count) {
    return 'Screenshots ($count)';
  }

  @override
  String get errorLoadingImage => 'Chyba při načítání obrázku';

  @override
  String get noScreenshotsAvailable =>
      'Žádné snímky obrazovky nejsou k dispozici.';

  @override
  String get noGenresAvailable => 'Žádné žánry nejsou k dispozici';

  @override
  String get clear => 'Vyčistit';

  @override
  String get filterByGenre => 'Filtrovat podle žánru';

  @override
  String get filter => 'Filtr';

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
}
