import 'package:hive/hive.dart';
part 'previsao.g.dart';

@HiveType(typeId: 2)
class Previsao extends HiveObject {
  @HiveField(0)
  double valor;
  @HiveField(1)
  DateTime data;
  @HiveField(2)
  int id;
  @HiveField(3)
  String categoria;

  Previsao({
    required this.valor,
    required this.data,
    required this.id,
    required this.categoria,
  });
}
