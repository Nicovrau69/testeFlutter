import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/category.dart';
import '../models/previsao.dart';
import '../models/transaction.dart';

class PrevisaoChart extends StatefulWidget {
  const PrevisaoChart({super.key});

  @override
  State<PrevisaoChart> createState() => _PrevisaoChartState();
}

class _PrevisaoChartState extends State<PrevisaoChart> {
  final boxCategorias = Hive.box<Category>('category');
  final boxTransaction = Hive.box<Transaction>('transaction');
  final boxPrevisao = Hive.box<Previsao>('previsao');

  @override
  Widget build(BuildContext context) {
    return const Text('Grafico');
  }
}
