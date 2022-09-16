import '/src/core/di_container.dart';
import '/src/core/widgets/common.dart';

import 'restore_group_controller.dart';
import 'pages/explainer_page.dart';
import 'pages/scan_qr_code_page.dart';
import 'pages/loading_page.dart';

class RestoreGroupView extends StatelessWidget {
  static const routeName = '/recovery_group/restore';
  static const _pages = [
    ExplainerPage(),
    ScanQRCodePage(),
    LoadingPage(),
  ];

  const RestoreGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    final diContainer = context.read<DIContainer>();
    return ChangeNotifierProvider(
      create: (context) => RestoreGroupController(
        diContainer: diContainer,
        pagesCount: _pages.length,
      ),
      lazy: false,
      child: ScaffoldWidget(
        child: Selector<RestoreGroupController, int>(
          selector: (_, controller) => controller.currentPage,
          builder: (_, currentPage, __) => AnimatedSwitcher(
            duration: diContainer.globals.pageChangeDuration,
            child: _pages[currentPage],
          ),
        ),
      ),
    );
  }
}