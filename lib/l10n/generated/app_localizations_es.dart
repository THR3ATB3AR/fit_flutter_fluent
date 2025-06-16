// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get success => 'Éxito';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'Los paquetes nuevos y populares han sido rediseñados.';

  @override
  String get error => 'Error';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'No se pudo volver a procesar los datos: $errorMessage';
  }

  @override
  String get home => 'Inicio';

  @override
  String get rescrapeNewPopular => 'Crear nuevo y popular';

  @override
  String get newRepacks => 'Nuevos paquetes';

  @override
  String get popularRepacks => 'Paquetes populares';

  @override
  String get noCompletedGroupsToClear =>
      'No hay grupos completados para borrar.';

  @override
  String get queued => 'En cola';

  @override
  String get downloading => 'Descargando:';

  @override
  String get completed => 'Completado';

  @override
  String get failed => 'Fallo';

  @override
  String get paused => 'Pausado';

  @override
  String get canceled => 'Cancelado';

  @override
  String get dismiss => 'Descartar';

  @override
  String get confirmClear => 'Confirmar Borrar';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '¡grupos',
      one: 'grupo',
      zero: 'grupos',
    );
    return '¿Estás seguro de que quieres eliminar $count de descarga completada $_temp0? Esto también eliminará archivos del disco si están en subcarpetas dedicadas administradas por la aplicación.';
  }

  @override
  String get clearCompleted => 'Limpiar Completado';

  @override
  String get cancel => 'Cancelar';

  @override
  String completedGroupsCleared(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '¡Grupos',
      one: '¡grupo',
      zero: '¡Grupos',
    );
    return '¡$count completada $_temp0 borrado.';
  }

  @override
  String get downloadManager => 'Gestor de descargas';

  @override
  String get maxConcurrent => 'Máximo concurrente';

  @override
  String get noActiveDownloads => 'No hay descargas activas.';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'Las descargas aparecerán aquí una vez añadidas.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'Cancelar todas las descargas de este grupo';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      '¿Estás seguro de que quieres cancelar todas las descargas de este grupo y eliminarlas?';

  @override
  String completedNumberFiles(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'archivos',
      one: 'archivo',
      zero: 'archivos',
    );
    return 'Completado $count $_temp0';
  }

  @override
  String overallProgressFilesPercent(num count, Object percent) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'archivos',
      one: 'archivo',
    );
    return 'En total: $percent% ($count $_temp0)';
  }

  @override
  String noActiveTasks(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'archivos',
      one: 'archivo',
    );
    return 'No hay tareas activas o progreso no disponible ($count $_temp0)';
  }

  @override
  String cancelGroupName(Object groupName) {
    return 'Cancelar grupo: $groupName';
  }

  @override
  String get removeFromList => 'Eliminar de la lista';

  @override
  String get resume => 'Reanudar';

  @override
  String get pause => 'Pausa';

  @override
  String get errorTaskDataUnavailable =>
      'Error: Datos de la tarea no disponibles';

  @override
  String get unknownFile => 'Archivo desconocido';

  @override
  String get yesCancelGroup => 'Sí, Cancelar Grupo';

  @override
  String get no => 'Nu';

  @override
  String get repackLibrary => 'Repetir biblioteca';

  @override
  String get settings => 'Ajustes';

  @override
  String get unknown => 'Desconocido';

  @override
  String get noReleaseNotesAvailable =>
      'No hay notas de publicación disponibles.';

  @override
  String get search => 'Buscar';

  @override
  String updateAvailable(Object version) {
    return 'Actualización disponible: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'Una nueva versión de FitFlutter está disponible.';

  @override
  String get viewReleaseNotes => 'Ver notas de lanzamiento';

  @override
  String get releasePage => 'Publicar página';

  @override
  String get later => 'Más tarde';

  @override
  String get upgrade => 'Mejorar';

  @override
  String get downloadsInProgress => 'Descargas en curso';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'Al cerrar la aplicación se cancelarán todas las descargas activas. ';

  @override
  String get areYouSureYouWantToClose => '¿Estás seguro de que quieres cerrar?';

  @override
  String get yesCloseCancel => 'Sí, Cerrar y Cancelar';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'El usuario eligió cerrar; cancelando descargas.';

  @override
  String get keepDownloading => 'Sigue descargando';

  @override
  String get startingLibrarySync =>
      'Iniciando la sincronización de la biblioteca...';

  @override
  String get fetchingAllRepackNames =>
      'Obteniendo todos los nombres del repaquete...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'páginas',
      one: 'Página',
    );
    return 'Recuperando nombres: $page of $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails =>
      'Raspando los detalles del repaquete...';

  @override
  String get thisMayTakeAWhile => 'Esto puede llevar un tiempo.';

  @override
  String scrapingMissingRepackDetailsProgress(num current, num total) {
    String _temp0 = intl.Intl.pluralLogic(
      current,
      locale: localeName,
      other: 'Repacks',
      one: 'Repack',
    );
    return 'Detalles del rastreo: $current/$total falta $_temp0';
  }

  @override
  String get repackLibrarySynchronized =>
      'Biblioteca de repositorios sincronizada.';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'Error al sincronizar la biblioteca: $errorMessage';
  }

  @override
  String get syncLibrary => 'Sincronizar biblioteca';

  @override
  String get syncingLibrary => 'Sincronizando Biblioteca...';

  @override
  String get noRepacksFoundInTheLibrary =>
      'No se encontraron paquetes en la biblioteca.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'No se han encontrado repacks que coincidan con $search.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'La ventana es demasiado estrecha para mostrar los elementos correctamente.';

  @override
  String get pleaseResizeTheWindow => 'Por favor, redimensiona la ventana.';

  @override
  String get repackUrlIsNotAvailable =>
      'La URL del paquete no está disponible.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'No se pudo lanzar la URL: $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return 'No se pudo lanzar: $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return 'Formato de URL no válido: $url';
  }

  @override
  String get rescrapeDetails => 'Volver a abrir detalles';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return 'Los detalles de $title han sido reasignados y actualizados.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'No se pudo volver a procesar los detalles: $errorMessage';
  }

  @override
  String get errorRescraping => 'Error al retrazar';

  @override
  String get openSourcePage => 'Página de código abierto';

  @override
  String noPopularNewRepacksFound(Object type) {
    return 'No se encontraron repacks $type.';
  }

  @override
  String get newest => 'nuevo';

  @override
  String get popular => 'popular';

  @override
  String get system => 'Sistema';

  @override
  String get yellow => 'Amarillo';

  @override
  String get orange => 'Naranja';

  @override
  String get red => 'Rojo';

  @override
  String get magenta => 'Magenta';

  @override
  String get purple => 'Morado';

  @override
  String get blue => 'Azul';

  @override
  String get teal => 'Cereal';

  @override
  String get green => 'Verde';

  @override
  String get confirmForceRescrape => 'Confirmar Retracción de Fuerza';

  @override
  String
  get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'Esto eliminará TODOS los datos de reempaquetado almacenados localmente y volverá a descargar todo desde la fuente. ';

  @override
  String
  get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'Este proceso puede llevar mucho tiempo y consumir datos de red significativos. ¿Está seguro?';

  @override
  String get yesRescrapeAll => 'Sí, volver a poner todo';

  @override
  String get startingFullDataRescrape =>
      'Comenzando la reescritura de datos completa...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'Todos los datos han sido codificados con fuerza.';

  @override
  String errorMessage(Object error) {
    return 'Error: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'No se pudo forzar el recambio de datos: $errorMessage';
  }

  @override
  String get forceRescrapingData => 'Forzar retracción de datos';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'Descargas e instalación';

  @override
  String get defaultDownloadPath => 'Ruta de descarga por defecto';

  @override
  String get maxConcurrentDownloads => 'Máximas descargas simultáneas';

  @override
  String get automaticInstallation => 'Instalación automática';

  @override
  String get enableAutoInstallAfterDownload =>
      'Activar la instalación automática después de la descarga:';

  @override
  String get defaultInstallationPath => 'Ruta de instalación por defecto';

  @override
  String
  get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      'Cuando está habilitado, los paquetes completados intentarán instalarse en la ruta especificada.';

  @override
  String get appearance => 'Apariencia';

  @override
  String get themeMode => 'Modo de tema';

  @override
  String get navigationPaneDisplayMode =>
      'Modo de visualización del panel de navegación';

  @override
  String get accentColor => 'Color de acento';

  @override
  String get windowTransparency => 'Ventana de transparencia';

  @override
  String get local => 'Local';

  @override
  String get applicationUpdates => 'Actualizaciones de aplicación';

  @override
  String get updateCheckFrequency => 'Actualizar Frecuencia de Comprobar';

  @override
  String get currentAppVersion => 'Versión actual de la aplicación:';

  @override
  String get loading => 'Cargando...';

  @override
  String get latestAvailableVersion => 'Última versión disponible:';

  @override
  String get youAreOnTheLatestVersion => 'Estás en la última versión';

  @override
  String get checking => 'Comprobando...';

  @override
  String get notCheckedYet => ' No comprobado aún.';

  @override
  String get checkToSee => ' Marcar para ver.';

  @override
  String get youHaveIgnoredThisUpdate => 'Has ignorado esta actualización.';

  @override
  String get unignoreCheckAgain => 'Designorar y comprobar de nuevo';

  @override
  String get checkForUpdatesNow => 'Comprobar actualizaciones ahora';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'La actualización a la versión $version está disponible';
  }

  @override
  String get downloadAndInstallUpdate => 'Descargar e instalar actualización';

  @override
  String get viewReleasePage => 'Ver página de lanzamiento';

  @override
  String get dataManagement => 'Gestión de datos';

  @override
  String get forceRescrapeAllData => 'Forzar reiniciar todos los datos';

  @override
  String
  get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'Advertencia: Este proceso puede tomar un tiempo muy largo y consumir datos significativos de la red. Utilizar con precaución.';

  @override
  String get rescrapingSeeDialog => 'Recuperando... Ver diálogo';

  @override
  String get forceRescrapeAllDataNow => 'Forzar Retirar Todos los Datos Ahora';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'Otro proceso de reasignación ya se está ejecutando.';

  @override
  String get clearingAllExistingData =>
      'Limpiando todos los datos existentes...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'Raspando todos los nombres de los reenvases (ase 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'páginas',
      one: 'Página',
    );
    return 'Raspando todos los nombres de los repacks 1/4): Página $page de $totalPages $_temp0';
  }

  @override
  String allRepackNamesScrapedPhase1(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'nombres',
      one: 'nombre',
      zero: 'nombres',
    );
    return 'Todos los nombres del paquete raspados. (¡$count $_temp0 Sube 1/4 Completado)';
  }

  @override
  String get scrapingDetailsForEveryRepackPhase2LongestPhase =>
      'Detalles de desguace para cada paquete de Reembolso de 2/4 - Fase más larga)...';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
    Object current,
    Object total,
  ) {
    return 'Detalles de raspado para cada paquete de 2/4): Repetir $current de $total';
  }

  @override
  String allRepackDetailsScrapedPhase2(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Repacks',
      one: '¡Repack',
      zero: 'Repacks',
    );
    return 'Todos los detalles del paquete son raspados. (¡$count $_temp0 procesados 2/4 Completos)';
  }

  @override
  String get rescrapingNewRepacksPhase3 => 'Recuperando nuevos repacks 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'Recubrimiento de nuevos mochileros 3/4): Página $current de $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'Nuevos reenvases. Sube 3/4 completado)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'Recuperando los paquetes populares (ase 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'Retrapando los mochileros populares: Objeto $current de $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'Repacks populares rediseñados. Sube 4/4 completado)';

  @override
  String get finalizing => 'Finalizando...';

  @override
  String get fullRescrapeCompletedSuccessfully =>
      'La rescrape completa se completó con éxito!';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'Error: $errorMessage. Proceso detenido.';
  }

  @override
  String get daily => 'Diario';

  @override
  String get weekly => 'Semanal';

  @override
  String get manual => 'Manual';

  @override
  String get onEveryStartup => 'En cada inicio';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'No se encontraron URLs en la configuración de réplica.';

  @override
  String get failedToProcessUnknownPlugin =>
      'Error al procesar (Plugin desconocido):';

  @override
  String get problemProcessingSomeLinks =>
      'Problema procesando algunos enlaces. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'Error al procesar uno o más enlaces. ';

  @override
  String filesAddedToDownloadManager(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'archivos',
      one: 'archivo',
      zero: 'archivos',
    );
    return '$count $_temp0 añadidos al administrador de descargas.';
  }

  @override
  String get downloadStarted => 'Descarga iniciada';

  @override
  String get ok => 'Ok';

  @override
  String get noFilesSelected => 'No hay archivos seleccionados';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'Por favor, seleccione uno o más archivos del árbol para descargar.';

  @override
  String get noFilesCouldBeRetrieved => 'No se han podido recuperar archivos.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
    Object processingError,
  ) {
    return 'Aviso: $processingError Algunos archivos pueden haber encontrado problemas.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'No se han encontrado archivos descargables para esta réplica.';

  @override
  String downloadFilesGame(Object Game) {
    return 'Descargar archivos: $Game';
  }

  @override
  String get close => 'Cerrar';

  @override
  String get downloadSelected => 'Descargar seleccionados';

  @override
  String get aboutGame => 'Acerca del juego';

  @override
  String get features => 'Características';

  @override
  String get selectDownloadOptions => 'Seleccionar opciones de descarga';

  @override
  String get downloadMethod => 'Método de descarga:';

  @override
  String get selectMethod => 'Seleccionar método';

  @override
  String get mirror => 'Mirror:';

  @override
  String get selectMirror => 'Seleccionar espejo';

  @override
  String get downloadLocation => 'Ubicación de descarga:';

  @override
  String get enterDownloadLocationOrBrowse =>
      'Introduce la ubicación de descarga o navega';

  @override
  String get downloadLocationEmpty => 'Ubicación de descarga vacía';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'Por favor, seleccione o introduzca una ubicación de descarga.';

  @override
  String get selectionIncomplete => 'Selección incompleta';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'Por favor, seleccione un método de descarga y un espejo.';

  @override
  String get next => 'Siguiente';

  @override
  String get download => 'Descargar';

  @override
  String get downloadComplete => '¡Descarga completada!';

  @override
  String get downloadPending => 'Descargar pendiente...';

  @override
  String get genres => 'Genres';

  @override
  String get company => 'Empresa';

  @override
  String get language => 'Idioma';

  @override
  String get originalSize => 'Tamaño original';

  @override
  String get repackSize => 'Tamaño del paquete';

  @override
  String get repackInformation => 'Información de Repetir';

  @override
  String screenshotsTitle(Object count) {
    return 'Screenshots ($count)';
  }

  @override
  String get errorLoadingImage => 'Error al cargar la imagen';

  @override
  String get noScreenshotsAvailable => 'No hay pantallas disponibles.';

  @override
  String get noGenresAvailable => 'Ningún género disponible';

  @override
  String get clear => 'Claro';

  @override
  String get filterByGenre => 'Filtrar por género';

  @override
  String get filter => 'Filtro';
}
