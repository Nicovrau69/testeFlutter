import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:testeflutter/models/category.dart';
import 'package:testeflutter/models/transaction.dart';

//tela do grafico de pizza

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  final box = Hive.box<Category>('category');

  final boxT = Hive.box<Transaction>('transaction').values.toList();

  Map<String, double> dataMap = {};

  @override
  void initState() {
    super.initState();
    for (String i in box.values.map((e) => e.title)) {
      double sumTotal = 0.0;
      for (var i2 in boxT) {
        if (i2.catiguria == i) {
          sumTotal += i2.value;
        }
      }
      dataMap[i] = sumTotal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráfico de pizza'), //titulo que aparece na appbar
      ),
      body: Center(
        child: PieChart(
          dataMap: dataMap,
          chartRadius: MediaQuery.of(context).size.width / 1.7,
          legendOptions: const LegendOptions(
            legendPosition: LegendPosition.bottom,
          ),
          chartValuesOptions: const ChartValuesOptions(
            showChartValuesInPercentage: false,
          ),
        ),
      ),
    );
  }
}
