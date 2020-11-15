import 'orcamento_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'orcamento_page.dart';

class OrcamentoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $OrcamentoController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => OrcamentoPage()),
      ];

  static Inject get to => Inject<OrcamentoModule>.of();
}
