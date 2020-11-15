import 'inserir_orcamento_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'inserir_orcamento_page.dart';

class InserirOrcamentoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $InserirOrcamentoController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => InserirOrcamentoPage()),
      ];

  static Inject get to => Inject<InserirOrcamentoModule>.of();
}
