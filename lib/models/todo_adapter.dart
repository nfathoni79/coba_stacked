import 'package:coba_stacked/models/todo.dart';
import 'package:hive/hive.dart';

/// Todo type adapter for Hive.
class TodoAdapter extends TypeAdapter<Todo> {
  @override
  int get typeId => 1;

  @override
  Todo read(BinaryReader reader) {
    // Get number of fields defined in write method
    final numOfFields = reader.readByte();

    // Create a map of pairs of field ID key and their value
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return Todo(
      id: fields[0] as String,
      completed: fields[1] as bool,
      content: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer
      ..writeByte(3)  // Set number of fields
      ..writeByte(0)  // Set field ID
      ..write(obj.id)  // Set field value
      ..writeByte(1)
      ..write(obj.completed)
      ..writeByte(2)
      ..write(obj.content);
  }
}
