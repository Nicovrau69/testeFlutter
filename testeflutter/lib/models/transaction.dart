import 'package:hive_flutter/hive_flutter.dart';
part 'transaction.g.dart';

@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double value;
  @HiveField(3)
  final String observacao;
  @HiveField(4)
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.value,
    required this.observacao,
    required this.date,
  });
}
