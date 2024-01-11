import 'package:json_annotation/json_annotation.dart';

part 'Users.g.dart';

@JsonSerializable()
class Users {
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "errors")
  List<dynamic>? errors;

  Users({this.token, this.status, this.errors});

  factory Users.fromJson(Map<String, dynamic> json) {
    var errorsFromJson = json['errors'];
    List<dynamic>? errorsList;
    if (errorsFromJson != null) {
      errorsList = List<dynamic>.from(errorsFromJson);
    } else {
      errorsList = [];
    }

    return Users(
      token: json['token'],
      status: json['status'],
      errors: errorsList,
    );
  }
  Map<String, dynamic> toJson() => _$UsersToJson(this);
}