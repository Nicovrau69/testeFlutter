import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testeflutter/Components/previsao_list.dart';
import 'package:testeflutter/models/previsao.dart';

import '../providers/previsao_provider.dart';
import 'form_previsao.dart';

class PrevisaoGastos extends ConsumerStatefulWidget {
  const PrevisaoGastos({super.key});

  @override
  ConsumerState<PrevisaoGastos> createState() {
    return _PrevisaoGastosState();
  }
}

class _PrevisaoGastosState extends ConsumerState<PrevisaoGastos> {
  //abre o formulario de criação de previsao
  _openPrevisaoForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return PrevisaoForm(
            (p0, p1) async => await addPrevisao(p0, p1),
          );
        });
  }

  //função para adicionar uma previsao
  addPrevisao(double valor, DateTime mes) async {
    final newPrevisao = Previsao(valor: valor, data: mes);
    await caixa.add(newPrevisao);
    ref.invalidate(previsaoProvider);
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previsão de Gastos'), //texto que aparece na appbar
      ),
      body: SingleChildScrollView(
        //faz com que a tela seja scrollavel
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            PrevisaoList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          //botão utilizado para criar uma nova previsao
          onPressed: () {
            _openPrevisaoForm(context);
            setState(() {});
          },
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
