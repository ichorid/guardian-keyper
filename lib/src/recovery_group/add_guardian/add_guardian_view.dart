import '/src/core/consts.dart';
import '/src/core/di_container.dart';
import '/src/core/model/core_model.dart';
import '/src/core/widgets/common.dart';

import 'add_guardian_controller.dart';
import 'pages/scan_qrcode_page.dart';
import 'pages/loading_page.dart';

class AddGuardianView extends StatelessWidget {
  static const routeName = routeGroupAddGuardian;

  static const _pages = [
    ScanQRCodePage(),
    LoadingPage(),
  ];

  final GroupId groupId;

  const AddGuardianView({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    final diContainer = context.read<DIContainer>();
    return ChangeNotifierProvider(
      create: (context) => AddGuardianController(
        diContainer: diContainer,
        pages: _pages,
        groupId: groupId,
      ),
      lazy: false,
      child: ScaffoldWidget(
        child: Selector<AddGuardianController, int>(
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
