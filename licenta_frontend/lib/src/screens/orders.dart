// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:bookstore/src/data/falconAPI.dart';
import 'package:flutter/material.dart';

import '../auth.dart';
import '../data/order.dart';
import '../widgets/orders_list.dart';

class OrdersScreen extends StatelessWidget {
  final String title;
  final ValueChanged<Order> onTap;
  final List<Order> orders;

  const OrdersScreen({
    required this.onTap,
    required this.orders,
    this.title = 'Orders',
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: OrderList(
          orders: orders,
          onTap: onTap,
        ),
      );

  // @override
  // Widget build(BuildContext context) =>
  //     FutureBuilder<List<Order>>(
  //       future: FalconAPI().getOrders(FalconAuth.of(context).getUserId),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //         if (snapshot.hasError) {
  //           return const Center(
  //             child: Text('Error loading orders'),
  //           );
  //         }
  //         return  Scaffold(
  //           appBar: AppBar(
  //             title: Text(title),
  //           ),
  //           body: OrderList(
  //             orders: snapshot.data!,
  //             onTap: onTap,
  //           ),
  //         );
  //       },
  //     );
}
