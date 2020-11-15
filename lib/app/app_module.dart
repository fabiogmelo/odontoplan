import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:odontoplan/app/app_widget.dart';
import 'package:odontoplan/app/modules/home/home_module.dart';
import 'modules/login/login_module.dart';
import 'modules/orcamento/inserir_orcamento/inserir_orcamento_module.dart';
import 'modules/orcamento/inserir_servico/inserir_servico_module.dart';
import 'modules/orcamento/orcamento_module.dart';
import 'modules/splash/splash_module.dart';
import 'modules/vrpo/vrpo_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $AppController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: SplashModule()),
        ModularRouter("/Home", module: HomeModule()),
        ModularRouter("/Login", module: LoginModule()),
        ModularRouter("/Orca", module: OrcamentoModule()),
        ModularRouter("/Vrpo", module: VrpoModule()),
        ModularRouter("/InserirOrca", module: InserirOrcamentoModule()),
        ModularRouter("/InserirServ", module: InserirServicoModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
