// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FalconScaffold extends StatelessWidget {
  final Widget child;
  final int selectedIndex;

  const FalconScaffold({
    required this.child,
    required this.selectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);

    return Scaffold(
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        body: child,
        onDestinationSelected: (idx) {
          if (idx == 0) goRouter.go('/home/popular');
          if (idx == 1) goRouter.go('/orders');
          if (idx == 2) goRouter.go('/settings');
        },
        destinations: const [
          AdaptiveScaffoldDestination(
            title: 'Furniture',
            icon: Icons.countertops,
          ),
          AdaptiveScaffoldDestination(
            title: 'orders',
            icon: Icons.shopping_cart,
          ),
          AdaptiveScaffoldDestination(
            title: 'Settings',
            icon: Icons.settings,
          ),
        ],
      ),
    );
  }
}
