// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get success => 'Erfolg';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'Neue und beliebte Repacks wurden aufgehoben.';

  @override
  String get error => 'Fehler';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'Fehler beim Wiederherstellen der Daten: $errorMessage';
  }

  @override
  String get home => 'Zuhause';

  @override
  String get rescrapeNewPopular => 'Neu & Beliebt erneuern';

  @override
  String get newRepacks => 'Neue Repacks';

  @override
  String get popularRepacks => 'Beliebte Repacks';

  @override
  String get noCompletedGroupsToClear =>
      'Keine abgeschlossenen Gruppen zu löschen.';

  @override
  String get queued => 'Warteschlange';

  @override
  String get downloading => 'Herunterladen:';

  @override
  String get completed => 'Abgeschlossen';

  @override
  String get failed => 'Fehler';

  @override
  String get paused => 'Pausiert';

  @override
  String get canceled => 'Abgebrochen';

  @override
  String get dismiss => 'Verwerfen';

  @override
  String get confirmClear => 'Löschen bestätigen';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gruppen',
      one: 'Gruppe',
      zero: 'Gruppen',
    );
    return 'Bist du sicher, dass du $count abgeschlossenen Download entfernen möchtest $_temp0? Das wird auch Dateien von der Festplatte entfernen, wenn sie in dedizierten Unterordnern von der App verwaltet werden.';
  }

  @override
  String get clearCompleted => 'Erledigte löschen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String completedGroupsCleared(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Gruppen',
      one: 'Gruppe',
      zero: 'Gruppen',
    );
    return '$count abgeschlossen $_temp0 geleert.';
  }

  @override
  String get downloadManager => 'Download-Manager';

  @override
  String get maxConcurrent => 'Max. Gleichzeitigkeit';

  @override
  String get noActiveDownloads => 'Keine aktiven Downloads.';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'Downloads werden hier angezeigt, sobald sie hinzugefügt wurden.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'Alle Downloads in dieser Gruppe abbrechen';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'Sind Sie sicher, dass Sie alle Downloads in dieser Gruppe abbrechen und entfernen möchten?';

  @override
  String completedNumberFiles(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dateien',
      one: 'Datei',
      zero: 'Dateien',
    );
    return 'Abgeschlossene $count $_temp0';
  }

  @override
  String overallProgressFilesPercent(num count, Object percent) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dateien',
      one: 'Datei',
    );
    return 'Gesamt: $percent% ($count $_temp0)';
  }

  @override
  String noActiveTasks(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dateien',
      one: 'Datei',
    );
    return 'Keine aktiven Aufgaben oder Fortschritt nicht verfügbar ($count $_temp0)';
  }

  @override
  String cancelGroupName(Object groupName) {
    return 'Gruppe abbrechen: $groupName';
  }

  @override
  String get removeFromList => 'Aus Liste entfernen';

  @override
  String get resume => 'Fortsetzen';

  @override
  String get pause => 'Pause';

  @override
  String get errorTaskDataUnavailable =>
      'Fehler: Aufgabendaten nicht verfügbar';

  @override
  String get unknownFile => 'Unbekannte Datei';

  @override
  String get yesCancelGroup => 'Ja, Gruppe abbrechen';

  @override
  String get no => 'Nein';

  @override
  String get repackLibrary => 'Bibliothek neu packen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get unknown => 'Unbekannt';

  @override
  String get noReleaseNotesAvailable => 'Keine Versionshinweise verfügbar.';

  @override
  String get search => 'Suchen';

  @override
  String updateAvailable(Object version) {
    return 'Update verfügbar: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'Eine neue Version von FitFlutter ist verfügbar.';

  @override
  String get viewReleaseNotes => 'Versionshinweise anzeigen';

  @override
  String get releasePage => 'Release-Seite';

  @override
  String get later => 'Später';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get downloadsInProgress => 'Downloads in Bearbeitung';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'Beim Schließen der Anwendung werden alle aktiven Downloads abgebrochen. ';

  @override
  String get areYouSureYouWantToClose =>
      'Sind Sie sicher, dass Sie schließen möchten?';

  @override
  String get yesCloseCancel => 'Ja, schließen & abbrechen';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'Benutzer hat das Schließen gewählt; Downloads werden abgebrochen.';

  @override
  String get keepDownloading => 'Download fortsetzen';

  @override
  String get startingLibrarySync => 'Starte Bibliotheks-Sync...';

  @override
  String get fetchingAllRepackNames => 'Rufe alle Repacknamen ab...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'Seiten',
      one: 'Seite',
    );
    return 'Lade Namen: $page von $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails =>
      'Verschrotten fehlender Repackdetails...';

  @override
  String get thisMayTakeAWhile => 'Das kann eine Weile dauern.';

  @override
  String scrapingMissingRepackDetailsProgress(num current, num total) {
    String _temp0 = intl.Intl.pluralLogic(
      current,
      locale: localeName,
      other: 'Repacks',
      one: 'repack',
    );
    return 'Schrottende Details: $current/$total fehlen $_temp0';
  }

  @override
  String get repackLibrarySynchronized => 'Bibliothek neu laden.';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'Fehler beim Synchronisieren der Bibliothek: $errorMessage';
  }

  @override
  String get syncLibrary => 'Sync-Bibliothek';

  @override
  String get syncingLibrary => 'Synchronisiere Bibliothek...';

  @override
  String get noRepacksFoundInTheLibrary =>
      'Keine Repacks in der Bibliothek gefunden.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'Keine Repacks gefunden mit $search.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'Das Fenster ist zu schmal, um Elemente korrekt anzuzeigen.';

  @override
  String get pleaseResizeTheWindow => 'Bitte skalieren Sie das Fenster.';

  @override
  String get repackUrlIsNotAvailable => 'Repack-URL ist nicht verfügbar.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'URL konnte nicht gestartet werden: $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return 'Konnte nicht starten: $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return 'Ungültiges URL-Format: $url';
  }

  @override
  String get rescrapeDetails => 'Details wiederherstellen';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return 'Details für $title wurden erweitert und aktualisiert.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'Fehler beim Wiederherstellen der Details: $errorMessage';
  }

  @override
  String get errorRescraping => 'Fehler beim Wiederherstellen';

  @override
  String get openSourcePage => 'Open Source Seite';

  @override
  String noPopularNewRepacksFound(Object type) {
    return 'Keine $type Repacks gefunden.';
  }

  @override
  String get newest => 'neu';

  @override
  String get popular => 'populär';

  @override
  String get system => 'System';

  @override
  String get yellow => 'Gelb';

  @override
  String get orange => 'Orange';

  @override
  String get red => 'Rot';

  @override
  String get magenta => 'Magenta';

  @override
  String get purple => 'Lila';

  @override
  String get blue => 'Blau';

  @override
  String get teal => 'Türkis';

  @override
  String get green => 'Grün';

  @override
  String get confirmForceRescrape => 'Force-Rescrape bestätigen';

  @override
  String get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'Dies löscht ALLE lokal gespeicherten Repack-Daten und lädt alles aus der Quelle erneut herunter. ';

  @override
  String get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'Dieser Prozess kann sehr lange dauern und erhebliche Netzwerkdaten verbrauchen. Sind Sie sicher?';

  @override
  String get yesRescrapeAll => 'Ja, alle wiederherstellen';

  @override
  String get startingFullDataRescrape =>
      'Starte vollständige Daten-Rescrape...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'Alle Daten wurden erzwungen.';

  @override
  String errorMessage(Object error) {
    return 'Fehler: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'Fehler beim Erzwingen der Rescrape-Daten: $errorMessage';
  }

  @override
  String get forceRescrapingData => 'Rescraping-Daten erzwingen';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'Downloads & Installation';

  @override
  String get defaultDownloadPath => 'Standard-Downloadpfad';

  @override
  String get maxConcurrentDownloads => 'Max. gleichzeitige Downloads';

  @override
  String get automaticInstallation => 'Automatische Installation';

  @override
  String get enableAutoInstallAfterDownload =>
      'Auto-Installation nach dem Download aktivieren:';

  @override
  String get defaultInstallationPath => 'Standard-Installationspfad';

  @override
  String get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      'Wenn aktiviert, werden abgeschlossene Repacks versuchen, den angegebenen Pfad zu installieren.';

  @override
  String get appearance => 'Erscheinung';

  @override
  String get themeMode => 'Theme-Modus';

  @override
  String get navigationPaneDisplayMode => 'Anzeigemodus der Navigationsleiste';

  @override
  String get accentColor => 'Akzentfarbe';

  @override
  String get windowTransparency => 'Fenstertransparenz';

  @override
  String get local => 'Lokal';

  @override
  String get applicationUpdates => 'Anwendungs-Updates';

  @override
  String get updateCheckFrequency => 'Update-Prüffrequenz';

  @override
  String get currentAppVersion => 'Aktuelle App-Version:';

  @override
  String get loading => 'Wird geladen...';

  @override
  String get latestAvailableVersion => 'Letzte verfügbare Version:';

  @override
  String get youAreOnTheLatestVersion => 'Sie sind auf der neuesten Version';

  @override
  String get checking => 'Überprüfen...';

  @override
  String get notCheckedYet => ' Noch nicht überprüft.';

  @override
  String get checkToSee => ' Zum Anzeigen.';

  @override
  String get youHaveIgnoredThisUpdate => 'Sie haben dieses Update ignoriert.';

  @override
  String get unignoreCheckAgain => 'Nicht ignorieren & erneut prüfen';

  @override
  String get checkForUpdatesNow => 'Jetzt nach Updates suchen';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'Update auf Version $version ist verfügbar';
  }

  @override
  String get downloadAndInstallUpdate =>
      'Update herunterladen und installieren';

  @override
  String get viewReleasePage => 'Release-Seite anzeigen';

  @override
  String get dataManagement => 'Datenmanagement';

  @override
  String get forceRescrapeAllData => 'Alle Daten wiederherstellen';

  @override
  String get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'Warnung: Dieser Prozess kann sehr lange dauern und erhebliche Netzwerkdaten verbrauchen. Mit Vorsicht verwenden.';

  @override
  String get rescrapingSeeDialog => 'Rescraping... siehe Dialog';

  @override
  String get forceRescrapeAllDataNow => 'Jetzt alle Daten wiederherstellen';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'Ein weiterer Prozess läuft bereits.';

  @override
  String get clearingAllExistingData =>
      'Alle vorhandenen Daten werden gelöscht...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'Schrotten aller Repacknamen (Phase 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'Seiten',
      one: 'Seite',
    );
    return 'Schrotten aller Repacknamen (Phase 1/4): Seite $page von $totalPages $_temp0';
  }

  @override
  String allRepackNamesScrapedPhase1(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Namen',
      one: 'Name',
      zero: 'Namen',
    );
    return 'Alle Repacknamen sind verschrottet. ($count $_temp0 (Phase 1/4 Abgeschlossen)';
  }

  @override
  String get scrapingDetailsForEveryRepackPhase2LongestPhase =>
      'Details für jede Rettung (Phase 2/4 - Längste Phase)...';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
      Object current, Object total) {
    return 'Schrottdetails für jede Rettung (Phase 2/4): $current von $total neu packen';
  }

  @override
  String allRepackDetailsScrapedPhase2(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Repacks',
      one: 'repack',
      zero: 'Packt',
    );
    return 'Alle Rückholdetails sind verschrottet. ($count $_temp0 verarbeitet (Phase 2/4 Abgeschlossen)';
  }

  @override
  String get rescrapingNewRepacksPhase3 =>
      'Neue Repacks wiederherstellen (Phase 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'Wiederholen neuer Repacks (Phase 3/4): Seite $current von $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'Neue Repacks aufgehoben. (Phase 3/4 abgeschlossen)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'Wiederbelebung beliebter Repacks (Phase 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'Wiederbelebung beliebter Repacks (Phase 4/4): Item $current von $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'Beliebte Repacks aufgerollt. (Phase 4/4 Abgeschlossen)';

  @override
  String get finalizing => 'Fertigstellen...';

  @override
  String get fullRescrapeCompletedSuccessfully =>
      'Vollständige Rescrape erfolgreich abgeschlossen!';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'Fehler: $errorMessage. Prozess gestoppt.';
  }

  @override
  String get daily => 'Täglich';

  @override
  String get weekly => 'Wöchentlich';

  @override
  String get manual => 'Manuell';

  @override
  String get onEveryStartup => 'Bei jedem Start';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'Keine URLs in der Spiegel-Konfiguration gefunden.';

  @override
  String get failedToProcessUnknownPlugin =>
      'Verarbeitung fehlgeschlagen (Unbekanntes Plugin):';

  @override
  String get problemProcessingSomeLinks =>
      'Probleme beim Verarbeiten einiger Links. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'Fehler beim Verarbeiten eines oder mehrerer Links. ';

  @override
  String filesAddedToDownloadManager(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dateien',
      one: 'Datei',
      zero: 'Dateien',
    );
    return '$count $_temp0 zum Download-Manager hinzugefügt.';
  }

  @override
  String get downloadStarted => 'Download gestartet';

  @override
  String get ok => 'Ok';

  @override
  String get noFilesSelected => 'Keine Dateien ausgewählt';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'Bitte wählen Sie eine oder mehrere Dateien aus dem Baum zum Download.';

  @override
  String get noFilesCouldBeRetrieved =>
      'Es konnten keine Dateien abgerufen werden.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
      Object processingError) {
    return 'Hinweis: $processingError Einige Dateien sind auf Probleme gestoßen.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'Keine herunterladbaren Dateien für diesen Mirror gefunden.';

  @override
  String downloadFilesGame(Object Game) {
    return 'Dateien herunterladen: $Game';
  }

  @override
  String get close => 'Schließen';

  @override
  String get downloadSelected => 'Ausgewählte herunterladen';

  @override
  String get aboutGame => 'Über Spiel';

  @override
  String get features => 'Eigenschaften';

  @override
  String get selectDownloadOptions => 'Download-Optionen auswählen';

  @override
  String get downloadMethod => 'Downloadmethode:';

  @override
  String get selectMethod => 'Methode auswählen';

  @override
  String get mirror => 'Spiegel:';

  @override
  String get selectMirror => 'Spiegel auswählen';

  @override
  String get downloadLocation => 'Downloadort:';

  @override
  String get enterDownloadLocationOrBrowse =>
      'Download-Verzeichnis eingeben oder suchen';

  @override
  String get downloadLocationEmpty => 'Download-Verzeichnis leer';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'Bitte wählen Sie oder geben Sie einen Download-Ort ein.';

  @override
  String get selectionIncomplete => 'Auswahl unvollständig';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'Bitte wählen Sie eine Downloadmethode und einen Mirror.';

  @override
  String get next => 'Nächste';

  @override
  String get download => 'Download';

  @override
  String get downloadComplete => 'Download abgeschlossen!';

  @override
  String get downloadPending => 'Download ausstehend...';

  @override
  String get genres => 'Genres';

  @override
  String get company => 'Firma';

  @override
  String get language => 'Sprache';

  @override
  String get originalSize => 'Originalgröße';

  @override
  String get repackSize => 'Größe neu packen';

  @override
  String get repackInformation => 'Repack Informationen';

  @override
  String screenshotsTitle(Object count) {
    return 'Screenshots ($count)';
  }

  @override
  String get errorLoadingImage => 'Fehler beim Laden des Bildes';

  @override
  String get noScreenshotsAvailable => 'Keine Screenshots verfügbar.';

  @override
  String get noGenresAvailable => 'Keine Genres verfügbar';

  @override
  String get clear => 'Leeren';

  @override
  String get filterByGenre => 'Nach Genre filtern';

  @override
  String get filter => 'Filtern';
}
