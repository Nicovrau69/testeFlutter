import 'package:hive/hive.dart';
part 'previsao.g.dart';

@HiveType(typeId: 2)
class Previsao extends HiveObject {
  @HiveField(0)
  late double valor;
  @HiveField(1)
  late DateTime data;

  Previsao({
    required this.valor,
    required this.data,
  });
}
