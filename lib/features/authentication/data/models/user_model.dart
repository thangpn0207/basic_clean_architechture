import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart'; // Import domain entity for mapping

part 'user_model.freezed.dart'; // Generated freezed file
part 'user_model.g.dart'; // Generated json_serializable file

@freezed
@JsonSerializable()
class UserModel with _$UserModel {
  @override
  final String id;
  @override
  final String email;
  @override
  final String name;
  @override
  final String? token;
  UserModel({required this.id, required this.email, required this.name, required this.token}); // Uses generated function

  // Factory constructor for JSON deserialization
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson()  =>_$UserModelToJson(this);
}

// Extension method for easy mapping (optional but recommended)
extension UserModelX on UserModel {
  User toDomain() {
    return User(
      id: id,
      email: email,
      name: name,
      token: token,
    );
  }
}

// Remove the old UserModel class that extended User