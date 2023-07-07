import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable(createToJson: false)
class UserProfile {
  @JsonKey(name: "user_id")
  final int userId;

  @JsonKey(name: "name")
  final String userName;

  @JsonKey(name: "nip")
  final String userNip;

  const UserProfile({
    required this.userId,
    required this.userName,
    required this.userNip,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
