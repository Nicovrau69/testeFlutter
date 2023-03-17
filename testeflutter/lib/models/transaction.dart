import 'package:hive_flutter/hive_flutter.dart';
part 'transaction.g.dart';

@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  double value;
  @HiveField(3)
  String observacao;
  @HiveField(4)
  DateTime date;
  @HiveField(5)
  String catiguria;

  Transaction({
    required this.id,
    required this.title,
    required this.value,
    required this.observacao,
    required this.date,
    required this.catiguria,
  });
}
