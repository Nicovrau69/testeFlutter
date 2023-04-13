import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:testeflutter/components/form_previsao.dart';
import 'package:testeflutter/components/previsao_chart.dart';
import 'package:testeflutter/components/previsao_list.dart';
import 'package:testeflutter/models/previsao.dart';
import 'package:testeflutter/providers/previsao_provider.dart';

import '../models/category.dart';

//pagina das previsoes

class PrevisaoGastos extends ConsumerStatefulWidget {
  const PrevisaoGastos({super.key});

  @override
  ConsumerState<PrevisaoGastos> createState() => _PrevisaoGastosState();
}

class _PrevisaoGastosState extends ConsumerState<PrevisaoGastos> {
  final boxCategory = Hive.box<Category>('category');
  final box = Hive.box<Previsao>('previsao');
  openPrevisaoFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return PrevisaoForm((p0, p1, p2) async => await addPrevisao(p0, p1, p2),
            boxCategory.values.toList());
      },
    );
  }

  //adiciona previsao
  addPrevisao(double valore, DateTime date, String categorias) async {
    final newPrevisao = Previsao(
        valor: valore, data: date, id: box.keys.length, categoria: categorias);

    await box.add(newPrevisao);
    ref.invalidate(previsaoProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previsao de gastos'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PrevisaoChart(), //mostra o chart de previsoes
            PrevisaoList(), //mostra lista de previsoes
          ],
        ),
      ),
      //botão para adicionar previsoes
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          openPrevisaoFormModal(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
