import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testeflutter/models/transaction.dart';

final transactionProvider =
    FutureProvider.autoDispose<List<Transaction>>((ref) async {
  return Hive.box<Transaction>('transaction').values.toList();
});

var transactionProvider2 =
    StateNotifierProvider<TransactionNotifier, List<Transaction>>((ref) {
  return TransactionNotifier();
});

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier() : super([]) {
    init();
  }

  DateTimeRange? range;
  String? valueDropDown;
  String? observacao;

  Future<void> init() async {
    var observacaos = observacao ?? '';
    var data =
        range ?? DateTimeRange(start: DateTime.now(), end: DateTime.now());
    var categoria = valueDropDown ?? '';

    final box = await Hive.openBox<Transaction>('transaction');
    state = box.values
        .toList()
        .cast<Transaction>()
        .where((e) {
          return (range != null)
              ? e.date.isAfter(data.start) && e.date.isBefore(data.end)
              : e.date.difference(data.end).inDays <= 10;
        })
        .where((e) =>
            e.observacao.toLowerCase().contains(observacaos.toLowerCase()))
        .where(
            (e) => e.catiguria.toLowerCase().contains(categoria.toLowerCase()))
        .toList();
  }
}
