import 'package:database_app/database/core/database_user_core.dart';

class UserModel {
  int? id;
  String? name;
  double? salary;
  UserModel({this.id, this.name, this.salary});
  UserModel.fromMap(Map<String, dynamic> map)
      : id = map[uid],
        name = map[uName],
        salary = map[uSalary];

  Map<String, dynamic> toMap({bool? isAdd}) {
    return {
      if ((isAdd ?? false) != true) uid: id,
      uName: name,
      uSalary: salary,
    };
  }
}
