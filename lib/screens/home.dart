import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fit_flutter_fluent/data/repack_list_type.dart';
import 'package:fit_flutter_fluent/services/repack_service.dart';
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
  bool selected = true;
  final ScraperService _scraperService = ScraperService.instance;
  final RepackService _repackService = RepackService.instance;


  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    // final theme = FluentTheme.of(context);

    return ScaffoldPage(
      content: Column(
        children: [
          // Center(child: Button(child: Text("data"), onPressed: _rescrapeAll),),
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
