import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  dynamic password;

  User({required this.username, required this.password});
}
