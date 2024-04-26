// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'furniture.dart';

class Order {
  final int id;
  final int userId;
  final Furniture furniture;
  final String period;
  final double wage;
  final DateTime rentingStartsAt;

  Order({
    required this.id,
    required this.userId,
    required this.furniture,
    required this.period,
    required this.wage,
    required this.rentingStartsAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as int,
      userId: json['user'] as int,
      furniture: Furniture.fromJson(json['furniture'] as Map<String, dynamic>),
      period: json['period'] as String,
      wage: double.parse(json['wage'] as String),
      rentingStartsAt: DateTime.parse(json['renting_starts_at'] as String),
    );
  }
}
