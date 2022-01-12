import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert';

class User {
  final String? userId;
  final String? email;
  final String? password;
  final String? phone_number;
  final String? user_name;
  final String? created;
  final String? uid;
  final String? user_type;

  User({
    this.userId,
    this.email,
    this.password,
    this.phone_number,
    this.user_name,
    this.created,
    this.uid,
    this.user_type,
  });

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      userId: json['uid'],
      email: json['email'],
      password: json['password'],
      phone_number: json['phone_number'],
      user_name: json['user_name'],
      created: json['created_at'],
      uid: json['uid'],
      user_type: json['user_type'],
    );
  }
}
