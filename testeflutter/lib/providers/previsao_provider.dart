import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testeflutter/models/previsao.dart';

final previsaoProvider =
    FutureProvider.autoDispose<List<Previsao>>((ref) async {
  return Hive.box<Previsao>('previsao').values.toList();
});

final previsaoProvider2 =
    StateNotifierProvider<PrevisaoNotifier, List<Previsao>>((ref) {
  return PrevisaoNotifier();
});

class PrevisaoNotifier extends StateNotifier<List<Previsao>> {
  PrevisaoNotifier() : super([]) {
    init();
  }

  Future<void> init() async {
    final box = await Hive.openBox<Previsao>('previsao');
    state = box.values.toList().cast<Previsao>();
  }
}
