import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart'; // Generated file

@freezed
class User with _$User { // _$User is the generated mixin
  final String id;
  final String email;
  final String name;
  final String? token;

  User({required this.id, required this.email, required this.name, required this.token});
}
