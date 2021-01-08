import 'package:meta/meta.dart';

class User{
  final int id;
  final String name;
  final String nick;
  final String email;

  User({
    @required this.id,
    @required this.name,
    @required this.nick,
    @required this.email,
  });

  User.fromJson(
    Map<String, dynamic> json
  ):
    this.id = json['id'],
    this.name = json['name'],
    this.nick = json['nick'],
    this.email = json['email']
    ;

  Map<String, dynamic> get toJson => {
    'id':this.id,
    'name':this.name,
    'nick':this.nick,
    'email':this.email,
  };

  User copyWith({
    double id,
    String name,
    String nick,
    String email
  }) => User(
    id: id??this.id,
    name: name??this.name,
    nick: nick??this.nick,
    email: email??this.email
  );
}