import 'package:hive/hive.dart';
import 'package:hive_test/class/user.dart';

class PersonAdapter extends TypeAdapter<User> {
  @override
  final typeId = 0;

  @override
  User read(BinaryReader reader) {
    final user = User(username: '', password: null);
    user.username = reader.readString();
    user.password = reader.readString();
    return user;
  }

  @override
  void write(BinaryWriter writer, User user) {
    writer.writeString(user.username);
    writer.writeString(user.password);
  }
}