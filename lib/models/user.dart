import 'dart:io';
import 'package:meta/meta.dart';

class User{
  final int id;
  final String name;
  final String email;

  User({
    @required this.id,
    @required this.name,
    @required this.email,
  });

  User.fromJson(
    Map<String, dynamic> json
  ):
    this.id = json['id'],
    this.name = json['name'],
    this.email = json['email']
    ;

  Map<String, dynamic> get toJson => {
    'id':this.id,
    'name':this.name,
    'email':this.email,
  };

  User copyWith({
    double id,
    String name,
    String email
  }) => User(
    id: id??this.id,
    name: name??this.name,
    email: email??this.email
  );
}