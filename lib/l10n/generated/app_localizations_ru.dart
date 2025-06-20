// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get success => 'Успешно';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'Популярные и новые репакеты были восстановлены.';

  @override
  String get error => 'Ошибка';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'Не удалось восстановить данные: $errorMessage';
  }

  @override
  String get home => 'Домашний';

  @override
  String get rescrapeNewPopular => 'Популярные и новые';

  @override
  String get newRepacks => 'Новые наборы';

  @override
  String get popularRepacks => 'Популярные наборы';

  @override
  String get noCompletedGroupsToClear => 'Нет завершенных групп для очистки.';

  @override
  String get queued => 'В очереди';

  @override
  String get downloading => 'Загрузка:';

  @override
  String get completed => 'Выполнено';

  @override
  String get failed => 'Неудачный';

  @override
  String get paused => 'Пауза';

  @override
  String get canceled => 'Отменено';

  @override
  String get dismiss => 'Отклонить';

  @override
  String get confirmClear => 'Подтвердить очистку';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'группы',
      one: 'Группа',
      zero: 'группы',
    );
    return 'Вы уверены, что хотите удалить $count завершила загрузку $_temp0? Это также удалит файлы с диска, если они находятся в подпапках, управляемых приложением.';
  }

  @override
  String get clearCompleted => 'Очистить завершенные';

  @override
  String get cancel => 'Отмена';

  @override
  String completedGroupsCleared(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'группы',
      one: 'группа',
      zero: 'группы',
    );
    return '$count завершил $_temp0 очищены.';
  }

  @override
  String get downloadManager => 'Менеджер закачек';

  @override
  String get maxConcurrent => 'Макс. одновременно';

  @override
  String get noActiveDownloads => 'Нет активных загрузок.';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'Загрузки появятся здесь после добавления.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'Отменить все загрузки в этой группе';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'Вы уверены, что хотите отменить все загрузки в этой группе и удалить их?';

  @override
  String completedNumberFiles(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '',
      one: 'файл',
      zero: '',
    );
    return 'Файлы $count $_temp0';
  }

  @override
  String overallProgressFilesPercent(num count, Object percent) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'файлов',
      one: 'файл',
    );
    return 'В общей сложности: $percent% ($count $_temp0)';
  }

  @override
  String noActiveTasks(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'файлов',
      one: 'файл',
    );
    return 'Нет активных задач или прогресса недоступных ($count $_temp0)';
  }

  @override
  String cancelGroupName(Object groupName) {
    return 'Отменить группу: $groupName';
  }

  @override
  String get removeFromList => 'Удалить из списка';

  @override
  String get resume => 'Возобновить';

  @override
  String get pause => 'Пауза';

  @override
  String get errorTaskDataUnavailable => 'Ошибка: Данные задачи недоступны';

  @override
  String get unknownFile => 'Неизвестный файл';

  @override
  String get yesCancelGroup => 'Да, отменить группу';

  @override
  String get no => 'Нет';

  @override
  String get repackLibrary => 'Перезабрать библиотеку';

  @override
  String get settings => 'Настройки';

  @override
  String get unknown => 'Неизвестен';

  @override
  String get noReleaseNotesAvailable => 'Заметки о выпуске отсутствуют.';

  @override
  String get search => 'Искать';

  @override
  String updateAvailable(Object version) {
    return 'Доступно обновлений: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'Доступна новая версия FitFlutter.';

  @override
  String get viewReleaseNotes => 'Просмотреть примечания к выпуску';

  @override
  String get releasePage => 'Страница релиза';

  @override
  String get later => 'Позже';

  @override
  String get upgrade => 'Улучшить';

  @override
  String get downloadsInProgress => 'Идёт загрузка';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'Закрытие приложения отменит все активные загрузки. ';

  @override
  String get areYouSureYouWantToClose => 'Вы уверены, что хотите закрыть?';

  @override
  String get yesCloseCancel => 'Да, закрыть и отменить';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'Пользователь выбрал закрытие; отмена загрузки.';

  @override
  String get keepDownloading => 'Продолжить загрузку';

  @override
  String get startingLibrarySync => 'Запуск синхронизации библиотеки...';

  @override
  String get fetchingAllRepackNames => 'Получение всех имен обновлений...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'страницы',
      one: 'страница',
    );
    return 'Получение названий: $page из $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails =>
      'Скрипция недостающих реквизитов пакета...';

  @override
  String get thisMayTakeAWhile => 'Это может занять некоторое время.';

  @override
  String scrapingMissingRepackDetailsProgress(num current, num total) {
    String _temp0 = intl.Intl.pluralLogic(
      current,
      locale: localeName,
      other: 'Репаки',
      one: 'Распакуйте',
    );
    return 'Скрапывание деталей: $current/$total отсутствует $_temp0';
  }

  @override
  String get repackLibrarySynchronized =>
      'Обновление библиотеки синхронизировано.';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'Не удалось синхронизировать библиотеку: $errorMessage';
  }

  @override
  String get syncLibrary => 'Синхронизировать библиотеку';

  @override
  String get syncingLibrary => 'Синхронизация библиотеки...';

  @override
  String get noRepacksFoundInTheLibrary =>
      'В библиотеке не найдено ни одного пакета.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'Соответствующие $search наборы не найдены.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'Окно слишком узкое для правильного отображения элементов.';

  @override
  String get pleaseResizeTheWindow => 'Пожалуйста, измените размер окна.';

  @override
  String get repackUrlIsNotAvailable => 'URL обновления недоступен.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'Не удалось запустить URL: $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return 'Не удалось запустить: $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return 'Недопустимый формат URL: $url';
  }

  @override
  String get rescrapeDetails => 'Повторная выборка';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return 'Подробности для $title были восстановлены и обновлены.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'Не удалось восстановить подробности: $errorMessage';
  }

  @override
  String get errorRescraping => 'Ошибка при повторной сдаче';

  @override
  String get openSourcePage => 'Открыть исходную страницу';

  @override
  String noPopularNewRepacksFound(Object type) {
    return 'Не найдено ни одного набора $type.';
  }

  @override
  String get newest => 'новый';

  @override
  String get popular => 'популярный';

  @override
  String get system => 'Система';

  @override
  String get yellow => 'Жёлтый';

  @override
  String get orange => 'Оранжевый';

  @override
  String get red => 'Красный';

  @override
  String get magenta => 'Пурпурный';

  @override
  String get purple => 'Фиолетовый';

  @override
  String get blue => 'Синий';

  @override
  String get teal => 'Бирюзовый';

  @override
  String get green => 'Зелёный';

  @override
  String get confirmForceRescrape => 'Подтвердить сброс силы';

  @override
  String
  get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'Это удалит все локально сохраненные данные и перезагрузит всё из исходного кода. ';

  @override
  String
  get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'Этот процесс может занять очень много времени и потратить значительные сетевые данные. Вы уверены?';

  @override
  String get yesRescrapeAll => 'Да, восстановить все';

  @override
  String get startingFullDataRescrape => 'Запуск полных данных повторно...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'Все данные были подвергнуты принудительному повторному обнаружению.';

  @override
  String errorMessage(Object error) {
    return 'Ошибка: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'Не удалось принудительно восстановить данные: $errorMessage';
  }

  @override
  String get forceRescrapingData => 'Принудительное восстановление данных';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'Загрузки и установка';

  @override
  String get defaultDownloadPath => 'Путь загрузки по умолчанию';

  @override
  String get maxConcurrentDownloads => 'Макс. одновременных загрузок';

  @override
  String get automaticInstallation => 'Автоматическая установка';

  @override
  String get enableAutoInstallAfterDownload =>
      'Включить автоустановку после загрузки:';

  @override
  String get defaultInstallationPath => 'Путь установки по умолчанию';

  @override
  String
  get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      'Если включено, завершенные пакеты будут пытаться установить на указанный путь.';

  @override
  String get appearance => 'Внешний вид';

  @override
  String get themeMode => 'Режим темы';

  @override
  String get navigationPaneDisplayMode => 'Режим отображения панели навигации';

  @override
  String get accentColor => 'Цвет акцента';

  @override
  String get windowTransparency => 'Прозрачность окна';

  @override
  String get local => 'Язык';

  @override
  String get applicationUpdates => 'Обновления приложения';

  @override
  String get updateCheckFrequency => 'Частота проверки обновлений';

  @override
  String get currentAppVersion => 'Текущая версия приложения:';

  @override
  String get loading => 'Загрузка...';

  @override
  String get latestAvailableVersion => 'Последняя доступная версия:';

  @override
  String get youAreOnTheLatestVersion => 'Вы используете последнюю версию';

  @override
  String get checking => 'Проверка...';

  @override
  String get notCheckedYet => ' Пока не проверено.';

  @override
  String get checkToSee => ' Отметьте, чтобы увидеть.';

  @override
  String get youHaveIgnoredThisUpdate => 'Вы проигнорировали это обновление.';

  @override
  String get unignoreCheckAgain => 'Отменить игнорирование и проверить снова';

  @override
  String get checkForUpdatesNow => 'Проверить обновления';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'Доступно обновление до версии $version';
  }

  @override
  String get downloadAndInstallUpdate => 'Скачать и установить обновление';

  @override
  String get viewReleasePage => 'Просмотр страницы релиза';

  @override
  String get dataManagement => 'Управление данными';

  @override
  String get forceRescrapeAllData => 'Принудительно восстановить все данные';

  @override
  String
  get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'Предупреждение: Этот процесс может занять очень много времени и потреблять значительные сетевые данные. Используйте с осторожностью.';

  @override
  String get rescrapingSeeDialog => 'Повтор... Посмотреть диалог';

  @override
  String get forceRescrapeAllDataNow => 'Принудительно восстановить все данные';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'Другой процесс восстановления уже запущен.';

  @override
  String get clearingAllExistingData => 'Очистить все существующие данные...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'Scraping все имена repack (Фаза 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'страницы',
      one: 'страница',
    );
    return 'Скрипт всех имен repack (Фаза 1/4): Страница $page из $totalPages $_temp0';
  }

  @override
  String allRepackNamesScrapedPhase1(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'имена',
      one: 'имя',
      zero: 'имена',
    );
    return 'Все имена разбиты. ($count $_temp0 (Фаза 1/4 завершена)';
  }

  @override
  String get scrapingDetailsForEveryRepackPhase2LongestPhase =>
      'Scraping details for every repack (Фаза 2/4 - Длинная Фаза)...';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
    Object current,
    Object total,
  ) {
    return 'Скрапывание деталей для каждого repack (Фаза 2/4): Repack $current из $total';
  }

  @override
  String allRepackDetailsScrapedPhase2(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'reacks',
      one: 'repack',
      zero: 'перепаковки',
    );
    return 'Все реквизиты перепака сломаны. ($count $_temp0 обработано (этап 2/4 завершен)';
  }

  @override
  String get rescrapingNewRepacksPhase3 =>
      'Восстановление новых репакетов (Фаза 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'Восстановление новых reacks (Фаза 3/4): Страница $current из $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'Новые повторные наборы. (Фаза 3/4 завершена)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'Восстановление популярных репозиториев (Фаза 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'Популярные reacks (Фаза 4/4): Предмет $current от $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'Популярные репакеты восстановлены. (Фаза 4/4)';

  @override
  String get finalizing => 'Завершение...';

  @override
  String get fullRescrapeCompletedSuccessfully =>
      'Полная повторная кража успешно завершена!';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'Ошибка: $errorMessage. Процесс остановлен.';
  }

  @override
  String get daily => 'Ежедневно';

  @override
  String get weekly => 'Еженедельно';

  @override
  String get manual => 'Ручной';

  @override
  String get onEveryStartup => 'При каждом запуске';

  @override
  String get light => 'Светлая';

  @override
  String get dark => 'Тёмная';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'URL-адреса в конфигурации зеркала не найдены.';

  @override
  String get failedToProcessUnknownPlugin =>
      'Не удалось обработать (Неизвестный плагин):';

  @override
  String get problemProcessingSomeLinks =>
      'Проблема с обработкой некоторых ссылок. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'Ошибка при обработке одной или нескольких ссылок. ';

  @override
  String filesAddedToDownloadManager(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'файлы',
      one: 'файл',
      zero: 'файлы',
    );
    return '$count $_temp0 добавлены в менеджер загрузок.';
  }

  @override
  String get downloadStarted => 'Загрузка начата';

  @override
  String get ok => 'ОК';

  @override
  String get noFilesSelected => 'Файлы не выбраны';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'Пожалуйста, выберите один или несколько файлов из дерева для загрузки.';

  @override
  String get noFilesCouldBeRetrieved => 'Файлы не могут быть получены.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
    Object processingError,
  ) {
    return 'Notice: $processingError Some files may have encountered issues.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'Для этого зеркала не найдено загружаемых файлов.';

  @override
  String downloadFilesGame(Object Game) {
    return 'Скачать файлы: $Game';
  }

  @override
  String get close => 'Закрыть';

  @override
  String get downloadSelected => 'Загрузить выбранные';

  @override
  String get aboutGame => 'О игре';

  @override
  String get features => 'Возможности';

  @override
  String get selectDownloadOptions => 'Выберите параметры загрузки';

  @override
  String get downloadMethod => 'Метод загрузки:';

  @override
  String get selectMethod => 'Выберите метод';

  @override
  String get mirror => 'Зеркал:';

  @override
  String get selectMirror => 'Выбрать зеркало';

  @override
  String get downloadLocation => 'Место загрузки:';

  @override
  String get enterDownloadLocationOrBrowse =>
      'Введите местоположение загрузки или просмотр';

  @override
  String get downloadLocationEmpty => 'Местоположение загрузки не указано';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'Пожалуйста, выберите или введите место загрузки.';

  @override
  String get selectionIncomplete => 'Выделение незавершено';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'Пожалуйста, выберите метод загрузки и зеркало.';

  @override
  String get next => 'Следующий';

  @override
  String get download => 'Скачать';

  @override
  String get downloadComplete => 'Загрузка завершена!';

  @override
  String get downloadPending => 'Идёт загрузка...';

  @override
  String get genres => 'Genres';

  @override
  String get company => 'Компания';

  @override
  String get language => 'Язык';

  @override
  String get originalSize => 'Исходный размер';

  @override
  String get repackSize => 'Размер обновления';

  @override
  String get repackInformation => 'Перезабрать информацию';

  @override
  String screenshotsTitle(Object count) {
    return 'Screenshots ($count)';
  }

  @override
  String get errorLoadingImage => 'Ошибка загрузки изображения';

  @override
  String get noScreenshotsAvailable => 'Скриншоты недоступны.';

  @override
  String get noGenresAvailable => 'Нет доступных жанров';

  @override
  String get clear => 'Очистить';

  @override
  String get filterByGenre => 'Фильтр по жанру';

  @override
  String get filter => 'Фильтр';

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
