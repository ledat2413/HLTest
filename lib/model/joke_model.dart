import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class JokeModel with TypeAdapter<JokeModel> {
  @HiveField(0)
  late String content;

  @HiveField(1)
  late int index;

  @HiveField(2)
  late bool vote;

  JokeModel({this.content = "", this.index = 0, this.vote = false});

  @override
  JokeModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JokeModel(
        content: fields[0] as String,
        index: fields[1] as int,
        vote: fields[2] as bool);
  }

  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, JokeModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.content)
      ..writeByte(1)
      ..write(obj.index)
      ..writeByte(2)
      ..write(obj.vote);
  }
}
