// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pdv/core/dao/configuracao_dao.dart';
// import 'package:pdv/core/entity/configuracao.dart';
// import 'package:testeflutter/common/enum/theme_enum.dart';

// //ADICIONAR AQUI A FUNCAO PARA PEGAR AS CONFIGURACOES
// class ThemeCubit extends Cubit<ThemeEnum> {
//   final ConfiguracaoDAO dao;

//   ThemeCubit(
//     this.dao,
//   ) : super(ThemeEnum.light) {
//     loadSettings();
//   }

//   Future<void> loadSettings() async {
//     Configuracao? config = await dao.findConfiguracaoGlobal();
//     if (config != null) {
//       emit(config.tema ?? ThemeEnum.light);
//     }
//   }

//   Future<void> changeTheme(ThemeEnum theme) async {
//     emit(theme);
//     await dao.updateTema(theme);
//   }
// }
