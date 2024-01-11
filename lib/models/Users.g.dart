// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      token: json['token'] as String?,
      status: json['status'] as String?,
      errors: json['errors'] as List<dynamic>?,
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'token': instance.token,
      'status': instance.status,
      'errors': instance.errors,
    };
