// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get success => 'نجاح';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'تم إلغاء حزم جديدة وشائعة.';

  @override
  String get error => 'خطأ';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'فشل في إلغاء بيانات الاغتصاب: $errorMessage';
  }

  @override
  String get home => 'المنزل';

  @override
  String get rescrapeNewPopular => 'إعادة اغتصاب جديد وشائع';

  @override
  String get newRepacks => 'حزم جديدة';

  @override
  String get popularRepacks => 'حزم شعبية';

  @override
  String get noCompletedGroupsToClear => 'لا توجد مجموعات مكتملة لحلها.';

  @override
  String get queued => 'قائمة الانتظار';

  @override
  String get downloading => 'تنزيل:';

  @override
  String get completed => 'مكتمل';

  @override
  String get failed => 'فشل';

  @override
  String get paused => 'متوقف';

  @override
  String get canceled => 'ملغاة';

  @override
  String get dismiss => 'تجاهل';

  @override
  String get confirmClear => 'تأكيد مسح';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'المجموعات',
      one: 'مجموعة',
      zero: 'مجموعات',
    );
    return 'هل أنت متأكد من أنك تريد إزالة $count اكتمل تنزيل $_temp0? سيؤدي هذا أيضا إلى إزالة الملفات من القرص إذا كانت في مجلدات فرعية مخصصة يديرها التطبيق.';
  }

  @override
  String get clearCompleted => 'مسح المكتمل';

  @override
  String get cancel => 'إلغاء';

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
  String get downloadManager => 'مدير التحميل';

  @override
  String get maxConcurrent => 'الحد الأقصى للتزامن';

  @override
  String get noActiveDownloads => 'لا يوجد تنزيلات نشطة.';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'التنزيلات ستظهر هنا بمجرد إضافتها.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'إلغاء جميع التنزيلات في هذه المجموعة';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'هل أنت متأكد من أنك تريد إلغاء جميع التنزيلات في هذه المجموعة وإزالتها؟';

  @override
  String completedNumberFiles(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ملفات',
      one: 'ملف',
      zero: 'ملفات',
    );
    return 'أكمل $count $_temp0';
  }

  @override
  String overallProgressFilesPercent(num count, Object percent) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ملفات',
      one: 'ملف',
    );
    return 'إجمالا: $percent% ($count $_temp0';
  }

  @override
  String noActiveTasks(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ملفات',
      one: 'ملف',
    );
    return 'لا توجد مهام نشطة أو تقدم غير متوفر ($count $_temp0';
  }

  @override
  String cancelGroupName(Object groupName) {
    return 'إلغاء المجموعة: $groupName';
  }

  @override
  String get removeFromList => 'إزالة من القائمة';

  @override
  String get resume => 'استئناف';

  @override
  String get pause => 'إيقاف';

  @override
  String get errorTaskDataUnavailable => 'خطأ: بيانات المهمة غير متوفرة';

  @override
  String get unknownFile => 'ملف غير معروف';

  @override
  String get yesCancelGroup => 'نعم، إلغاء المجموعة';

  @override
  String get no => 'لا';

  @override
  String get repackLibrary => 'حزمة المكتبة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get unknown => 'غير معروف';

  @override
  String get noReleaseNotesAvailable => 'لا توجد ملاحظات الإصدار المتاحة.';

  @override
  String get search => 'البحث';

  @override
  String updateAvailable(Object version) {
    return 'تحديث متوفر: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'يتوفر إصدار جديد من FitFlutter';

  @override
  String get viewReleaseNotes => 'عرض ملاحظات الإصدار';

  @override
  String get releasePage => 'صفحة الإصدار';

  @override
  String get later => 'لاحقاً';

  @override
  String get upgrade => 'ترقية';

  @override
  String get downloadsInProgress => 'التحميلات قيد التقدم';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'إغلاق التطبيق سيلغي جميع التنزيلات النشطة. ';

  @override
  String get areYouSureYouWantToClose => 'هل أنت متأكد من رغبتك في الإغلاق؟';

  @override
  String get yesCloseCancel => 'نعم، أغلق وألغي';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'اختار المستخدم الإغلاق؛ إلغاء التنزيلات.';

  @override
  String get keepDownloading => 'مواصلة التحميل';

  @override
  String get startingLibrarySync => 'بدء مزامنة المكتبة...';

  @override
  String get fetchingAllRepackNames => 'جلب جميع أسماء الحزمة...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'صفحات',
      one: 'صفحة',
    );
    return 'جلب الأسماء: $page من $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails => 'تخطي تفاصيل الحزمة المفقودة...';

  @override
  String get thisMayTakeAWhile => 'قد يستغرق ذلك بعض الوقت.';

  @override
  String scrapingMissingRepackDetailsProgress(num current, num total) {
    String _temp0 = intl.Intl.pluralLogic(
      current,
      locale: localeName,
      other: 'حزم',
      one: 'حزمة',
    );
    return 'تفاصيل الاستراحة: $current/$total مفقود $_temp0';
  }

  @override
  String get repackLibrarySynchronized => 'تم مزامنة حزمة المكتبة';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'فشل مزامنة المكتبة: $errorMessage';
  }

  @override
  String get syncLibrary => 'مزامنة المكتبة';

  @override
  String get syncingLibrary => 'مزامنة المكتبة...';

  @override
  String get noRepacksFoundInTheLibrary => 'لا توجد حزم في المكتبة.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'لم يتم العثور على أي حزم مطابقة $search.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'النافذة ضيقة جدا لعرض العناصر بشكل صحيح.';

  @override
  String get pleaseResizeTheWindow => 'الرجاء تغيير حجم النافذة.';

  @override
  String get repackUrlIsNotAvailable => 'رابط الحزمة غير متوفر.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'تعذر تشغيل الرابط: $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return 'تعذر التشغيل: $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return 'تنسيق URL غير صالح: $url';
  }

  @override
  String get rescrapeDetails => 'تفاصيل إعادة التشويش';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return 'تم إلغاء وتحديث تفاصيل $title.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'فشل في إلغاء التفاصيل: $errorMessage';
  }

  @override
  String get errorRescraping => 'إعادة إفراغ الخطأ';

  @override
  String get openSourcePage => 'صفحة المصدر المفتوح';

  @override
  String noPopularNewRepacksFound(Object type) {
    return 'لم يتم العثور على أي حزم $type.';
  }

  @override
  String get newest => 'جديد';

  @override
  String get popular => 'شعبية';

  @override
  String get system => 'النظام';

  @override
  String get yellow => 'أصفر';

  @override
  String get orange => 'برتقالي';

  @override
  String get red => 'أحمر';

  @override
  String get magenta => 'أرجواني';

  @override
  String get purple => 'بنفسجي';

  @override
  String get blue => 'أزرق';

  @override
  String get teal => 'الفم';

  @override
  String get green => 'أخضر';

  @override
  String get confirmForceRescrape => 'تأكيد إعادة فرز القوة';

  @override
  String get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'سيؤدي هذا إلى حذف جميع بيانات الحزمة المخزنة محليا وإعادة تحميل كل شيء من المصدر. ';

  @override
  String get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'هذه العملية قد تستغرق وقتاً طويلاً وتستهلك بيانات شبكة كبيرة. هل أنت متأكد؟';

  @override
  String get yesRescrapeAll => 'نعم، إعادة اغتصاب الكل';

  @override
  String get startingFullDataRescrape => 'بدء إلغاء البيانات الكاملة...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'تم إلغاء جميع البيانات بقوة.';

  @override
  String errorMessage(Object error) {
    return 'خطأ: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'فشل في فرض بيانات الإغلاق: $errorMessage';
  }

  @override
  String get forceRescrapingData => 'فرض إعادة تصنيف البيانات';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'التنزيلات والتثبيت';

  @override
  String get defaultDownloadPath => 'مسار التحميل الافتراضي';

  @override
  String get maxConcurrentDownloads => 'الحد الأقصى لتنزيلات متزامنة';

  @override
  String get automaticInstallation => 'تثبيت تلقائي';

  @override
  String get enableAutoInstallAfterDownload =>
      'تمكين التثبيت التلقائي بعد التنزيل:';

  @override
  String get defaultInstallationPath => 'مسار التثبيت الافتراضي';

  @override
  String
      get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
          'عند التمكين، ستحاول الحزم المكتملة التثبيت إلى المسار المحدد.';

  @override
  String get appearance => 'المظهر';

  @override
  String get themeMode => 'وضع السمة';

  @override
  String get navigationPaneDisplayMode => 'وضع عرض لوحة التنقل';

  @override
  String get accentColor => 'لون اللكنة';

  @override
  String get windowTransparency => 'شفافية النافذة';

  @override
  String get local => 'محلي';

  @override
  String get applicationUpdates => 'تحديثات التطبيق';

  @override
  String get updateCheckFrequency => 'تردد التحقق من التحديث';

  @override
  String get currentAppVersion => 'إصدار التطبيق الحالي:';

  @override
  String get loading => 'تحميل...';

  @override
  String get latestAvailableVersion => 'أحدث إصدار متاح:';

  @override
  String get youAreOnTheLatestVersion => 'أنت على أحدث إصدار';

  @override
  String get checking => 'يتحقق...';

  @override
  String get notCheckedYet => ' لم يتم التحقق بعد.';

  @override
  String get checkToSee => ' تحقق لرؤيته.';

  @override
  String get youHaveIgnoredThisUpdate => 'لقد تجاهلت هذا التحديث.';

  @override
  String get unignoreCheckAgain => 'عدم تجاهل و تحقق مرة أخرى';

  @override
  String get checkForUpdatesNow => 'تحقق من وجود تحديثات الآن';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'يتوفر التحديث إلى الإصدار $version';
  }

  @override
  String get downloadAndInstallUpdate => 'تحميل وتثبيت التحديث';

  @override
  String get viewReleasePage => 'عرض صفحة الإصدار';

  @override
  String get dataManagement => 'إدارة البيانات';

  @override
  String get forceRescrapeAllData => 'إعادة فرض جميع البيانات';

  @override
  String get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'تحذير: هذه العملية قد تستغرق وقتاً طويلاً وتستهلك بيانات شبكة كبيرة. استخدمها بحذر.';

  @override
  String get rescrapingSeeDialog => 'إعادة... شاهد مربع الحوار';

  @override
  String get forceRescrapeAllDataNow => 'إجبار جميع البيانات الآن';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'وهناك عملية إلغاء أخرى قيد التشغيل بالفعل.';

  @override
  String get clearingAllExistingData => 'مسح جميع البيانات الموجودة...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'تخليص جميع أسماء الحزم (المرحلة 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'صفحات',
      one: 'صفحة',
    );
    return 'تخطي جميع أسماء الحزم (المرحلة 1/4): الصفحة $page من $totalPages $_temp0';
  }

  @override
  String allRepackNamesScrapedPhase1(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'اسم',
      one: 'اسم',
      zero: 'اسم',
    );
    return 'تم تخريد جميع أسماء الحزمة. ($count $_temp0 (المرحلة 1/4 كاملة)';
  }

  @override
  String get scrapingDetailsForEveryRepackPhase2LongestPhase =>
      'تفاصيل الخريطة لكل باقة (المرحلة 2/4 - الأطول مرحلة)...';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
      Object current, Object total) {
    return 'تفاصيل التخريب لكل حزمة (المرحلة 2/4): الحزمة $current من $total';
  }

  @override
  String allRepackDetailsScrapedPhase2(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'حزم',
      one: 'حزمة',
      zero: 'حزم',
    );
    return 'تم تخريد جميع تفاصيل الحزمة. ($count $_temp0 تمت معالجتها (المرحلة 2/4 كاملة)';
  }

  @override
  String get rescrapingNewRepacksPhase3 => 'إعادة حزم جديدة (المرحلة 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'إعادة حزم جديدة (المرحلة 3/4): الصفحة $current من $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'حزم جديدة ملغاة. (المرحلة 3/4 مكتملة)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'استعادة الحزم الشعبية (المرحلة 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'استعادة الحزم الشعبية (المرحلة 4/4): العنصر $current من $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'تم إلغاء الحزم الشعبية. (المرحلة 4/4 مكتملة)';

  @override
  String get finalizing => 'وضع اللمسات الأخيرة';

  @override
  String get fullRescrapeCompletedSuccessfully => 'تم الإلغاء الكامل بنجاح!';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'خطأ: $errorMessage. توقفت العملية.';
  }

  @override
  String get daily => 'يومياً';

  @override
  String get weekly => 'أسبوعيا';

  @override
  String get manual => 'دليل';

  @override
  String get onEveryStartup => 'في كل بداية';

  @override
  String get light => 'فاتح';

  @override
  String get dark => 'داكن';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'لم يتم العثور على عناوين URL في تكوين المرآة.';

  @override
  String get failedToProcessUnknownPlugin =>
      'فشل في المعالجة (إضافة غير معروفة):';

  @override
  String get problemProcessingSomeLinks => 'مشكلة في معالجة بعض الروابط. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'خطأ في معالجة رابط واحد أو أكثر. ';

  @override
  String filesAddedToDownloadManager(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ملفات',
      one: 'ملف',
      zero: 'ملفات',
    );
    return '$count $_temp0 تمت إضافتها إلى مدير التحميل.';
  }

  @override
  String get downloadStarted => 'بدأ التحميل';

  @override
  String get ok => 'حسناً';

  @override
  String get noFilesSelected => 'لا توجد ملفات محددة';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'الرجاء تحديد ملف واحد أو أكثر من الشجرة للتنزيل.';

  @override
  String get noFilesCouldBeRetrieved => 'لا يمكن استرجاع أي ملفات.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
      Object processingError) {
    return 'إشعار: $processingError قد واجهت بعض الملفات مشكلات.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'لم يتم العثور على ملفات قابلة للتنزيل لهذه المرآة.';

  @override
  String downloadFilesGame(Object Game) {
    return 'تحميل الملفات: $Game';
  }

  @override
  String get close => 'أغلق';

  @override
  String get downloadSelected => 'تحميل المحدد';

  @override
  String get aboutGame => 'حول اللعبة';

  @override
  String get features => 'الميزات';

  @override
  String get selectDownloadOptions => 'حدد خيارات التحميل';

  @override
  String get downloadMethod => 'طريقة التنزيل:';

  @override
  String get selectMethod => 'حدد طريقة';

  @override
  String get mirror => 'مرآة';

  @override
  String get selectMirror => 'اختر مرآة';

  @override
  String get downloadLocation => 'موقع التحميل:';

  @override
  String get enterDownloadLocationOrBrowse => 'أدخل موقع التحميل أو تصفح';

  @override
  String get downloadLocationEmpty => 'موقع التحميل فارغ';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'الرجاء تحديد أو إدخال موقع التنزيل.';

  @override
  String get selectionIncomplete => 'الاختيار غير مكتمل';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'الرجاء تحديد طريقة تحميل ومرآة.';

  @override
  String get next => 'التالي';

  @override
  String get download => 'تنزيل';

  @override
  String get downloadComplete => 'اكتمل التنزيل!';

  @override
  String get downloadPending => 'تنزيل معلق...';

  @override
  String get genres => 'Genres';

  @override
  String get company => 'الشركة';

  @override
  String get language => 'اللغة';

  @override
  String get originalSize => 'الحجم الأصلي';

  @override
  String get repackSize => 'حجم الحزمة';

  @override
  String get repackInformation => 'حزمة المعلومات';

  @override
  String screenshotsTitle(Object count) {
    return 'Screenshots ($count)';
  }

  @override
  String get errorLoadingImage => 'خطأ في تحميل الصورة';

  @override
  String get noScreenshotsAvailable => 'لا توجد لقطات شاشة متوفرة.';

  @override
  String get noGenresAvailable => 'لا توجد أنواع متاحة';

  @override
  String get clear => 'مسح';

  @override
  String get filterByGenre => 'تصفية حسب النوع';

  @override
  String get filter => 'تصفية';
}
