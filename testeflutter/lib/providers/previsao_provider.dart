import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testeflutter/models/previsao.dart';

final previsaoProvider =
    FutureProvider.autoDispose<List<Previsao>>((ref) async {
  return Hive.box<Previsao>('previsao').values.toList();
});
