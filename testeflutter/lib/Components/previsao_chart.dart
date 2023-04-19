import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:testeflutter/models/category.dart';
import 'package:testeflutter/models/previsao.dart';
import 'package:testeflutter/models/transaction.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../models/ChartData.dart';

class PrevisaoChart extends StatefulWidget {
  final DateTime data;
  const PrevisaoChart(this.data, {super.key});

  @override
  State<PrevisaoChart> createState() => _PrevisaoChartState();
}

class _PrevisaoChartState extends State<PrevisaoChart> {
  final categoriaBox = Hive.box<Category>('category');

  final transactionBox = Hive.box<Transaction>('transaction');

  final previsaoBox = Hive.box<Previsao>('previsao');

  late final valor;
  late final graph;
  double totalTransaction = 0;
  @override
  void initState() {
    super.initState();

    final graphValues = <ChartData?>[];
    final graphOrcamento = <ChartData?>[];
    final values = categoriaBox.values.map((e) {
      final previsaoCat = previsaoBox.values.where((element) =>
          e.title == element.categoria &&
          element.data.month == widget.data.month);

      for (var i in transactionBox.values) {
        if (i.catiguria == e.title && i.date.month == widget.data.month) {
          totalTransaction += i.value;
        }
      }

      if (previsaoCat.isEmpty) {
        return [];
      } else {
        graphValues.add(ChartData(
            id: Random().nextInt(999999),
            categoria: e.title,
            valor: totalTransaction));
        graphOrcamento.add(ChartData(
            id: Random().nextInt(99999),
            categoria: e.title,
            valor: previsaoCat.first.valor));
        return [graphValues, graphOrcamento];
      }
    }).toList();

    final grafico = [
      charts.Series<ChartData?, String>(
        id: 'Chart',
        data: (values.isEmpty || values[0].isEmpty) ? [] : values[0][0],
        domainFn: (datum, index) => datum!.categoria,
        measureFn: (datum, index) => datum?.valor,
      ),
      charts.Series<ChartData?, String>(
        id: 'Chart',
        data: (values.isEmpty || values[0].isEmpty) ? [] : values[0][1],
        domainFn: (datum, index) => datum!.categoria,
        measureFn: (datum, index) => datum?.valor,
      )
    ];
    valor = values;
    graph = grafico;
  }

  @override
  Widget build(BuildContext context) {
    if (valor.isEmpty || valor[0].isEmpty) {
      return Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: const Text(
          "Nenhum dado encontrado",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return Container(
          width: 411.5,
          height: 400,
          child: charts.BarChart(
            graph,
            animate: false,
          ));
    }
  }
}
