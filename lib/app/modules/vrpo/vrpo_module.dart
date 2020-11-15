import 'vrpo_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'vrpo_page.dart';

class VrpoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $VrpoController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => VrpoPage()),
      ];

  static Inject get to => Inject<VrpoModule>.of();
}
