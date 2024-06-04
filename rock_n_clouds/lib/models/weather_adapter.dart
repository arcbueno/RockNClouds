import 'package:hive/hive.dart';
import 'package:weather/weather.dart';

class WeatherAdapter extends TypeAdapter<Weather> {
  @override
  final typeId = 0;

  @override
  Weather read(BinaryReader reader) {
    return Weather(reader.read());
  }

  @override
  void write(BinaryWriter writer, Weather obj) {
    writer.write(obj);
  }
}
