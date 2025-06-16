// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get success => 'Sukces';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'Nowe i Popularne paczki zostały pozyskane.';

  @override
  String get error => 'Błąd';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'Nie udało się pozyskać danych: $errorMessage';
  }

  @override
  String get home => 'Strona główna';

  @override
  String get rescrapeNewPopular => 'Pozyskaj nowe i popularne';

  @override
  String get newRepacks => 'Nowe Repacki';

  @override
  String get popularRepacks => 'Popularne Repacki';

  @override
  String get noCompletedGroupsToClear =>
      'Brak pobranych w pełni repacków do wyczyszczenia.';

  @override
  String get queued => 'W kolejce';

  @override
  String get downloading => 'Pobieranie:';

  @override
  String get completed => 'Zakończone';

  @override
  String get failed => 'Niepowodzenie';

  @override
  String get paused => 'Zatrzymano';

  @override
  String get canceled => 'Anulowane';

  @override
  String get dismiss => 'Odrzuć';

  @override
  String get confirmClear => 'Potwierdź Wyczyszczenie';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'pobranych repacków',
      few: 'pobrane repacki',
      one: 'pobranego repacka',
    );
    return 'Czy na pewno chcesz usunąć $count $_temp0?';
  }

  @override
  String get clearCompleted => 'Wyczyść ukończone';

  @override
  String get cancel => 'Anuluj';

  @override
  String completedGroupsCleared(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'pobranych repacków',
      few: 'pobrane repacki',
      one: 'pobranego repacka',
    );
    return 'Usunięto $count $_temp0.';
  }

  @override
  String get downloadManager => 'Menedżer Pobierania';

  @override
  String get maxConcurrent => 'Limit Jednoczesnych Pobrań';

  @override
  String get noActiveDownloads => 'Brak aktywnych pobrań.';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'Pobrania pojawią się tutaj po dodaniu.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'Anuluj wszystkie pobrania w tej grupie';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'Czy na pewno chcesz anulować wszystkie pobrania w tej grupie i je usunąć?';

  @override
  String completedNumberFiles(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'plików',
      one: 'plik',
      few: 'pliki',
    );
    return 'Ukończono $count $_temp0';
  }

  @override
  String overallProgressFilesPercent(num count, Object percent) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'plików',
      one: 'plik',
      few: 'pliki',
    );
    return 'Ogólnie: $percent% ($count $_temp0)';
  }

  @override
  String noActiveTasks(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'plików',
      one: 'plik',
      few: 'pliki',
    );
    return 'Brak aktywnych zadań ($count $_temp0)';
  }

  @override
  String cancelGroupName(Object groupName) {
    return 'Anuluj grupę: $groupName';
  }

  @override
  String get removeFromList => 'Usuń z kolejki';

  @override
  String get resume => 'Wznów';

  @override
  String get pause => 'Wstrzymaj';

  @override
  String get errorTaskDataUnavailable => 'Błąd: Dane zadania niedostępne';

  @override
  String get unknownFile => 'Nieznany plik';

  @override
  String get yesCancelGroup => 'Tak, Anuluj grupę';

  @override
  String get no => 'Nie';

  @override
  String get repackLibrary => 'Biblioteka Repacków';

  @override
  String get settings => 'Ustawienia';

  @override
  String get unknown => 'Nieznane';

  @override
  String get noReleaseNotesAvailable => 'Brak dostępnych informacji o wydaniu.';

  @override
  String get search => 'Szukaj';

  @override
  String updateAvailable(Object version) {
    return 'Dostępna aktualizacja: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'Dostępna jest nowa wersja FitFlutter.';

  @override
  String get viewReleaseNotes => 'Zobacz informacje o wydaniu';

  @override
  String get releasePage => 'Strona wydania';

  @override
  String get later => 'Później';

  @override
  String get upgrade => 'Aktualizuj';

  @override
  String get downloadsInProgress => 'Pobieranie w toku';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'Zamknięcie aplikacji spowoduje anulowanie wszystkich aktywnych pobierań.';

  @override
  String get areYouSureYouWantToClose => 'Czy na pewno chcesz zamknąć?';

  @override
  String get yesCloseCancel => 'Tak, Zamknij i Anuluj';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'Użytkownik zdecydował się zamknąć; anulowanie pobierania.';

  @override
  String get keepDownloading => 'Kontynuuj pobieranie';

  @override
  String get startingLibrarySync => 'Uruchamianie synchronizacji biblioteki...';

  @override
  String get fetchingAllRepackNames => 'Pobieranie wszystkich nazw repacków...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      totalPages,
      locale: localeName,
      other: 'stron',
      few: 'stron',
      one: 'strony',
    );
    return 'Pobieranie nazw: Strona $page z $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails =>
      'Pozyskiwanie brakujących szczegółów repacków...';

  @override
  String get thisMayTakeAWhile => 'To może chwilę potrwać.';

  @override
  String scrapingMissingRepackDetailsProgress(num current, num total) {
    String _temp0 = intl.Intl.pluralLogic(
      total,
      locale: localeName,
      other: 'repacków',
      few: 'repacki',
      one: 'repack',
    );
    return 'Pozyskiwanie szczegółów: $current/$total $_temp0';
  }

  @override
  String get repackLibrarySynchronized =>
      'Biblioteka repacków zsynchronizowana.';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'Synchronizacja biblioteki nie powiodła się: $errorMessage';
  }

  @override
  String get syncLibrary => 'Synchronizuj bibliotekę';

  @override
  String get syncingLibrary => 'Synchronizuję bibliotekę...';

  @override
  String get noRepacksFoundInTheLibrary =>
      'Nie znaleziono repacków w bibliotece.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'Nie znaleziono repacków pasujących do $search.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'Okno jest zbyt wąskie, aby wyświetlić poprawnie elementy.';

  @override
  String get pleaseResizeTheWindow => 'Proszę zmienić rozmiar okna.';

  @override
  String get repackUrlIsNotAvailable => 'URL repacka nie jest dostępny.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'Nie można uruchomić URL: $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return 'Nie można uruchomić: $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return 'Nieprawidłowy format URL: $url';
  }

  @override
  String get rescrapeDetails => 'Szczegóły odkrycia';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return 'Szczegóły dla $title zostały pozyskane i zaktualizowane.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'Nie udało się pozyskać szczegółów: $errorMessage';
  }

  @override
  String get errorRescraping => 'Błąd Pozyskiwania';

  @override
  String get openSourcePage => 'Otwórz stronę źródłową';

  @override
  String noPopularNewRepacksFound(Object type) {
    return 'Nie znaleziono przepakowań $type.';
  }

  @override
  String get newest => 'nowy';

  @override
  String get popular => 'popularne';

  @override
  String get system => 'System';

  @override
  String get yellow => 'Żółty';

  @override
  String get orange => 'Pomarańczowy';

  @override
  String get red => 'Czerwony';

  @override
  String get magenta => 'Karmazynowy';

  @override
  String get purple => 'Fioletowy';

  @override
  String get blue => 'Niebieski';

  @override
  String get teal => 'Turkusowy';

  @override
  String get green => 'Zielony';

  @override
  String get confirmForceRescrape => 'Potwierdź Wymuszenie Aktualizacji';

  @override
  String get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'Spowoduje to usunięcie WSZYSTKICH lokalnie przechowywanych danych repacków i ponowne pobranie wszystkiego ze źródła.';

  @override
  String get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'Ten proces może zająć bardzo dużo czasu i zużyć znaczącą ilość transferu. Czy jesteś pewien?';

  @override
  String get yesRescrapeAll => 'Tak, Aktualizuj Wszystko';

  @override
  String get startingFullDataRescrape =>
      'Rozpoczęcie aktualizacji wszystkich danych...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'Wszystkie dane zostały zaktualizowane.';

  @override
  String errorMessage(Object error) {
    return 'Błąd: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'Nie udało się wymusić aktualizacji danych: $errorMessage';
  }

  @override
  String get forceRescrapingData => 'Wymuś Aktualizację Danych';

  @override
  String percentComplete(Object percentComplete) {
    return 'Ukończono $percentComplete%';
  }

  @override
  String get downloadsInstallation => 'Pobieranie i Instalowanie';

  @override
  String get defaultDownloadPath => 'Domyślna Ścieżka Pobierania';

  @override
  String get maxConcurrentDownloads => 'Limit Równoczesnych Pobrań';

  @override
  String get automaticInstallation => 'Automatyczna Instalacja';

  @override
  String get enableAutoInstallAfterDownload =>
      'Włącz automatyczną instalację po pobraniu:';

  @override
  String get defaultInstallationPath => 'Domyślna Ścieżka Instalacji';

  @override
  String get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      'Jeśli opcja jest włączona, repack po ukończeniu zainstaluje się do określonej ścieżki.';

  @override
  String get appearance => 'Wygląd';

  @override
  String get themeMode => 'Tryb motywu';

  @override
  String get navigationPaneDisplayMode => 'Tryb Wyświetlania Panelu Nawigacji';

  @override
  String get accentColor => 'Kolor Akcentu';

  @override
  String get windowTransparency => 'Przezroczystość Okna';

  @override
  String get local => 'Język';

  @override
  String get applicationUpdates => 'Aktualizacje Aplikacji';

  @override
  String get updateCheckFrequency => 'Częstotliwość Sprawdzania Aktualizacji';

  @override
  String get currentAppVersion => 'Aktualna Wersja Aplikacji:';

  @override
  String get loading => 'Ładowanie...';

  @override
  String get latestAvailableVersion => 'Najnowsza Dostępna Wersja:';

  @override
  String get youAreOnTheLatestVersion => 'Jesteś w najnowszej wersji';

  @override
  String get checking => 'Sprawdzanie...';

  @override
  String get notCheckedYet => ' Jeszcze nie sprawdzono.';

  @override
  String get checkToSee => ' Sprawdź.';

  @override
  String get youHaveIgnoredThisUpdate => 'Zignorowałeś tę aktualizację.';

  @override
  String get unignoreCheckAgain => 'Odignoruj i sprawdź ponownie';

  @override
  String get checkForUpdatesNow => 'Sprawdź aktualizacje teraz';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'Aktualizacja do wersji $version jest dostępna';
  }

  @override
  String get downloadAndInstallUpdate => 'Pobierz i Zainstaluj Aktualizację';

  @override
  String get viewReleasePage => 'Zobacz Stronę Wydania';

  @override
  String get dataManagement => 'Zarządzanie Danymi';

  @override
  String get forceRescrapeAllData => 'Wymuś Aktualizację Wszystkich Danych';

  @override
  String get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'Ten proces może zająć bardzo dużo czasu i zużyć znaczącą ilość transferu. Używaj z ostrożnością.';

  @override
  String get rescrapingSeeDialog => 'Aktualizowanie... Zobacz okno dialogowe';

  @override
  String get forceRescrapeAllDataNow => 'Wymuś Aktualizację Wszystkich Danych';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'Inny proces aktualizacji jest już uruchomiony.';

  @override
  String get clearingAllExistingData =>
      'Czyszczenie wszystkich istniejących danych...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'Pozyskiwanie wszystkich tytułów repacków (Etap 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      totalPages,
      locale: localeName,
      other: 'stron',
      few: 'stron',
      one: 'strony',
    );
    return 'Pozyskiwanie wszystkich nazw repacków (Etap 1/4): Strona $page z $totalPages $_temp0';
  }

  @override
  String allRepackNamesScrapedPhase1(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'tytułów',
      few: 'tytuły',
      one: 'tytuł',
    );
    return 'Pozyskano wszystkie tytuły repacków. ($count $_temp0 (Etap 1/4 Ukończony)';
  }

  @override
  String get scrapingDetailsForEveryRepackPhase2LongestPhase =>
      'Pozyskiwanie szczegółów dla każdego repacka (Etap 2/4 - Najdłuższy Etap)...';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
      Object current, Object total) {
    return 'Pozyskiwanie szczegółów dla każdego repacka (Etap 2/4): Repack $current z $total';
  }

  @override
  String allRepackDetailsScrapedPhase2(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'repacków',
      many: 'repacków',
      few: 'repacki',
      one: 'repack',
    );
    return 'Detale wszystkich repacków zostały pozyskane. (Przetworzono $count $_temp0) (Etap 2/4 Ukończony)';
  }

  @override
  String get rescrapingNewRepacksPhase3 =>
      'Pozyskiwanie nowych repacków (Etap 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'Pozyskiwanie nowych repacków (Etap 3/4): Strona $current of $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'Nowe repacki zostały pozyskane. (Etap 3/4 Ukończony)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'Reskrapiwanie popularnych przepakowań (zmiana 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'Pozyskiwanie Popularnych repacków (Etap 4/4): Repack $current z $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'Pozyskiwanie Popularnych repacków (Etap 4/4 Ukończony)';

  @override
  String get finalizing => 'Kończenie...';

  @override
  String get fullRescrapeCompletedSuccessfully =>
      'Pełna aktualizacja danych zakończona pomyślnie!';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'Błąd: $errorMessage. Proces zatrzymany.';
  }

  @override
  String get daily => 'Codziennie';

  @override
  String get weekly => 'Tygodniowo';

  @override
  String get manual => 'Ręcznie';

  @override
  String get onEveryStartup => 'Przy każdym uruchomieniu';

  @override
  String get light => 'Jasny';

  @override
  String get dark => 'Ciemny';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'Nie znaleziono adresów URL.';

  @override
  String get failedToProcessUnknownPlugin =>
      'Nie udało się przetworzyć (wtyczka nieznana):';

  @override
  String get problemProcessingSomeLinks =>
      'Problem z przetwarzaniem niektórych linków. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'Błąd podczas przetwarzania jednego lub więcej linków. ';

  @override
  String filesAddedToDownloadManager(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'plików',
      few: 'pliki',
      one: 'plik',
    );
    return '$count $_temp0 zostały dodane do menedżera pobierania.';
  }

  @override
  String get downloadStarted => 'Rozpoczęto pobieranie';

  @override
  String get ok => 'OK';

  @override
  String get noFilesSelected => 'Nie wybrano plików';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'Wybierz jeden lub więcej plików z drzewa do pobrania.';

  @override
  String get noFilesCouldBeRetrieved => 'Nie można pobrać żadnych plików.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
      Object processingError) {
    return 'Uwaga: $processingError Niektóre pliki mogły napotkać problemy.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'Nie znaleziono plików do pobrania dla tego hosta.';

  @override
  String downloadFilesGame(Object Game) {
    return 'Pobierz pliki: $Game';
  }

  @override
  String get close => 'Zamknij';

  @override
  String get downloadSelected => 'Pobierz wybrane';

  @override
  String get aboutGame => 'O grze';

  @override
  String get features => 'Cechy';

  @override
  String get selectDownloadOptions => 'Wybierz opcje pobierania';

  @override
  String get downloadMethod => 'Metoda pobierania:';

  @override
  String get selectMethod => 'Wybierz metodę';

  @override
  String get mirror => 'Lustra:';

  @override
  String get selectMirror => 'Wybierz lustro';

  @override
  String get downloadLocation => 'Ścieżka pobierania:';

  @override
  String get enterDownloadLocationOrBrowse =>
      'Wprowadź ścieżkę pobierania lub przeglądaj';

  @override
  String get downloadLocationEmpty => 'Pusta ścieżka pobierania';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'Wybierz lub wprowadź ścieżkę pobierania.';

  @override
  String get selectionIncomplete => 'Wybór niekompletny';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'Wybierz metodę pobierania i kopię lustrzaną.';

  @override
  String get next => 'Następny';

  @override
  String get download => 'Pobierz';

  @override
  String get downloadComplete => 'Pobieranie zakończone!';

  @override
  String get downloadPending => 'Pobieranie w toku...';

  @override
  String get genres => 'Gatunki';

  @override
  String get company => 'Producent';

  @override
  String get language => 'Język';

  @override
  String get originalSize => 'Oryginalny rozmiar';

  @override
  String get repackSize => 'Rozmiar Repacka';

  @override
  String get repackInformation => 'Informacje o Repacku';

  @override
  String screenshotsTitle(Object count) {
    return 'Zrzuty ekranu ($count)';
  }

  @override
  String get errorLoadingImage => 'Błąd ładowania obrazu';

  @override
  String get noScreenshotsAvailable => 'Brak dostępnych zrzutów ekranu.';

  @override
  String get noGenresAvailable => 'Brak dostępnych gatunków';

  @override
  String get clear => 'Wyczyść';

  @override
  String get filterByGenre => 'Filtruj według gatunku';

  @override
  String get filter => 'Filtruj';
}
