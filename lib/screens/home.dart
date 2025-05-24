// screens/home.dart
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fit_flutter_fluent/data/repack_list_type.dart';
import 'package:fit_flutter_fluent/services/scraper_service.dart';
import 'package:fit_flutter_fluent/widgets/repack_slider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

import '../widgets/page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with PageMixin {
  bool _isRescrapingHome = false;

  Future<void> _rescrapeHomeData() async {
    if (!mounted) return;
    setState(() => _isRescrapingHome = true);
    try {
      await ScraperService.instance.rescrapeNewAndPopularRepacks();
      if (mounted) {
        displayInfoBar(
          context,
          builder: (context, close) {
            return InfoBar(
              title: const Text('Success'),
              content: const Text(
                'New and Popular repacks have been rescraped.',
              ),
              action: IconButton(
                icon: const Icon(FluentIcons.clear),
                onPressed: close,
              ),
              severity: InfoBarSeverity.success,
            );
          },
        );
      }
    } catch (e) {
      print("Error rescraping home data: $e");
      if (mounted) {
        displayInfoBar(
          context,
          builder: (context, close) {
            return InfoBar(
              title: const Text('Error'),
              content: Text('Failed to rescrape data: $e'),
              action: IconButton(
                icon: const Icon(FluentIcons.clear),
                onPressed: close,
              ),
              severity: InfoBarSeverity.error,
            );
          },
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isRescrapingHome = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));

    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Home'),
        commandBar: CommandBar(
          primaryItems: [
            CommandBarButton(
              icon:
                  _isRescrapingHome
                      ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: ProgressRing(strokeWidth: 2.0),
                      )
                      : const Icon(FluentIcons.refresh),
              label: const Text('Rescrape New & Popular'),
              onPressed: _isRescrapingHome ? null : _rescrapeHomeData,
            ),
          ],
        ),
      ),
      content: Column(
        children: [
          Expanded(
            child: RepackSlider(
              repackListType: RepackListType.newest,
              title: "New Repacks",
              onRepackTap: (Repack repack) {
                context.push("/repackdetails", extra: repack);
              },
            ),
          ),
          Expanded(
            child: RepackSlider(
              repackListType: RepackListType.popular,
              title: "Popular Repacks",
              onRepackTap: (Repack repack) {
                context.push("/repackdetails", extra: repack);
              },
            ),
          ),
        ],
      ),
    );
  }
}
