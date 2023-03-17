import 'package:hive/hive.dart';
part 'category.g.dart';

@HiveType(typeId: 0)
class Category extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;

  Category({
    required this.id,
    required this.title,
  });
}
