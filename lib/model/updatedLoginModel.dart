import 'dart:convert';

LoginUpdatedModel loginUpdatedModelFromJson(String str) =>
    LoginUpdatedModel.fromJson(json.decode(str));

String loginUpdatedModelToJson(LoginUpdatedModel data) =>
    json.encode(data.toJson());

class LoginUpdatedModel {
  LoginUpdatedModel({
    this.accessToken,
    this.message,
    this.refreshToken,
  });

  String accessToken;
  String message;
  String refreshToken;

  factory LoginUpdatedModel.fromJson(Map<String, dynamic> json) =>
      LoginUpdatedModel(
        accessToken: json["access_token"],
        message: json["message"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "message": message,
        "refresh_token": refreshToken,
      };
}
