import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testeflutter/models/category.dart';

final categoriasProvider =
    FutureProvider.autoDispose<List<Category>>((ref) async {
  return Hive.box<Category>('category').values.toList();
});
