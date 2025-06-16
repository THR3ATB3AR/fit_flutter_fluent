// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get success => 'Успіх';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'Нові і популярні реконструкції були перетворені.';

  @override
  String get error => 'Помилка';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'Failed to rescrape data: $errorMessage';
  }

  @override
  String get home => 'Домашній екран';

  @override
  String get rescrapeNewPopular => 'Пересканувати новий & популярний';

  @override
  String get newRepacks => 'Нові записи репозиторіїв';

  @override
  String get popularRepacks => 'Популярні поклади';

  @override
  String get noCompletedGroupsToClear => 'Немає завершених груп.';

  @override
  String get queued => 'Поставлено в чергу';

  @override
  String get downloading => 'Завантаження:';

  @override
  String get completed => 'Завершені';

  @override
  String get failed => 'Не вдалося';

  @override
  String get paused => 'Призупинено';

  @override
  String get canceled => 'Скасовано';

  @override
  String get dismiss => 'Відхилити';

  @override
  String get confirmClear => 'Підтвердити очищення';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'групи',
      one: 'група',
      zero: 'Групи',
    );
    return 'Ви впевнені, що хочете видалити завершене завантаження $count $_temp0? Це також видалить файли з диску, якщо вони у виділених підтеках, що керуються додатком.';
  }

  @override
  String get clearCompleted => 'Очистити завершені';

  @override
  String get cancel => 'Скасувати';

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
  String get downloadManager => 'Менеджер завантажень';

  @override
  String get maxConcurrent => 'Максимальна кількість одночасних';

  @override
  String get noActiveDownloads => 'Немає активних завантажень.';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'Завантаження з\'являтимуться тут після додавання.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'Скасувати всі завантаження в цій групі';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'Ви дійсно бажаєте скасувати всі завантаження у цій групі та видалити їх?';

  @override
  String completedNumberFiles(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'файли',
      one: 'файл',
      zero: 'файли',
    );
    return 'Завершено $count $_temp0';
  }

  @override
  String overallProgressFilesPercent(num count, Object percent) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'файли',
      one: 'файл',
    );
    return 'Загалом: $percent% ($count $_temp0)';
  }

  @override
  String noActiveTasks(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'файли',
      one: 'файл',
    );
    return 'Немає активних завдань або прогрес недоступний ($count $_temp0)';
  }

  @override
  String cancelGroupName(Object groupName) {
    return 'Cancel Group: $groupName';
  }

  @override
  String get removeFromList => 'Вилучити зі списку';

  @override
  String get resume => 'Поновити';

  @override
  String get pause => 'Пауза';

  @override
  String get errorTaskDataUnavailable => 'Помилка: Дані задачі недоступні';

  @override
  String get unknownFile => 'Невідомий файл';

  @override
  String get yesCancelGroup => 'Так, скасувати групу';

  @override
  String get no => 'Ні';

  @override
  String get repackLibrary => 'Перепакувати бібліотеку';

  @override
  String get settings => 'Налаштування';

  @override
  String get unknown => 'Не вказано';

  @override
  String get noReleaseNotesAvailable => 'Немає доступних нотаток до випуску.';

  @override
  String get search => 'Пошук';

  @override
  String updateAvailable(Object version) {
    return 'Оновлення доступне: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'Доступна нова версія FitFluttert.';

  @override
  String get viewReleaseNotes => 'Переглянути примітки до випуску';

  @override
  String get releasePage => 'Сторінка випуску';

  @override
  String get later => 'Пізніше';

  @override
  String get upgrade => 'Апґрейд';

  @override
  String get downloadsInProgress => 'Триває завантаження';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'Закриття програми скасує всі активні завантаження. ';

  @override
  String get areYouSureYouWantToClose => 'Ви впевнені, що хочете закрити?';

  @override
  String get yesCloseCancel => 'Так, Закрити та скасувати';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'Користувач закривається; скасування завантажень.';

  @override
  String get keepDownloading => 'Продовжити завантаження';

  @override
  String get startingLibrarySync => 'Запуск синхронізації бібліотеки...';

  @override
  String get fetchingAllRepackNames => 'Отримання всіх імен ремонту...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'Сторінки',
      one: 'сторінка',
    );
    return 'Завантажується імена: $page of $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails =>
      'Шкрябання відсутнє подробиці ремонту...';

  @override
  String get thisMayTakeAWhile => 'Це може зайняти деякий час.';

  @override
  String scrapingMissingRepackDetailsProgress(num current, num total) {
    String _temp0 = intl.Intl.pluralLogic(
      current,
      locale: localeName,
      other: 'repacks',
      one: 'Відтворює',
    );
    return 'Деталі складання: $current/$total пропущено $_temp0';
  }

  @override
  String get repackLibrarySynchronized =>
      'Перепакування бібліотеки синхронізовано.';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'Не вдалося синхронізувати бібліотеку: $errorMessage';
  }

  @override
  String get syncLibrary => 'Синхронізувати Бібліотеку';

  @override
  String get syncingLibrary => 'Синхронізація бібліотеки...';

  @override
  String get noRepacksFoundInTheLibrary => 'У бібліотеці не знайдено оновлень.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'Пакетів не знайдено відповідного $search.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'Вікно занадто вузьке для коректного відображення елементів.';

  @override
  String get pleaseResizeTheWindow => 'Будь ласка, змініть розмір вікна.';

  @override
  String get repackUrlIsNotAvailable => 'Repack URL недоступний.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'Не вдалося запустити URL: $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return 'Не вдалося запустити: $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return 'Невірний формат адреси: $url';
  }

  @override
  String get rescrapeDetails => 'Докладно про Rescrape';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return 'Деталі для $title були переоброблені та оновлені.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'Не вдалося переслати подробиці $errorMessage';
  }

  @override
  String get errorRescraping => 'Помилка при перевстановленні';

  @override
  String get openSourcePage => 'Open Source сторінка';

  @override
  String noPopularNewRepacksFound(Object type) {
    return 'Оновлень $type не знайдено.';
  }

  @override
  String get newest => 'новий';

  @override
  String get popular => 'популярний';

  @override
  String get system => 'Система';

  @override
  String get yellow => 'Жовтий колір';

  @override
  String get orange => 'Помаранчевий';

  @override
  String get red => 'Червоний';

  @override
  String get magenta => 'Малиновий';

  @override
  String get purple => 'Пурпурний';

  @override
  String get blue => 'Синій';

  @override
  String get teal => 'Зелено-блакитний';

  @override
  String get green => 'Зелений';

  @override
  String get confirmForceRescrape => 'Підтвердити примусове перенаправлення';

  @override
  String
  get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'Буде видалено ВСІ локально збережені дані і повторно завантажити все з джерела. ';

  @override
  String
  get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'Цей процес може зайняти дуже багато часу і споживати значні дані мережі. Ви впевнені?';

  @override
  String get yesRescrapeAll => 'Так, переробити всі';

  @override
  String get startingFullDataRescrape => 'Початок повного відновлення даних...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'Усі дані було насильно вилучено.';

  @override
  String errorMessage(Object error) {
    return 'Помилка: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'Failed to force rescrape data: $errorMessage';
  }

  @override
  String get forceRescrapingData => 'Примусове перезапис даних';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'Завантаження та встановлення';

  @override
  String get defaultDownloadPath => 'Шлях завантаження за замовчуванням';

  @override
  String get maxConcurrentDownloads =>
      'Максимальна кількість одночасних завантажень';

  @override
  String get automaticInstallation => 'Автоматичне встановлення';

  @override
  String get enableAutoInstallAfterDownload =>
      'Автоматичне встановлення після завантаження:';

  @override
  String get defaultInstallationPath => 'Типовий шлях встановлення';

  @override
  String
  get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      'Якщо увімкнуто, завершені репакти спробують встановити на вказаний шлях.';

  @override
  String get appearance => 'Зовнішній вигляд';

  @override
  String get themeMode => 'Теми';

  @override
  String get navigationPaneDisplayMode => 'Режим відображення панелі навігації';

  @override
  String get accentColor => 'Колір акценту';

  @override
  String get windowTransparency => 'Прозорість вікна';

  @override
  String get local => 'Локалізація';

  @override
  String get applicationUpdates => 'Оновлення Застосунків';

  @override
  String get updateCheckFrequency => 'Частота перевірки оновлень';

  @override
  String get currentAppVersion => 'Поточна версія програми:';

  @override
  String get loading => 'Завантажується...';

  @override
  String get latestAvailableVersion => 'Остання доступна версія:';

  @override
  String get youAreOnTheLatestVersion => 'Ви знаходитесь у останній версії';

  @override
  String get checking => 'Перевірка...';

  @override
  String get notCheckedYet => ' Ще не перевірено.';

  @override
  String get checkToSee => ' Почекайте, щоб побачити.';

  @override
  String get youHaveIgnoredThisUpdate => 'Ви проігнорували це оновлення.';

  @override
  String get unignoreCheckAgain => 'Не ігнорувати та перевірити знову';

  @override
  String get checkForUpdatesNow => 'Перевірити наявність оновлень';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'Оновлення до версії $version доступне';
  }

  @override
  String get downloadAndInstallUpdate => 'Завантажити та встановити оновлення';

  @override
  String get viewReleasePage => 'Переглянути сторінку релізу';

  @override
  String get dataManagement => 'Управління даними';

  @override
  String get forceRescrapeAllData => 'Примусово збирати всі дані';

  @override
  String
  get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'Попередження: Цей процес може зайняти багато часу та споживати значні дані мережі. Використовуйте з обережністю.';

  @override
  String get rescrapingSeeDialog => 'Повторне завдання... дивіться діалог';

  @override
  String get forceRescrapeAllDataNow => 'Примусово збирати всі дані';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'Інший процес розсіювання вже запущений.';

  @override
  String get clearingAllExistingData => 'Очищення всіх існуючих даних...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'Шлібування всіх імен репозиторіїв (Фаза 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'Сторінки',
      one: 'сторінка',
    );
    return 'Шліфування всіх імен репозиторіїв (Фаза 1/4): сторінка $page $totalPages $_temp0';
  }

  @override
  String allRepackNamesScrapedPhase1(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'імені',
      one: 'ім\'я',
      zero: 'Ім\'я',
    );
    return 'Усі імена лагодження розвідані. ($count $_temp0 (Фаза 1/4 Завершення)';
  }

  @override
  String get scrapingDetailsForEveryRepackPhase2LongestPhase =>
      'Шкрябування подробиць для кожного ремонту (Фаза 2/4 - Довгий Фаза)...';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
    Object current,
    Object total,
  ) {
    return 'Шлібкувальна інформація для кожного кафедри (Фаза 2/4): Передачіть $current в $total';
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
      'Перескасовування нових репасток (Фаза 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'Переспрощення нових репасток (Фаза 3/4): сторінка $current з $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'Нові репаки переочищені. (Фаза 3/4 Завершено)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'Перескасовування популярних оновлень (Фаза 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'Перескасування популярних репакетів (Phase 4/4): Елемент $current з $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'Популярні репаки перескасовані. (Фаза 4/4 Завершено)';

  @override
  String get finalizing => 'Завершення...';

  @override
  String get fullRescrapeCompletedSuccessfully =>
      'Повне зібрання успішно завершено!';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'Помилка: $errorMessage. Процес припинено.';
  }

  @override
  String get daily => 'Щоденно';

  @override
  String get weekly => 'Щотижня';

  @override
  String get manual => 'Вручну';

  @override
  String get onEveryStartup => 'При кожному запуску';

  @override
  String get light => 'Світла';

  @override
  String get dark => 'Темна';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'Не знайдено URL-адреси в конфігурації дзеркала.';

  @override
  String get failedToProcessUnknownPlugin =>
      'Не вдалося обробити (невідомий плагін):';

  @override
  String get problemProcessingSomeLinks => 'Обробка деяких посилань. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'Помилка обробки одного або декількох посилань. ';

  @override
  String filesAddedToDownloadManager(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Файли',
      one: 'файл',
      zero: 'файли',
    );
    return '$count $_temp0 додано до системи завантаження менеджера.';
  }

  @override
  String get downloadStarted => 'Завантаження розпочато';

  @override
  String get ok => 'Гаразд';

  @override
  String get noFilesSelected => 'Не вибрано жодного файлу';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'Будь ласка, виберіть один або кілька файлів з дерева для завантаження.';

  @override
  String get noFilesCouldBeRetrieved => 'Жоден файл не може бути отриманий.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
    Object processingError,
  ) {
    return 'Повідомлення: $processingError деякі файли можуть виникнути проблеми.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'Для цього дзеркала не знайдено файлів, які можна завантажити.';

  @override
  String downloadFilesGame(Object Game) {
    return 'Download Files: $Game';
  }

  @override
  String get close => 'Закрити';

  @override
  String get downloadSelected => 'Завантажити вибрані';

  @override
  String get aboutGame => 'Про гру';

  @override
  String get features => 'Особливості';

  @override
  String get selectDownloadOptions => 'Виберіть параметри завантаження';

  @override
  String get downloadMethod => 'Метод завантаження:';

  @override
  String get selectMethod => 'Виберіть спосіб';

  @override
  String get mirror => 'Дзеркало:';

  @override
  String get selectMirror => 'Вибрати дзеркало';

  @override
  String get downloadLocation => 'Адреса завантаження:';

  @override
  String get enterDownloadLocationOrBrowse =>
      'Введіть розташування для завантаження або виберіть інше місце розташування';

  @override
  String get downloadLocationEmpty => 'Папка для завантаження порожня';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'Будь ласка, виберіть або введіть місце завантаження.';

  @override
  String get selectionIncomplete => 'Не завершено виділення';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'Будь ласка, виберіть метод завантаження і дзеркало.';

  @override
  String get next => 'Уперед';

  @override
  String get download => 'Звантажити';

  @override
  String get downloadComplete => 'Завантаження завершено!';

  @override
  String get downloadPending => 'Завантажити в очікування...';

  @override
  String get genres => 'Genres';

  @override
  String get company => 'Організація';

  @override
  String get language => 'Мова:';

  @override
  String get originalSize => 'Оригінальний розмір';

  @override
  String get repackSize => 'Перевизначити розмір';

  @override
  String get repackInformation => 'Передача інформації';

  @override
  String screenshotsTitle(Object count) {
    return 'Screenshots ($count)';
  }

  @override
  String get errorLoadingImage => 'Помилка при завантаженні зображення';

  @override
  String get noScreenshotsAvailable => 'Немає доступних знятків.';

  @override
  String get noGenresAvailable => 'Немає доступних жанрів';

  @override
  String get clear => 'Очистити';

  @override
  String get filterByGenre => 'Фільтр за жанром';

  @override
  String get filter => 'Фільтр';
}
