import 'package:flutter/foundation.dart';

class LoginModel {
  final String IsUserLogin;
  final String Error;
  final String Token;
  final String FirstName;
  final String LastName;
  final String ProfilePicture;
  final String UserId;
  final String AccountId;
  final String RoleId;
  final String IsLiveView;
  final String Email;

  LoginModel({
    @required this.IsUserLogin,
    @required this.Error,
    @required this.Token,
    @required this.FirstName,
    @required this.LastName,
    @required this.ProfilePicture,
    @required this.UserId,
    @required this.AccountId,
    @required this.RoleId,
    @required this.IsLiveView,
    @required this.Email,
  });

  factory LoginModel.fromJsonData(Map<String, dynamic> json) => LoginModel(
        IsUserLogin: json['IsUserLogin'],
        Error: json['Error'],
        Token: json['Token'],
        FirstName: json['First Name'],
        LastName: json['Last Name'],
        ProfilePicture: json['Profile Picture'],
        UserId: json['UserId'],
        AccountId: json['AccountId'],
        RoleId: json['RoleId'],
        IsLiveView: json['IsLiveView'],
        Email: json['Email'],
      );
}
