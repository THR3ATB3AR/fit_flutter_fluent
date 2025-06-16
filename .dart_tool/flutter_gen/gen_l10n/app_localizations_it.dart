// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get success => 'Successo';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'I nuovi e popolari ripacchi sono stati rescraped.';

  @override
  String get error => 'Errore';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'Rescrape dati non riuscito: $errorMessage';
  }

  @override
  String get home => 'Home';

  @override
  String get rescrapeNewPopular => 'Rescrape Nuovo E Popolare';

  @override
  String get newRepacks => 'Nuovi Repacks';

  @override
  String get popularRepacks => 'Repacks Popolari';

  @override
  String get noCompletedGroupsToClear =>
      'Nessun gruppo completato da eliminare.';

  @override
  String get queued => 'Accodato';

  @override
  String get downloading => 'Scaricamento:';

  @override
  String get completed => 'Completato';

  @override
  String get failed => 'Fallito';

  @override
  String get paused => 'Pausa';

  @override
  String get canceled => 'Annullato';

  @override
  String get dismiss => 'Ignora';

  @override
  String get confirmClear => 'Conferma Pulizia';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'group',
      one: 'gruppo',
      zero: 'gruppi',
    );
    return 'Sei sicuro di voler rimuovere il download di $count completato $_temp0? Questo rimuoverà anche i file dal disco se sono in sottocartelle dedicate gestite dall\'app.';
  }

  @override
  String get clearCompleted => 'Pulisci Completato';

  @override
  String get cancel => 'Annulla';

  @override
  String completedGroupsCleared(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'gruppi',
      one: 'gruppo',
      zero: 'gruppi',
    );
    return '$count completato $_temp0 cancellato.';
  }

  @override
  String get downloadManager => 'Gestore Download';

  @override
  String get maxConcurrent => 'Concorrente Massima';

  @override
  String get noActiveDownloads => 'Nessun download attivo.';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'I download appariranno qui una volta aggiunti.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'Annulla tutti gli scaricamenti in questo gruppo';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'Sei sicuro di voler annullare tutti i download di questo gruppo e rimuoverli?';

  @override
  String completedNumberFiles(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'file',
      one: 'file',
      zero: 'file',
    );
    return 'Completato $count $_temp0';
  }

  @override
  String overallProgressFilesPercent(num count, Object percent) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'file',
      one: 'file',
    );
    return 'Complessivo: $percent% ($count $_temp0';
  }

  @override
  String noActiveTasks(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'file',
      one: 'file',
    );
    return 'Nessuna attività attiva o progresso non disponibile ($count $_temp0';
  }

  @override
  String cancelGroupName(Object groupName) {
    return 'Annulla Gruppo: $groupName';
  }

  @override
  String get removeFromList => 'Rimuovi dalla lista';

  @override
  String get resume => 'Riprendi';

  @override
  String get pause => 'Pausa';

  @override
  String get errorTaskDataUnavailable =>
      'Errore: dati attività non disponibili';

  @override
  String get unknownFile => 'File Sconosciuto';

  @override
  String get yesCancelGroup => 'Sì, Annulla Gruppo';

  @override
  String get no => 'No';

  @override
  String get repackLibrary => 'Libreria Repack';

  @override
  String get settings => 'Impostazioni';

  @override
  String get unknown => 'Sconosciuto';

  @override
  String get noReleaseNotesAvailable => 'Nessuna nota di rilascio disponibile.';

  @override
  String get search => 'Cerca';

  @override
  String updateAvailable(Object version) {
    return 'Aggiornamento Disponibile: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'È disponibile una nuova versione di FitFlutter.';

  @override
  String get viewReleaseNotes => 'Visualizza Note Di Rilascio';

  @override
  String get releasePage => 'Pagina Di Rilascio';

  @override
  String get later => 'Dopo';

  @override
  String get upgrade => 'Aggiorna';

  @override
  String get downloadsInProgress => 'Download in corso';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'Chiudere l\'applicazione annullerà tutti i download attivi. ';

  @override
  String get areYouSureYouWantToClose => 'Sei sicuro di voler chiudere?';

  @override
  String get yesCloseCancel => 'Sì, Chiudi E Annulla';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'L\'utente ha scelto di chiudere; annullare i download.';

  @override
  String get keepDownloading => 'Continua A Scaricamento';

  @override
  String get startingLibrarySync => 'Avvio sincronizzazione libreria...';

  @override
  String get fetchingAllRepackNames => 'Recupero di tutti i nomi del repack...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'pagine',
      one: 'pagina',
    );
    return 'Recupero nomi: $page di $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails =>
      'Scraping mancanti rimpacco dettagli...';

  @override
  String get thisMayTakeAWhile => 'Questo può richiedere un po\'.';

  @override
  String scrapingMissingRepackDetailsProgress(num current, num total) {
    String _temp0 = intl.Intl.pluralLogic(
      current,
      locale: localeName,
      other: 'repack',
      one: 'ripack',
    );
    return 'Scraping details: $current/$total mancante $_temp0';
  }

  @override
  String get repackLibrarySynchronized => 'Libreria di Repack sincronizzata.';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'Sincronizzazione libreria non riuscita: $errorMessage';
  }

  @override
  String get syncLibrary => 'Sincronizza Libreria';

  @override
  String get syncingLibrary => 'Sincronizzazione Libreria...';

  @override
  String get noRepacksFoundInTheLibrary =>
      'Nessun repack trovato nella libreria.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'No repacks found matching $search.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'La finestra è troppo stretta per visualizzare correttamente gli elementi.';

  @override
  String get pleaseResizeTheWindow => 'Ridimensiona la finestra, per favore.';

  @override
  String get repackUrlIsNotAvailable => 'L\'URL Repack non è disponibile.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'Impossibile avviare l\'URL: $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return 'Impossibile lanciare: $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return 'Formato URL non valido: $url';
  }

  @override
  String get rescrapeDetails => 'Rescrape Dettagli';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return 'I dettagli per $title sono stati rescraped e aggiornati.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'Rescrape dettagli non riuscito: $errorMessage';
  }

  @override
  String get errorRescraping => 'Rielaborazione Degli Errori';

  @override
  String get openSourcePage => 'Pagina Open Source';

  @override
  String noPopularNewRepacksFound(Object type) {
    return 'No $type repacks found.';
  }

  @override
  String get newest => 'nuovo';

  @override
  String get popular => 'popolare';

  @override
  String get system => 'Sistema';

  @override
  String get yellow => 'Giallo';

  @override
  String get orange => 'Arancione';

  @override
  String get red => 'Rosso';

  @override
  String get magenta => 'Magenta';

  @override
  String get purple => 'Viola';

  @override
  String get blue => 'Blu';

  @override
  String get teal => 'Teal';

  @override
  String get green => 'Verde';

  @override
  String get confirmForceRescrape => 'Conferma Rescrape Forza';

  @override
  String get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'Questo eliminerà TUTTI i dati di repack memorizzati localmente e ri-scaricare tutto dalla sorgente. ';

  @override
  String get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'Questo processo può richiedere molto tempo e consumare dati di rete significativi. Sei sicuro?';

  @override
  String get yesRescrapeAll => 'Sì, Rescrape Tutto';

  @override
  String get startingFullDataRescrape => 'Avvio completo rescrape...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'Tutti i dati sono stati ripresi con forza.';

  @override
  String errorMessage(Object error) {
    return 'Errore: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'Impossibile forzare la rescrape dati: $errorMessage';
  }

  @override
  String get forceRescrapingData => 'Forza Rescraping Dati';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'Download E Installazione';

  @override
  String get defaultDownloadPath => 'Percorso Di Download Predefinito';

  @override
  String get maxConcurrentDownloads => 'Download Concorrenti Massimi';

  @override
  String get automaticInstallation => 'Installazione Automatica';

  @override
  String get enableAutoInstallAfterDownload =>
      'Abilitare l\'installazione automatica dopo il download:';

  @override
  String get defaultInstallationPath => 'Percorso Di Installazione Predefinito';

  @override
  String get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      'Se abilitato, i pacchetti completati tenteranno di installare nel percorso specificato.';

  @override
  String get appearance => 'Aspetto';

  @override
  String get themeMode => 'Modalità tema';

  @override
  String get navigationPaneDisplayMode =>
      'Modalità Visualizzazione Riquadro Di Navigazione';

  @override
  String get accentColor => 'Colore Accento';

  @override
  String get windowTransparency => 'Trasparenza Finestra';

  @override
  String get local => 'Localizzazione';

  @override
  String get applicationUpdates => 'Aggiornamenti Applicazione';

  @override
  String get updateCheckFrequency => 'Aggiorna Frequenza Di Controllo';

  @override
  String get currentAppVersion => 'Versione Attuale Dell\'App:';

  @override
  String get loading => 'Caricamento...';

  @override
  String get latestAvailableVersion => 'Ultima Versione Disponibile:';

  @override
  String get youAreOnTheLatestVersion => 'Sei all\'ultima versione';

  @override
  String get checking => 'Controllo...';

  @override
  String get notCheckedYet => ' Non ancora controllato.';

  @override
  String get checkToSee => ' Controlla per vedere.';

  @override
  String get youHaveIgnoredThisUpdate => 'Hai ignorato questo aggiornamento.';

  @override
  String get unignoreCheckAgain => 'Ignora E Controlla Ancora';

  @override
  String get checkForUpdatesNow => 'Controlla aggiornamenti ora';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'L\'aggiornamento alla versione $version è disponibile';
  }

  @override
  String get downloadAndInstallUpdate => 'Scarica e installa l\'aggiornamento';

  @override
  String get viewReleasePage => 'Visualizza Pagina Di Rilascio';

  @override
  String get dataManagement => 'Gestione Dei Dati';

  @override
  String get forceRescrapeAllData => 'Forza Rescrape Tutti I Dati';

  @override
  String get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'Attenzione: Questo processo può richiedere molto tempo e consumare dati di rete significativi. Utilizzare con cautela.';

  @override
  String get rescrapingSeeDialog => 'Rescraping... Vedi Finestra';

  @override
  String get forceRescrapeAllDataNow => 'Forza La Rescrape Tutti I Dati Ora';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'Un altro processo di rescraping è già in esecuzione.';

  @override
  String get clearingAllExistingData =>
      'Cancellazione di tutti i dati esistenti...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'Scraping all repack names (Phase 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
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
      other: 'nomi',
      one: 'nome',
      zero: 'nomi',
    );
    return 'Tutti i nomi del repack sono stati eliminati. ($count $_temp0 (Fase 1/4 Completo)';
  }

  @override
  String get scrapingDetailsForEveryRepackPhase2LongestPhase =>
      'Dettagli per ogni confezione (fase 2/4 - Fase più lunga)...';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
      Object current, Object total) {
    return 'Dettagli per ogni confezione (fase 2/4): Repack $current di $total';
  }

  @override
  String allRepackDetailsScrapedPhase2(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'repack',
      one: 'repack',
      zero: 'repack',
    );
    return 'Tutti i dettagli del repack sono stati rimossi. ($count $_temp0 processato (fase 2/4 Completo)';
  }

  @override
  String get rescrapingNewRepacksPhase3 =>
      'Rescraping nuovi pacchetti (Fase 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'Rescraping new repack (Fase 3/4): Pagina $current di $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'Nuovi repack rescraped. (Fase 3/4 Completo)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'Rescraping repacks popolari (Fase 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'Rescraping popular repacks (Phase 4/4): Item $current of $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'Repacks popolari rescraped. (Fase 4/4 Completo)';

  @override
  String get finalizing => 'Completamento...';

  @override
  String get fullRescrapeCompletedSuccessfully =>
      'Rescrape completate con successo!';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'Errore: $errorMessage. Processo interrotto.';
  }

  @override
  String get daily => 'Giornaliero';

  @override
  String get weekly => 'Settimanale';

  @override
  String get manual => 'Manuale';

  @override
  String get onEveryStartup => 'Ad Ogni Avvio';

  @override
  String get light => 'Chiaro';

  @override
  String get dark => 'Scuro';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'Nessun URL trovato nella configurazione del mirror.';

  @override
  String get failedToProcessUnknownPlugin =>
      'Elaborazione (Plugin sconosciuto) non riuscita:';

  @override
  String get problemProcessingSomeLinks =>
      'Problema nell\'elaborazione di alcuni link. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'Errore nell\'elaborazione di uno o più collegamenti. ';

  @override
  String filesAddedToDownloadManager(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'file',
      one: 'file',
      zero: 'file',
    );
    return '$count $_temp0 aggiunto al gestore di download.';
  }

  @override
  String get downloadStarted => 'Download Avviato';

  @override
  String get ok => 'OK';

  @override
  String get noFilesSelected => 'Nessun File Selezionato';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'Selezionare uno o più file dall\'albero da scaricare.';

  @override
  String get noFilesCouldBeRetrieved =>
      'Non è stato possibile recuperare alcun file.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
      Object processingError) {
    return 'Avviso: $processingError Alcuni file potrebbero aver incontrato problemi.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'Nessun file scaricabile trovato per questo mirror.';

  @override
  String downloadFilesGame(Object Game) {
    return 'Scarica File: $Game';
  }

  @override
  String get close => 'Chiudi';

  @override
  String get downloadSelected => 'Scarica Selezionato';

  @override
  String get aboutGame => 'Informazioni sul gioco';

  @override
  String get features => 'Caratteristiche';

  @override
  String get selectDownloadOptions => 'Selezionare le opzioni di download';

  @override
  String get downloadMethod => 'Metodo Di download:';

  @override
  String get selectMethod => 'Seleziona metodo';

  @override
  String get mirror => 'Specchio:';

  @override
  String get selectMirror => 'Seleziona specchio';

  @override
  String get downloadLocation => 'Posizione Di Download:';

  @override
  String get enterDownloadLocationOrBrowse =>
      'Inserisci la posizione del download o sfoglia';

  @override
  String get downloadLocationEmpty => 'Scarica Posizione Vuota';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'Seleziona o inserisci una posizione di download.';

  @override
  String get selectionIncomplete => 'Selezione Incompleta';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'Seleziona un metodo di download e uno mirror.';

  @override
  String get next => 'Successivo';

  @override
  String get download => 'Scarica';

  @override
  String get downloadComplete => 'Download completato!';

  @override
  String get downloadPending => 'Download in attesa...';

  @override
  String get genres => 'Genres';

  @override
  String get company => 'Società';

  @override
  String get language => 'Lingua';

  @override
  String get originalSize => 'Dimensione Originale';

  @override
  String get repackSize => 'Dimensione Repack';

  @override
  String get repackInformation => 'Informazioni Repack';

  @override
  String screenshotsTitle(Object count) {
    return 'Screenshots ($count)';
  }

  @override
  String get errorLoadingImage => 'Errore nel caricamento dell\'immagine';

  @override
  String get noScreenshotsAvailable => 'Nessuna schermata disponibile.';

  @override
  String get noGenresAvailable => 'Nessun genere disponibile';

  @override
  String get clear => 'Pulisci';

  @override
  String get filterByGenre => 'Filtra per genere';

  @override
  String get filter => 'Filtro';
}
