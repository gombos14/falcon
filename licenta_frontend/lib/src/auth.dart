// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class FalconAuth extends ChangeNotifier {
  bool _signedIn = false;
  late int _userId;

  bool get signedIn => _signedIn;
  int get getUserId => _userId;

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    // Sign out.
    _signedIn = false;
    notifyListeners();
  }

  Future<bool> signIn(BuildContext context, String username, String password)
  async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    Map<String, dynamic> requestBody = {
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse('http://192.168.1.9:8080/authentication/login/'),
      body: requestBody,
    );

    final resp = jsonDecode(response.body);
    if (response.statusCode != 200) {
      final snackBar = SnackBar(
        content: Text('Error: ${resp['error']}'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }

    _userId = resp['user'] as int;
    _signedIn = true;
    notifyListeners();
    return _signedIn;
  }

  @override
  bool operator ==(Object other) =>
      other is FalconAuth && other._signedIn == _signedIn;

  @override
  int get hashCode => _signedIn.hashCode;

  static FalconAuth of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<FalconAuthScope>()!
      .notifier!;
}

class FalconAuthScope extends InheritedNotifier<FalconAuth> {
  const FalconAuthScope({
    required super.notifier,
    required super.child,
    super.key,
  });
}
