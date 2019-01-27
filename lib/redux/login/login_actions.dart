import 'dart:async';
import 'package:flutter/material.dart';

//
// middleware
//

class LogIn {
  final BuildContext context;
  final String username;
  final String password;
  final Completer<dynamic> completer;

  LogIn(this.context, this.username, this.password, {this.completer});
}

class LogOut {}

//
// actions
//

class LogInRequested  {}

class LogInSuccessful  {}

class LogInFail {}
