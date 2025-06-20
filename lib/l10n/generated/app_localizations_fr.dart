// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get success => 'Succès';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'De nouveaux repacks et populaires ont été remaniés.';

  @override
  String get error => 'Erreur';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'Échec de la refonte des données : $errorMessage';
  }

  @override
  String get home => 'Domicile';

  @override
  String get rescrapeNewPopular => 'Rescrape les Nouveaux & Populaires';

  @override
  String get newRepacks => 'Nouveaux packs';

  @override
  String get popularRepacks => 'Repacks populaires';

  @override
  String get noCompletedGroupsToClear => 'Aucun groupe à effacer.';

  @override
  String get queued => 'En file d\'attente';

  @override
  String get downloading => 'Téléchargement:';

  @override
  String get completed => 'Terminé';

  @override
  String get failed => 'Echoué';

  @override
  String get paused => 'En pause';

  @override
  String get canceled => 'Annulé';

  @override
  String get dismiss => 'Refuser';

  @override
  String get confirmClear => 'Confirmer la suppression';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'groupes',
      one: 'groupe',
      zero: 'groupes',
    );
    return 'Êtes-vous sûr de vouloir supprimer $count téléchargement terminé $_temp0? Cela supprimera également les fichiers du disque s\'ils sont dans des sous-dossiers dédiés gérés par l\'application.';
  }

  @override
  String get clearCompleted => 'Effacement terminé';

  @override
  String get cancel => 'Abandonner';

  @override
  String completedGroupsCleared(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'groupes',
      one: 'groupe',
      zero: 'groupes',
    );
    return '$count a terminé $_temp0 nettoyé.';
  }

  @override
  String get downloadManager => 'Gestionnaire de téléchargement';

  @override
  String get maxConcurrent => 'Concurrent max';

  @override
  String get noActiveDownloads => 'Aucun téléchargement actif.';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'Les téléchargements apparaîtront ici une fois ajoutés.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'Annuler tous les téléchargements de ce groupe';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'Êtes-vous sûr de vouloir annuler tous les téléchargements de ce groupe et les supprimer ?';

  @override
  String completedNumberFiles(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'fichiers',
      one: 'fichier',
      zero: 'fichiers',
    );
    return '$count $_temp0';
  }

  @override
  String overallProgressFilesPercent(num count, Object percent) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'fichiers',
      one: 'fichier',
    );
    return 'Au total : $percent% ($count $_temp0)';
  }

  @override
  String noActiveTasks(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'fichiers',
      one: 'fichier',
    );
    return 'Aucune tâche active ou progression indisponible ($count $_temp0)';
  }

  @override
  String cancelGroupName(Object groupName) {
    return 'Annuler le groupe: $groupName';
  }

  @override
  String get removeFromList => 'Retirer de la liste';

  @override
  String get resume => 'Reprendre';

  @override
  String get pause => 'Mettre en pause';

  @override
  String get errorTaskDataUnavailable =>
      'Erreur: Données de la tâche indisponibles';

  @override
  String get unknownFile => 'Fichier inconnu';

  @override
  String get yesCancelGroup => 'Oui, annuler le groupe';

  @override
  String get no => 'Non';

  @override
  String get repackLibrary => 'Bibliothèque de Repack';

  @override
  String get settings => 'Réglages';

  @override
  String get unknown => 'Inconnu';

  @override
  String get noReleaseNotesAvailable =>
      'Aucune note de publication disponible.';

  @override
  String get search => 'Chercher';

  @override
  String updateAvailable(Object version) {
    return 'Mise à jour disponible: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'Une nouvelle version de FitFlutter est disponible.';

  @override
  String get viewReleaseNotes => 'Voir les notes de publication';

  @override
  String get releasePage => 'Page de publication';

  @override
  String get later => 'Plus tard';

  @override
  String get upgrade => 'Mise à jour';

  @override
  String get downloadsInProgress => 'Téléchargements en cours';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'La fermeture de l\'application annulera tous les téléchargements en cours. ';

  @override
  String get areYouSureYouWantToClose => 'Êtes-vous sûr de vouloir fermer?';

  @override
  String get yesCloseCancel => 'Oui, fermer et annuler';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'L\'utilisateur a choisi de fermer; annulation des téléchargements.';

  @override
  String get keepDownloading => 'En cours de téléchargement';

  @override
  String get startingLibrarySync =>
      'Démarrage de la synchronisation de la bibliothèque...';

  @override
  String get fetchingAllRepackNames =>
      'Récupération de tous les noms des réparations...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'pages',
      one: 'page',
    );
    return 'Récupération des noms : $page de $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails =>
      'Il manque des détails sur les réparations...';

  @override
  String get thisMayTakeAWhile => 'Cela peut prendre un certain temps.';

  @override
  String scrapingMissingRepackDetailsProgress(num current, num total) {
    String _temp0 = intl.Intl.pluralLogic(
      current,
      locale: localeName,
      other: 'Repose',
      one: 'repack',
    );
    return 'Détails de crapulement : $current/$total manquant $_temp0';
  }

  @override
  String get repackLibrarySynchronized =>
      'Librairie de réemballage synchronisée';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'Échec de la synchronisation de la bibliothèque : $errorMessage';
  }

  @override
  String get syncLibrary => 'Synchroniser la bibliothèque';

  @override
  String get syncingLibrary => 'Synchronisation de la bibliothèque...';

  @override
  String get noRepacksFoundInTheLibrary =>
      'Aucun dépôt trouvé dans la bibliothèque.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'Aucun dépôt trouvé correspondant à $search.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'La fenêtre est trop étroite pour afficher les éléments correctement.';

  @override
  String get pleaseResizeTheWindow => 'Veuillez redimensionner la fenêtre.';

  @override
  String get repackUrlIsNotAvailable =>
      'L\'URL du repack n\'est pas disponible.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'Impossible de lancer l\'URL : $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return 'Impossible de lancer : $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return 'Format d\'URL invalide : $url';
  }

  @override
  String get rescrapeDetails => 'Détails du Rescrape';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return 'Les détails pour $title ont été remaniés et mis à jour.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'Échec de la refonte des détails : $errorMessage';
  }

  @override
  String get errorRescraping => 'Erreur de récupération';

  @override
  String get openSourcePage => 'Page Open Source';

  @override
  String noPopularNewRepacksFound(Object type) {
    return 'Aucun dépôt $type trouvé.';
  }

  @override
  String get newest => 'Nouveau';

  @override
  String get popular => 'populaire';

  @override
  String get system => 'Système';

  @override
  String get yellow => 'Jaune';

  @override
  String get orange => 'Orange';

  @override
  String get red => 'Rouge';

  @override
  String get magenta => 'Magenta';

  @override
  String get purple => 'Violet';

  @override
  String get blue => 'Bleu';

  @override
  String get teal => 'Turquoise';

  @override
  String get green => 'Vert';

  @override
  String get confirmForceRescrape => 'Confirmer le remaniement de la force';

  @override
  String
  get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'Ceci supprimera TOUTES les données de repack stockées localement et retéléchargera tout depuis la source. ';

  @override
  String
  get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'Ce processus peut prendre beaucoup de temps et consommer des données importantes sur le réseau. Êtes-vous sûr?';

  @override
  String get yesRescrapeAll => 'Oui, tout redessiner';

  @override
  String get startingFullDataRescrape =>
      'Démarrage du remaniement complet des données...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'Toutes les données ont été remaniées avec force.';

  @override
  String errorMessage(Object error) {
    return 'Erreur: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'Impossible de forcer la refonte des données : $errorMessage';
  }

  @override
  String get forceRescrapingData => 'Forcer le remaniement des données';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'Téléchargements & Installation';

  @override
  String get defaultDownloadPath => 'Chemin de téléchargement par défaut';

  @override
  String get maxConcurrentDownloads =>
      'Nombre maximum de téléchargements simultanés';

  @override
  String get automaticInstallation => 'Installation automatique';

  @override
  String get enableAutoInstallAfterDownload =>
      'Activer l’installation automatique après le téléchargement:';

  @override
  String get defaultInstallationPath => 'Chemin par défaut de l\'installation';

  @override
  String
  get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      'Lorsque cette option est activée, les recharges terminées essaieront d\'installer le chemin d\'accès spécifié.';

  @override
  String get appearance => 'Apparence';

  @override
  String get themeMode => 'Mode thème';

  @override
  String get navigationPaneDisplayMode =>
      'Mode d\'affichage du volet de navigation';

  @override
  String get accentColor => 'Couleur d\'accentuation';

  @override
  String get windowTransparency => 'Transparence de fenêtre';

  @override
  String get local => 'Locale';

  @override
  String get applicationUpdates => 'Mises à jour de l\'application';

  @override
  String get updateCheckFrequency =>
      'Fréquence de vérification des mises à jour';

  @override
  String get currentAppVersion => 'Version actuelle de l\'application:';

  @override
  String get loading => 'Chargement en cours...';

  @override
  String get latestAvailableVersion => 'Dernière version disponible :';

  @override
  String get youAreOnTheLatestVersion => 'Vous êtes sur la dernière version';

  @override
  String get checking => 'Vérification...';

  @override
  String get notCheckedYet => ' Pas encore vérifié.';

  @override
  String get checkToSee => ' Vérifiez pour voir.';

  @override
  String get youHaveIgnoredThisUpdate => 'Vous avez ignoré cette mise à jour.';

  @override
  String get unignoreCheckAgain => 'Déconnecter et vérifier à nouveau';

  @override
  String get checkForUpdatesNow => 'Vérifier les mises à jour maintenant';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'Mise à jour vers la version $version est disponible';
  }

  @override
  String get downloadAndInstallUpdate =>
      'Télécharger et installer la mise à jour';

  @override
  String get viewReleasePage => 'Voir la page de publication';

  @override
  String get dataManagement => 'Gestion des données';

  @override
  String get forceRescrapeAllData =>
      'Forcer le remaniement de toutes les données';

  @override
  String
  get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'Attention : Ce processus peut prendre beaucoup de temps et consommer des données réseau significatives. À utiliser avec prudence.';

  @override
  String get rescrapingSeeDialog => 'Rembobinage... Voir Dialogue';

  @override
  String get forceRescrapeAllDataNow =>
      'Forcer le remaniement de toutes les données maintenant';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'Un autre processus de récupération est déjà en cours d\'exécution.';

  @override
  String get clearingAllExistingData =>
      'Effacement de toutes les données existantes...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'Récupération de tous les noms de repack (Phase 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'pages',
      one: 'page',
    );
    return 'Détruire tous les noms de repack (Phase 1/4): Page $page de $totalPages $_temp0';
  }

  @override
  String allRepackNamesScrapedPhase1(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'noms',
      one: 'nom',
      zero: 'noms',
    );
    return 'Tous les noms de réparation ont été effrayés. ($count $_temp0 (Phase 1/4 terminé)';
  }

  @override
  String get scrapingDetailsForEveryRepackPhase2LongestPhase =>
      'Des détails pour chaque réparation (Phase 2/4 - Phase la plus longue)...';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
    Object current,
    Object total,
  ) {
    return 'Détails de débordement pour chaque dépôt (Phase 2/4): Reconditionnez $current de $total';
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
    return 'Tous les détails de la réparation ont été arrachés. ($count $_temp0 traités (Phase 2/4 complet)';
  }

  @override
  String get rescrapingNewRepacksPhase3 =>
      'Rescraping new repacks (Phase 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'Relâcher de nouveaux repacks (Phase 3/4): Page $current de $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'Nouvelles réparations refaites. (Phase 3/4 terminée)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'Rescraping popular repacks (Phase 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'Relaping popular repacks (Phase 4/4): Item $current of $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'Repôts populaires remaniés. (Phase 4/4 terminé)';

  @override
  String get finalizing => 'Finalisation...';

  @override
  String get fullRescrapeCompletedSuccessfully =>
      'Restaure complète terminée avec succès !';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'Erreur: $errorMessage. Processus arrêté.';
  }

  @override
  String get daily => 'Tous les jours';

  @override
  String get weekly => 'Hebdomadaire';

  @override
  String get manual => 'Manuelle';

  @override
  String get onEveryStartup => 'Au démarrage';

  @override
  String get light => 'Lumière';

  @override
  String get dark => 'Sombre';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'Aucune URL trouvée dans la configuration du miroir.';

  @override
  String get failedToProcessUnknownPlugin =>
      'Impossible de traiter (plugin inconnu) :';

  @override
  String get problemProcessingSomeLinks =>
      'Problème lors du traitement de certains liens. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'Erreur lors du traitement d\'un ou plusieurs liens. ';

  @override
  String filesAddedToDownloadManager(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'fichiers',
      one: 'fichier',
      zero: 'fichiers',
    );
    return '$count $_temp0 ajoutés au gestionnaire de téléchargements.';
  }

  @override
  String get downloadStarted => 'Téléchargement démarré';

  @override
  String get ok => 'Ok';

  @override
  String get noFilesSelected => 'Aucun fichier sélectionné';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'Veuillez sélectionner un ou plusieurs fichiers de l\'arborescence à télécharger.';

  @override
  String get noFilesCouldBeRetrieved => 'Aucun fichier n\'a pu être récupéré.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
    Object processingError,
  ) {
    return 'Notice: $processingError Some files may have encountered issues.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'Aucun fichier téléchargeable trouvé pour ce miroir.';

  @override
  String downloadFilesGame(Object Game) {
    return 'Télécharger les fichiers : $Game';
  }

  @override
  String get close => 'Fermer';

  @override
  String get downloadSelected => 'Télécharger la sélection';

  @override
  String get aboutGame => 'A propos du jeu';

  @override
  String get features => 'Fonctionnalités';

  @override
  String get selectDownloadOptions =>
      'Sélectionnez les options de téléchargement';

  @override
  String get downloadMethod => 'Méthode de téléchargement :';

  @override
  String get selectMethod => 'Sélectionnez une méthode';

  @override
  String get mirror => 'Miroir :';

  @override
  String get selectMirror => 'Sélectionner le miroir';

  @override
  String get downloadLocation => 'Lieu de téléchargement :';

  @override
  String get enterDownloadLocationOrBrowse =>
      'Entrez l\'emplacement de téléchargement ou parcourez';

  @override
  String get downloadLocationEmpty => 'Emplacement de téléchargement vide';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'Veuillez sélectionner ou entrer un emplacement de téléchargement.';

  @override
  String get selectionIncomplete => 'Sélection incomplète';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'Veuillez sélectionner une méthode de téléchargement et un miroir.';

  @override
  String get next => 'Suivant';

  @override
  String get download => 'Télécharger';

  @override
  String get downloadComplete => 'Téléchargement terminé !';

  @override
  String get downloadPending => 'Téléchargement en attente...';

  @override
  String get genres => 'Genres';

  @override
  String get company => 'Entreprise';

  @override
  String get language => 'Langue';

  @override
  String get originalSize => 'Taille originale';

  @override
  String get repackSize => 'Taille du Repack';

  @override
  String get repackInformation => 'Informations sur le Repack';

  @override
  String screenshotsTitle(Object count) {
    return 'Screenshots ($count)';
  }

  @override
  String get errorLoadingImage => 'Erreur lors du chargement de l\'image';

  @override
  String get noScreenshotsAvailable => 'Aucune capture d\'écran disponible.';

  @override
  String get noGenresAvailable => 'Aucun genre disponible';

  @override
  String get clear => 'Nettoyer';

  @override
  String get filterByGenre => 'Filtrer par genre';

  @override
  String get filter => 'Filtre';

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
