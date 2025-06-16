// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get success => 'Sucesso';

  @override
  String get newAndPopularRepacksHaveBeenRescraped =>
      'Novos e novos representantes populares foram resgatados.';

  @override
  String get error => 'ERRO';

  @override
  String failedToRescrapeData(Object errorMessage) {
    return 'Falha ao rescrape dados: $errorMessage';
  }

  @override
  String get home => 'Residencial';

  @override
  String get rescrapeNewPopular => 'Rescrape Novo e Popular';

  @override
  String get newRepacks => 'Novos Retratos';

  @override
  String get popularRepacks => 'Reforços Populares';

  @override
  String get noCompletedGroupsToClear => 'Não há grupos completos para limpar.';

  @override
  String get queued => 'Enfileirado';

  @override
  String get downloading => 'Baixando:';

  @override
  String get completed => 'Concluído';

  @override
  String get failed => 'Falhou';

  @override
  String get paused => 'Pausado';

  @override
  String get canceled => 'Cancelado';

  @override
  String get dismiss => 'Descartar';

  @override
  String get confirmClear => 'Confirmar limpeza';

  @override
  String confirmRemoveDownloadGroups(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'grupos',
      one: 'grupo',
      zero: 'Grupos',
    );
    return 'Tem certeza de que deseja remover o download de $count completo $_temp0? Isto também removerá os arquivos do disco se estiverem em subpastas dedicadas gerenciadas pelo app.';
  }

  @override
  String get clearCompleted => 'Limpar Concluídos';

  @override
  String get cancel => 'cancelar';

  @override
  String completedGroupsCleared(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'grupos',
      one: 'grupo',
      zero: 'Agrupa',
    );
    return '$count completou $_temp0 removido.';
  }

  @override
  String get downloadManager => 'Gerenciador de Transferências';

  @override
  String get maxConcurrent => 'Máximo de corrente';

  @override
  String get noActiveDownloads => 'Nenhum download ativo.';

  @override
  String get downloadsWillAppearHereOnceAdded =>
      'Os downloads aparecerão aqui uma vez adicionados.';

  @override
  String get cancelAllDownloadsInThisGroup =>
      'Cancelar todos os downloads neste grupo';

  @override
  String get areYouSureYouWantToCancelAllDownloadsInThisGroupAndRemoveThem =>
      'Tem certeza que deseja cancelar todos os downloads neste grupo e removê-los?';

  @override
  String completedNumberFiles(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'arquivos',
      one: 'arquivo',
      zero: 'Arquivos',
    );
    return 'Completou $count $_temp0';
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
      other: 'arquivos',
      one: 'arquivo',
    );
    return 'Não há tarefas ativas ou progresso indisponível ($count $_temp0)';
  }

  @override
  String cancelGroupName(Object groupName) {
    return 'Cancelar Grupo: $groupName';
  }

  @override
  String get removeFromList => 'Remover da lista';

  @override
  String get resume => 'Retomar';

  @override
  String get pause => 'Suspender';

  @override
  String get errorTaskDataUnavailable => 'Erro: Dados da tarefa indisponíveis';

  @override
  String get unknownFile => 'Arquivo Desconhecido';

  @override
  String get yesCancelGroup => 'Sim, Cancelar Grupo';

  @override
  String get no => 'Não';

  @override
  String get repackLibrary => 'Biblioteca de Recompactar';

  @override
  String get settings => 'Confirgurações';

  @override
  String get unknown => 'Desconhecido';

  @override
  String get noReleaseNotesAvailable => 'Nenhuma nota de versão disponível.';

  @override
  String get search => 'Pesquisa';

  @override
  String updateAvailable(Object version) {
    return 'Atualização Disponível: $version';
  }

  @override
  String get aNewVersionOfFitflutterIsAvailable =>
      'Está disponível uma nova versão do FitFlutter.';

  @override
  String get viewReleaseNotes => 'Ver notas de versão';

  @override
  String get releasePage => 'Página de Lançamento';

  @override
  String get later => 'Mais tarde';

  @override
  String get upgrade => 'PRO';

  @override
  String get downloadsInProgress => 'Downloads em andamento';

  @override
  String get closingTheApplicationWillCancelAllActiveDownloads =>
      'Fechar o aplicativo irá cancelar todos os downloads ativos. ';

  @override
  String get areYouSureYouWantToClose => 'Tem certeza de que deseja fechar?';

  @override
  String get yesCloseCancel => 'Sim, Fechar e Cancelar';

  @override
  String get userChoseToCloseCancellingDownloads =>
      'Usuário escolheu fechar; cancelando downloads.';

  @override
  String get keepDownloading => 'Continuar Baixando';

  @override
  String get startingLibrarySync => 'Iniciando sincronização de biblioteca...';

  @override
  String get fetchingAllRepackNames => 'Buscando todos os nomes dos repacks...';

  @override
  String fetchingNamesPages(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'páginas',
      one: 'Página',
    );
    return 'Buscando nomes: $page de $totalPages $_temp0';
  }

  @override
  String get scrapingMissingRepackDetails =>
      'Scraping detalhes dos répteis ausentes...';

  @override
  String get thisMayTakeAWhile => 'Isso pode demorar um pouco.';

  @override
  String scrapingMissingRepackDetailsProgress(num current, num total) {
    String _temp0 = intl.Intl.pluralLogic(
      current,
      locale: localeName,
      other: 'repack',
      one: 'Rep',
    );
    return 'Detalhe do Scrap: $current/$total faltando $_temp0';
  }

  @override
  String get repackLibrarySynchronized => 'Repack de biblioteca sincronizada.';

  @override
  String failedToSyncLibrary(Object errorMessage) {
    return 'Falha ao sincronizar a biblioteca: $errorMessage';
  }

  @override
  String get syncLibrary => 'Sincronizar a biblioteca';

  @override
  String get syncingLibrary => 'Sincronizando Biblioteca...';

  @override
  String get noRepacksFoundInTheLibrary =>
      'Nenhum réptil encontrado na biblioteca.';

  @override
  String noRepacksFoundMatchingSearch(Object search) {
    return 'Nenhum representante encontrado correspondente a $search.';
  }

  @override
  String get theWindowIsTooNarrowToDisplayItemsCorrectly =>
      'A janela é muito estreita para exibir os itens corretamente.';

  @override
  String get pleaseResizeTheWindow => 'Por favor, redimensione a janela.';

  @override
  String get repackUrlIsNotAvailable => 'URL da embalagem não está disponível.';

  @override
  String couldNotLaunchUrl(Object error) {
    return 'Não foi possível iniciar a URL: $error';
  }

  @override
  String couldNotLaunch(Object url) {
    return 'Não foi possível iniciar: $url';
  }

  @override
  String invalidUrlFormat(Object url) {
    return 'Formato de URL inválido: $url';
  }

  @override
  String get rescrapeDetails => 'Detalhes Rescrape';

  @override
  String detailsHaveBeenRescraped(Object title) {
    return 'Detalhes de $title foram reescaneados e atualizados.';
  }

  @override
  String failedToRescrapeDetails(Object errorMessage) {
    return 'Falha ao rescrape detalhes: $errorMessage';
  }

  @override
  String get errorRescraping => 'Restringir erro';

  @override
  String get openSourcePage => 'Abrir Página do Código';

  @override
  String noPopularNewRepacksFound(Object type) {
    return 'Nenhum réptil $type encontrado.';
  }

  @override
  String get newest => 'Novo';

  @override
  String get popular => 'popular';

  @override
  String get system => 'SISTEMA';

  @override
  String get yellow => 'Amarelo';

  @override
  String get orange => 'Laranja';

  @override
  String get red => 'Vermelho';

  @override
  String get magenta => 'Magenta';

  @override
  String get purple => 'Roxo';

  @override
  String get blue => 'azul';

  @override
  String get teal => 'Verde-azulado';

  @override
  String get green => 'Verde';

  @override
  String get confirmForceRescrape => 'Confirmar Recrape Força';

  @override
  String
  get thisWillDeleteAllLocallyStoredRepackDataAndReDownloadEverythingFromTheSource =>
      'Isto irá apagar TODOS os dados do repack armazenados localmente e baixar novamente tudo da fonte. ';

  @override
  String
  get thisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataAreYouSure =>
      'Este processo pode levar muito tempo e consumir dados de rede significativos. Você tem certeza?';

  @override
  String get yesRescrapeAll => 'Sim, Rescrape Todos';

  @override
  String get startingFullDataRescrape =>
      'Iniciando reescaneamento completo dos dados...';

  @override
  String get allDataHasBeenForcefullyRescraped =>
      'Todos os dados foram rebaixados forçamente.';

  @override
  String errorMessage(Object error) {
    return 'Erro: $error';
  }

  @override
  String failedToForceRescrapeData(Object errorMessage) {
    return 'Falha ao forçar dados de rescrape : $errorMessage';
  }

  @override
  String get forceRescrapingData => 'Forçar Dados de Restauração';

  @override
  String percentComplete(Object percentComplete) {
    return '$percentComplete% Complete';
  }

  @override
  String get downloadsInstallation => 'Downloads e Instalação';

  @override
  String get defaultDownloadPath => 'Caminho de download padrão';

  @override
  String get maxConcurrentDownloads => 'Máx. de Downloads concorrentes';

  @override
  String get automaticInstallation => 'Instalação automática';

  @override
  String get enableAutoInstallAfterDownload =>
      'Habilitar Instalação Automática após o download:';

  @override
  String get defaultInstallationPath => 'Caminho de instalação padrão';

  @override
  String
  get whenEnabledCompletedRepacksWillAttemptToInstallToTheSpecifiedPath =>
      'Quando habilitado, representantes completos tentarão instalar no caminho especificado.';

  @override
  String get appearance => 'Aparência';

  @override
  String get themeMode => 'Modo tema';

  @override
  String get navigationPaneDisplayMode =>
      'Painel de Navegação Modo de Exibição';

  @override
  String get accentColor => 'Cor do acento';

  @override
  String get windowTransparency => 'Transparência da Janela';

  @override
  String get local => 'Localidade';

  @override
  String get applicationUpdates => 'Atualizações da Aplicação';

  @override
  String get updateCheckFrequency => 'Frequência de verificação de atualização';

  @override
  String get currentAppVersion => 'Versão atual do aplicativo:';

  @override
  String get loading => 'Carregandochar@@0';

  @override
  String get latestAvailableVersion => 'Última versão disponível:';

  @override
  String get youAreOnTheLatestVersion => 'Você está na versão mais recente';

  @override
  String get checking => 'Verificandochar@@0';

  @override
  String get notCheckedYet => ' Não verificado ainda.';

  @override
  String get checkToSee => ' Verificar para ver.';

  @override
  String get youHaveIgnoredThisUpdate => 'Você ignorou esta atualização.';

  @override
  String get unignoreCheckAgain => 'Unignore e verifique novamente';

  @override
  String get checkForUpdatesNow => 'Verificar Atualizações Agora';

  @override
  String updateToVersionIsAvaible(Object version) {
    return 'Atualização para a versão $version está disponível';
  }

  @override
  String get downloadAndInstallUpdate => 'Baixar e instalar atualização';

  @override
  String get viewReleasePage => 'Ver Página de Lançamento';

  @override
  String get dataManagement => 'Gerenciamento de dados';

  @override
  String get forceRescrapeAllData => 'Forçar Recrape Todos os Dados';

  @override
  String
  get warningThisProcessCanTakeAVeryLongTimeAndConsumeSignificantNetworkDataUseWithCaution =>
      'Aviso: Este processo pode levar muito tempo e consumir dados significativos de rede. Use com cuidado.';

  @override
  String get rescrapingSeeDialog => 'Resplandecente... Veja o diálogo';

  @override
  String get forceRescrapeAllDataNow => 'Forçar Recrape Todos os Dados Agora';

  @override
  String get anotherRescrapingProcessIsAlreadyRunning =>
      'Outro processo de rescraping já está em execução.';

  @override
  String get clearingAllExistingData => 'Limpando todos os dados existentes...';

  @override
  String get scrapingAllRepackNamesPhase1 =>
      'Scraping todos os nomes de repack (Fase 1/4)...';

  @override
  String scrapingAllRepackNamesPhase1Progress(num page, num totalPages) {
    String _temp0 = intl.Intl.pluralLogic(
      page,
      locale: localeName,
      other: 'páginas',
      one: 'página',
    );
    return 'Scraping todos os nomes de repack (Fase 1/4): Página $page de $totalPages $_temp0';
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
      'Scraping detalhes para cada réptil (Fase 2/4 - Faca mais longo)...';

  @override
  String scrapingDetailsForEveryRepackPhase2Progress(
    Object current,
    Object total,
  ) {
    return 'Selecionar detalhes para cada réptil (Fase 2/4): Recompile $current de $total';
  }

  @override
  String allRepackDetailsScrapedPhase2(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'repacks',
      one: 'repack',
      zero: 'Recompre',
    );
    return 'Todos os detalhes da sack foram copiados. ($count $_temp0 processado (Fase 2/4 Completo)';
  }

  @override
  String get rescrapingNewRepacksPhase3 =>
      'Rescrindo novos representantes (Fase 3/4)...';

  @override
  String rescrapingNewRepacksPhase3Progress(Object current, Object total) {
    return 'Rescrir novos representantes (Fase 3/4): Página $current de $total';
  }

  @override
  String get newRepacksRescrapedPhase3Complete =>
      'Novos répteis reescaneados. (Fase 3/4 Completa)';

  @override
  String get rescrapingPopularRepacksPhase4 =>
      'Recolher representantes populares (Fase 4/4)...';

  @override
  String rescrapingPopularRepacksPhase4Progress(Object current, Object total) {
    return 'Reescanear representantes populares (Fase 4/4): Item $current de $total';
  }

  @override
  String get popularRepacksRescrapedPhase4Complete =>
      'Rejetos populares reescaneados. (Fase 4/4 Completo)';

  @override
  String get finalizing => 'Finalizando...';

  @override
  String get fullRescrapeCompletedSuccessfully =>
      'Rescrape completo completado com sucesso!';

  @override
  String errorProcessHalted(Object errorMessage) {
    return 'Erro: $errorMessage. Processo interrompido.';
  }

  @override
  String get daily => 'Diariamente';

  @override
  String get weekly => 'Semanalmente';

  @override
  String get manual => 'Manualmente';

  @override
  String get onEveryStartup => 'Em Toda inicialização';

  @override
  String get light => 'Fino';

  @override
  String get dark => 'Escuro';

  @override
  String get noUrlsFoundInTheMirrorConfiguration =>
      'Não há URLs encontradas na configuração do espelho.';

  @override
  String get failedToProcessUnknownPlugin =>
      'Falha ao processar (Plugin desconhecido):';

  @override
  String get problemProcessingSomeLinks =>
      'Problema ao processar alguns links. ';

  @override
  String get errorProcessingOneOrMoreLinks =>
      'Erro ao processar um ou mais links. ';

  @override
  String filesAddedToDownloadManager(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'arquivos',
      one: 'arquivo',
      zero: 'Arquivos',
    );
    return '$count $_temp0 adicionado para o gerenciador de downloads.';
  }

  @override
  String get downloadStarted => 'Download Iniciado';

  @override
  String get ok => 'Certo';

  @override
  String get noFilesSelected => 'Nenhum Arquivo Selecionado';

  @override
  String get pleaseSelectOneOrMoreFilesFromTheTreeToDownload =>
      'Por favor, selecione um ou mais arquivos da árvore para download.';

  @override
  String get noFilesCouldBeRetrieved => 'Nenhum arquivo pôde ser recuperado.';

  @override
  String noticeProcessingErrorSomeFilesMayHaveEncounteredIssues(
    Object processingError,
  ) {
    return 'Aviso: $processingError Alguns arquivos podem ter encontrado problemas.';
  }

  @override
  String get noDownloadableFilesFoundForThisMirror =>
      'Nenhum arquivo para download encontrado para este espelho.';

  @override
  String downloadFilesGame(Object Game) {
    return 'Baixar Arquivos: $Game';
  }

  @override
  String get close => 'FECHAR';

  @override
  String get downloadSelected => 'Baixar selecionado';

  @override
  String get aboutGame => 'Sobre o jogo';

  @override
  String get features => 'Funcionalidades';

  @override
  String get selectDownloadOptions => 'Selecionar opções de download';

  @override
  String get downloadMethod => 'Método de Download:';

  @override
  String get selectMethod => 'Selecionar método';

  @override
  String get mirror => 'Espelho:';

  @override
  String get selectMirror => 'Selecionar espelho';

  @override
  String get downloadLocation => 'Local do Download:';

  @override
  String get enterDownloadLocationOrBrowse =>
      'Digite o local de download ou navegue';

  @override
  String get downloadLocationEmpty => 'Local de Download Vazio';

  @override
  String get pleaseSelectOrEnterADownloadLocation =>
      'Por favor, selecione ou insira um local de download.';

  @override
  String get selectionIncomplete => 'Seleção incompleta';

  @override
  String get pleaseSelectADownloadMethodAndAMirror =>
      'Por favor, selecione um método de download e um espelho.';

  @override
  String get next => 'Próximo';

  @override
  String get download => 'BAIXAR';

  @override
  String get downloadComplete => 'Download concluído!';

  @override
  String get downloadPending => 'Download pendente...';

  @override
  String get genres => 'Genres';

  @override
  String get company => 'Empresas';

  @override
  String get language => 'IDIOMA';

  @override
  String get originalSize => 'Tamanho Original';

  @override
  String get repackSize => 'Tamanho da embalagem';

  @override
  String get repackInformation => 'Informações de recompactação';

  @override
  String screenshotsTitle(Object count) {
    return 'Screenshots ($count)';
  }

  @override
  String get errorLoadingImage => 'Erro ao carregar imagem';

  @override
  String get noScreenshotsAvailable => 'Nenhuma captura de tela disponível.';

  @override
  String get noGenresAvailable => 'Nenhum gênero disponível';

  @override
  String get clear => 'Limpar';

  @override
  String get filterByGenre => 'Filtrar por gênero';

  @override
  String get filter => 'filtro';
}
