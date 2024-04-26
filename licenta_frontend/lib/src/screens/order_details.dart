// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data.dart';
import '../data/repository.dart';
import '../widgets/furniture_list.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(order.furniture.title),
        ),
        body: Center(
          child: Column(
            children: [
              Image.network(order.furniture.image),
              Text(
                order.furniture.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                order.furniture.description,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      );
}
