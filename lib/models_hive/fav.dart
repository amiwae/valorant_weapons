import 'package:hive/hive.dart';

part 'fav.g.dart';

@HiveType(typeId: 1)
class Favorite extends HiveObject {
  @HiveField(0)
  late String displayName;

  @HiveField(1)
  late String displayIcon;

  Favorite({
    required this.displayName,
    required this.displayIcon,
  });
}

class FavoriteProvider {
  static const String boxName = 'favorites';
  late Box<Favorite> _box;

  Future<Box> _getBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box(boxName);
    } else {
      return await Hive.openBox(boxName);
    }
  }

  Future<void> addToFavorites(String displayName, String displayIcon) async {
    final box = await _getBox();
    final favorite = Favorite(displayName: displayName, displayIcon: displayIcon);
    await box.put(displayName, favorite);
  }

  Future<void> removeFromFavorites(String displayName) async {
    final box = await _getBox();
    await box.delete(displayName);
  }

  Future<List<Favorite>> getFavorites() async {
    final box = await _getBox();
    return box.values.toList().cast<Favorite>();
  }
}