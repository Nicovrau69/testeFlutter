import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testeflutter/components/categorias.dart';
import 'package:testeflutter/models/category.dart';

final categoriasProvider =
    FutureProvider.autoDispose<List<Category>>((ref) async {
  return Hive.box<Category>('category').values.toList();
});

var categoriasProvider2 =
    StateNotifierProvider<CategoryNotifier, List<Category>>((ref) {
  return CategoryNotifier();
});

class CategoryNotifier extends StateNotifier<List<Category>> {
  CategoryNotifier() : super([]) {
    init();
  }

  Future<void> init() async {
    final box = await Hive.openBox<Category>('category');
    state = box.values.toList().cast<Category>();
  }
}
