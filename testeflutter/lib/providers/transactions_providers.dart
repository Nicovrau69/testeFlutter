import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testeflutter/models/transaction.dart';

final transactionProvider =
    FutureProvider.autoDispose<List<Transaction>>((ref) async {
  return Hive.box<Transaction>('transaction').values.toList();
});

var transactionProvider2 =
    StateNotifierProvider<TransactionNotifier, List<Transaction>>((refs) {
  return TransactionNotifier();
});

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier() : super([]) {
    init();
  }
  DateTimeRange? range;
  String? valueDropDown;
  String? obs;

  search(String? sa, DateTimeRange? d, String? categorias) {
    var data = d ?? DateTimeRange(start: DateTime.now(), end: DateTime.now());
    var categoria = categorias ?? '';
    var observacaos = sa ?? '';

    state = state
        .where((e) {
          return (d != null)
              ? e.date.isAfter(data.start) && e.date.isBefore(data.end)
              : e.date.difference(data.start).inDays <= 10;
        })
        .where((e) =>
            e.observacao.toLowerCase().contains(observacaos.toLowerCase()))
        .where(
            (e) => e.catiguria.toLowerCase().contains(categoria.toLowerCase()))
        .toList();
  }

  Future<void> init() async {
    final box = await Hive.openBox<Transaction>('transaction');
    state = box.values.toList().cast<Transaction>();
  }
}
