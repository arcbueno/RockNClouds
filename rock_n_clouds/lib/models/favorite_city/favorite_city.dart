import 'package:hive_flutter/hive_flutter.dart';

part 'favorite_city.g.dart';

@HiveType(typeId: 3)
class FavoriteCity extends HiveObject {
  @HiveField(0)
  String? areaName;
  @HiveField(1)
  String? country;
  @HiveField(2)
  double? lat;
  @HiveField(3)
  double? lon;
  FavoriteCity({
    this.areaName,
    this.country,
    this.lat,
    this.lon,
  });
}
