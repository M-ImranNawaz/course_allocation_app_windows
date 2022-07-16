import 'package:hive/hive.dart';

part 'login_cred_adapter.g.dart';

@HiveType(typeId: 3)
class LoginCred extends HiveObject {
  LoginCred({
    this.id,
    this.name,
    this.department,
    this.email,
    this.password,
    this.isLoggedIn,
    this.token,
  });
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? department;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? password;
  @HiveField(5)
  bool? isLoggedIn;
  @HiveField(6)
  String? token;
}
