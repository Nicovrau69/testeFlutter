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

  Future<void> init() async {
    final box = await Hive.openBox<Transaction>('transaction');
    state = box.values.toList();
  }

  // filtros de pesquisa
  DateTimeRange? selectedDate;
  String? valueDropdown;
  String? stringObservacao;
  final caixa = Hive.box<Transaction>('transaction');

  void show() async {
    /*final DateTimeRange? result = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2021, 1, 1),
        lastDate: DateTime(2029, 1, 1),
        currentDate: DateTime.now(),
        saveText: 'Done', context:);

    if (result != null) {
      print(result);
      selectedDate = result;
    } else {
      state = caixa.values.toList();
    }
  }*/

    void observacaoFilter(String valor) {
      stringObservacao = valor;
      state = caixa.values.toList();
    }

    void clearFilter() {
      selectedDate = null;
      state = caixa.values.toList();
    }

    void clearCategoriaFilter() {
      valueDropdown = null;
      state = caixa.values.toList();
    }

    Widget build(BuildContext context) {
      return ValueListenableBuilder<Box<Transaction>>(
        valueListenable: Hive.box<Transaction>('transaction').listenable(),
        builder: (context, box, _) {
          var lancamentos = box.values.toList().cast<Transaction>();
          var observacao = stringObservacao ?? '';
          var data = selectedDate ??
              DateTimeRange(start: DateTime.now(), end: DateTime.now());
          var categoria = valueDropdown ?? '';

          lancamentos = box.values
              .toList()
              .cast<Transaction>()
              .where((element) {
                return (selectedDate != null)
                    ? element.date.isAfter(data.start) &&
                        element.date.isBefore(data.end)
                    : element.date.difference(data.end).inDays <= 10;
              })
              .where((element) => element.observacao
                  .toLowerCase()
                  .contains(observacao.toLowerCase()))
              .where((element) => element.catiguria
                  .toLowerCase()
                  .contains(categoria.toLowerCase()))
              .toList();

          transactionProvider2 = lancamentos
              as StateNotifierProvider<TransactionNotifier, List<Transaction>>;
        },
      );
    }
  }
}
