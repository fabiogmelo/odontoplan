import 'inserir_servico_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'inserir_servico_page.dart';

class InserirServicoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $InserirServicoController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => InserirServicoPage()),
      ];

  static Inject get to => Inject<InserirServicoModule>.of();
}
