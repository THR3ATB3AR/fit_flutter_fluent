// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get success => '成功';

  @override
  String get newAndPopularRepacksHaveBeenRescraped => '新しいリパックと人気リパックが再開されました。';

  @override
  String get error => 'エラー';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'データの再作成に失敗しました: $errorMessage';
  }

  @override
  String get home => 'ホーム';

  @override
  String get rescrapeNewPopular => '新しいリスクレイプ&人気';

  @override
  String get newRepacks => '新しいリポジトリ';

  @override
  String get popularRepacks => '人気のリポジトリ';

  @override
  String get noCompletedGroupsToClear => 'クリアできる完了したグループはありません。';

  @override
  String get queued => 'キューに入りました';

  @override
  String get downloading => 'ダウンロード中:';

  @override
  String get completed => '完了';

  @override
  String get failed => '失敗しました';

  @override
  String get paused => '一時停止';

  @override
  String get canceled => 'キャンセルしました';

  @override
  String get dismiss => '却下する';

  @override
  String get confirmClear => '消去の確認';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'groups',
      one: 'group',
      zero: 'groups',
    );
    return 'Are you sure you want to remove $count completed download $_temp0? This will also remove files from disk if they are in dedicated subfolders managed by the app.';
  }

  @override
  String get clearCompleted => 'クリア完了';

  @override
  String get cancel => 'キャンセル';

  @override
  String completedGroupsCleared(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'グループ',
      one: 'グループ',
      zero: 'グループ',
    );
    return '$count が完了しました $_temp0 がクリアされました!';
  }

  @override
  String get downloadManager => 'ダウンロードマネージャー';

  @override
  String get maxConcurrent => '最大同時電流';

  @override
  String get noActiveDownloads => 'アクティブなダウンロードはありません。';

  @override
  String get downloadsWillAppearHereOnceAdded => '追加するとダウンロードがここに表示されます。';

  @override
  String get cancelAllDownloadsInThisGroup => 'このグループ内のすべてのダウンロードをキャンセル';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'このグループ内のすべてのダウンロードをキャンセルして削除してもよろしいですか？';

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
    return 'アクティブなタスクや進行状況がありません ($count $_temp0)';
  }

  @override
  String cancelGroupName(Object groupName) {
    return 'グループをキャンセル: $groupName';
  }

  @override
  String get removeFromList => 'リストから削除';

  @override
  String get resume => '再開';

  @override
  String get pause => '一時停止';

  @override
  String get errorTaskDataUnavailable => 'エラー：タスクデータが利用できません';

  @override
  String get unknownFile => '不明なファイル';

  @override
  String get yesCancelGroup => 'はい、グループをキャンセルします';

  @override
  String get no => 'いいえ';

  @override
  String get repackLibrary => 'リパックライブラリ';

  @override
  String get settings => '設定';

  @override
  String get unknown => '不明';

  @override
  String get noReleaseNotesAvailable => '利用可能なリリースノートはありません。';

  @override
  String get search => '検索';

  @override
  String updateAvailable(Object version) {
    return '利用可能なアップデート: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'FitFlutterの新しいバージョンが利用可能です。';

  @override
  String get viewReleaseNotes => 'リリースノートを表示';

  @override
  String get releasePage => '公開ページ';

  @override
  String get later => '後で';

  @override
  String get upgrade => 'アップグレードする';

  @override
  String get downloadsInProgress => 'ダウンロード中';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'アプリケーションを閉じると、すべてのアクティブなダウンロードがキャンセルされます。 ';

  @override
  String get areYouSureYouWantToClose => '本当に閉じますか？';

  @override
  String get yesCloseCancel => '閉じてキャンセルする';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'ユーザーが閉じることを選択しました; ダウンロードをキャンセルします。';

  @override
  String get keepDownloading => 'ダウンロードを続ける';

  @override
  String get startingLibrarySync => 'ライブラリの同期を開始しています...';

  @override
  String get fetchingAllRepackNames => 'すべてのリポジトリ名を取得しています...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'page',
      one: 'page',
    );
    return '名前を取得中: $page of $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails => '不足しているリポジトリの詳細をスクラップしています...';

  @override
  String get thisMayTakeAWhile => 'これは時間がかかることがあります。';

  @override
  String scrapingMissingRepackDetailsProgress(num current, num total) {
    String _temp0 = intl.Intl.pluralLogic(
      current,
      locale: localeName,
      other: 'repacks',
      one: 'repack',
    );
    return '詳細をスクラップ中： $current/$total が見つかりません $_temp0';
  }

  @override
  String get repackLibrarySynchronized => 'リポジトリライブラリが同期されました。';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'ライブラリの同期に失敗しました: $errorMessage';
  }

  @override
  String get syncLibrary => 'ライブラリを同期';

  @override
  String get syncingLibrary => 'ライブラリを同期しています...';

  @override
  String get noRepacksFoundInTheLibrary => 'ライブラリにリパックが見つかりません。';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return '$search に一致するリパックが見つかりません。';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'ウィンドウが狭すぎて、アイテムを正しく表示できません。';

  @override
  String get pleaseResizeTheWindow => 'ウィンドウのサイズを変更してください。';

  @override
  String get repackUrlIsNotAvailable => 'Repack URL is not available.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'URLを起動できませんでした: $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return '起動できませんでした: $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return '無効なURL形式: $url';
  }

  @override
  String get rescrapeDetails => 'リスクレイプの詳細';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return '$title の詳細が再作成および更新されました。';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return '詳細の再作成に失敗しました: $errorMessage';
  }

  @override
  String get errorRescraping => '再分割エラー';

  @override
  String get openSourcePage => 'オープンソースページ';

  @override
  String noPopularNewRepacksFound(Object type) {
    return '$type リパックが見つかりません。';
  }

  @override
  String get newest => '新規';

  @override
  String get popular => '人気のある';

  @override
  String get system => 'システム';

  @override
  String get yellow => '黄色';

  @override
  String get orange => 'オレンジ';

  @override
  String get red => '赤';

  @override
  String get magenta => 'マゼンタ';

  @override
  String get purple => 'パープル';

  @override
  String get blue => '青';

  @override
  String get teal => 'ティール';

  @override
  String get green => '緑';

  @override
  String get confirmForceRescrape => '強制的に再スクレイプを確認';

  @override
  String
  get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'これは、ローカルに保存されたすべてのリポジトリデータを削除し、ソースからすべてを再ダウンロードします。 ';

  @override
  String
  get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'このプロセスには非常に長い時間がかかり、重要なネットワークデータを消費します。よろしいですか？';

  @override
  String get yesRescrapeAll => 'はい、すべて再スクレイプします';

  @override
  String get startingFullDataRescrape => 'フルデータの再起動中...';

  @override
  String get allDataHasBeenForcefullyRescraped => 'すべてのデータが強制的に再クラップされました。';

  @override
  String errorMessage(Object error) {
    return 'エラー: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'リスクレイプデータを強制できませんでした: $errorMessage';
  }

  @override
  String get forceRescrapingData => 'データを強制的に再分割する';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'ダウンロードとインストール';

  @override
  String get defaultDownloadPath => 'デフォルトのダウンロードパス';

  @override
  String get maxConcurrentDownloads => '最大同時ダウンロード数';

  @override
  String get automaticInstallation => '自動インストール';

  @override
  String get enableAutoInstallAfterDownload => 'ダウンロード後に自動インストールを有効にする:';

  @override
  String get defaultInstallationPath => 'デフォルトのインストールパス';

  @override
  String
  get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      '有効にすると、完了したリパックは指定されたパスにインストールしようとします。';

  @override
  String get appearance => '外観';

  @override
  String get themeMode => 'テーマモード';

  @override
  String get navigationPaneDisplayMode => 'ナビゲーションペイン表示モード';

  @override
  String get accentColor => 'アクセントカラー';

  @override
  String get windowTransparency => 'ウィンドウの透明度';

  @override
  String get local => 'ロケール';

  @override
  String get applicationUpdates => 'アプリケーションの更新';

  @override
  String get updateCheckFrequency => 'チェック頻度を更新';

  @override
  String get currentAppVersion => '現在のアプリのバージョン:';

  @override
  String get loading => '読み込み中...';

  @override
  String get latestAvailableVersion => '最新バージョン:';

  @override
  String get youAreOnTheLatestVersion => 'あなたは最新のバージョンを使用しています';

  @override
  String get checking => '確認しています...';

  @override
  String get notCheckedYet => ' まだチェックされていません。';

  @override
  String get checkToSee => ' 確認してください。';

  @override
  String get youHaveIgnoredThisUpdate => 'この更新は無視されました。';

  @override
  String get unignoreCheckAgain => '再度無視&チェック';

  @override
  String get checkForUpdatesNow => 'アップデートを確認する';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'バージョン $version へのアップデートが利用可能です';
  }

  @override
  String get downloadAndInstallUpdate => 'アップデートのダウンロードとインストール';

  @override
  String get viewReleasePage => 'リリースページを表示';

  @override
  String get dataManagement => 'データ管理';

  @override
  String get forceRescrapeAllData => 'すべてのデータを強制的に再スクレイプする';

  @override
  String
  get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      '警告：このプロセスには非常に長い時間がかかり、重要なネットワークデータを消費する可能性があります。注意して使用してください。';

  @override
  String get rescrapingSeeDialog => '再起動中... ダイアログ を参照';

  @override
  String get forceRescrapeAllDataNow => '今すぐすべてのデータを強制的に再スクレイプする';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      '別の再分割プロセスはすでに実行されています。';

  @override
  String get clearingAllExistingData => '既存のすべてのデータをクリアしています...';

  @override
  String get scrapingAllRepackNamesPhase1 => 'すべてのリポジトリ名をスクラップ中 (Phase 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'page',
      one: 'page',
    );
    return 'すべてのリポジトリ名をスクラップしています (フェーズ 1/4): $page の $totalPages $_temp0';
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
      'すべてのリポジトリの詳細をスクラップする (フェーズ2/4 - 最長フェーズ)。';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
    Object current,
    Object total,
  ) {
    return 'すべてのリパックの詳細をスクラップする (フェーズ2/4): $current のリパック $total';
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
  String get rescrapingNewRepacksPhase3 => '新しいリパックを再作成中 (フェーズ3/4) ...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return '新しいリパックを再作成中 (フェーズ3/4): $current / $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete => '新しいリパックが再開されました。（フェーズ3/4完了）';

  @override
  String get rescrapingPopularRepacksPhase4 => '人気のリパックを再作成中 (Phase 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return '人気のリパックを再集結中 (フェーズ4/4): アイテム $current / $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      '人気リパックが再開されました。（フェーズ4/4完了）';

  @override
  String get finalizing => '完了中...';

  @override
  String get fullRescrapeCompletedSuccessfully => '完全なリスクレイプが正常に完了しました！';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'エラー： $errorMessage処理を停止しました。';
  }

  @override
  String get daily => '毎日';

  @override
  String get weekly => 'Weekly';

  @override
  String get manual => 'マニュアル';

  @override
  String get onEveryStartup => 'すべての起動時';

  @override
  String get light => 'ライト';

  @override
  String get dark => 'ダーク';

  @override
  String get noUrlsFoundInTheMirrorConfiguration => 'ミラー設定に URL が見つかりません。';

  @override
  String get failedToProcessUnknownPlugin => '処理に失敗しました (不明なプラグイン):';

  @override
  String get problemProcessingSomeLinks => 'いくつかのリンクの処理に問題があります。 ';

  @override
  String get errorProcessingOneOrMoreLinks => '1つまたは複数のリンクを処理中にエラーが発生しました。 ';

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
  String get downloadStarted => 'ダウンロード開始';

  @override
  String get ok => 'OK';

  @override
  String get noFilesSelected => 'ファイルが選択されていません';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'ダウンロードするにはツリーから1つ以上のファイルを選択してください。';

  @override
  String get noFilesCouldBeRetrieved => 'ファイルを取得できませんでした。';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
    Object processingError,
  ) {
    return '注意: $processingError いくつかのファイルに問題が発生した可能性があります。';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'このミラー用のダウンロード可能なファイルが見つかりません。';

  @override
  String downloadFilesGame(Object Game) {
    return 'ダウンロードファイル: $Game';
  }

  @override
  String get close => '閉じる';

  @override
  String get downloadSelected => '選択したものをダウンロード';

  @override
  String get aboutGame => 'ゲームについて';

  @override
  String get features => '特徴';

  @override
  String get selectDownloadOptions => 'ダウンロードオプションを選択';

  @override
  String get downloadMethod => 'ダウンロード方法:';

  @override
  String get selectMethod => 'Select method';

  @override
  String get mirror => 'ミラー:';

  @override
  String get selectMirror => 'ミラーを選択';

  @override
  String get downloadLocation => 'ダウンロード場所:';

  @override
  String get enterDownloadLocationOrBrowse => 'ダウンロード先を入力するか、参照してください';

  @override
  String get downloadLocationEmpty => 'ダウンロード場所が空です';

  @override
  String get pleaseSelectOrEnterADownloadLocation => 'ダウンロード先を選択するか入力してください。';

  @override
  String get selectionIncomplete => '選択が未完了';

  @override
  String get pleaseSelectADownloadMethodAndAMirror => 'ダウンロード方法とミラーを選択してください。';

  @override
  String get next => '次へ';

  @override
  String get download => 'ダウンロード';

  @override
  String get downloadComplete => 'ダウンロード完了！';

  @override
  String get downloadPending => 'ダウンロード保留中...';

  @override
  String get genres => 'Genres';

  @override
  String get company => '会社名';

  @override
  String get language => '言語';

  @override
  String get originalSize => '元のサイズ';

  @override
  String get repackSize => '返品サイズ';

  @override
  String get repackInformation => '返品情報';

  @override
  String screenshotsTitle(Object count) {
    return 'Screenshots ($count)';
  }

  @override
  String get errorLoadingImage => '画像の読み込みに失敗しました';

  @override
  String get noScreenshotsAvailable => 'スクリーンショットはありません。';

  @override
  String get noGenresAvailable => '利用可能なジャンルがありません';

  @override
  String get clear => 'クリア';

  @override
  String get filterByGenre => 'ジャンルでフィルター';

  @override
  String get filter => 'フィルター';

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
