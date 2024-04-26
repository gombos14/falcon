// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';

import '../auth.dart';
import '../data.dart';
import '../data/falconAPI.dart';
import 'order_details.dart';

class FurnitureDetailsScreen extends StatelessWidget {
  final Furniture? furniture;

  const FurnitureDetailsScreen({
    super.key,
    this.furniture,
  });

  @override
  Widget build(BuildContext context) {
    if (furniture == null) {
      return const Scaffold(
        body: Center(
          child: Text('No furniture found.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(furniture!.title),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(furniture!.image),
            Text(
              furniture!.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              furniture!.description,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Price: ${furniture!.price.toString()} \$ per month',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ElevatedButton(
              child: const Text('Order now'),
              onPressed: () {
                FalconAPI().createOrder(
                    furniture!.id,
                    FalconAuth.of(context).getUserId
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
