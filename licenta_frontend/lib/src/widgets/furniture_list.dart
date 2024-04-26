// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data.dart';

class FurnitureList extends StatelessWidget {
  final List<Furniture> furniture;
  final ValueChanged<Furniture>? onTap;

  const FurnitureList({
    required this.furniture,
    this.onTap,
    super.key,
  });
  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: furniture.length,
        itemBuilder: (context, index) =>
            ListTile(
              title: Text(
                furniture[index].title,
              ),
              subtitle: Text(
                furniture[index].description,
              ),
              trailing: Image.network(furniture[index].image),
              onTap: onTap != null
                  ? () => onTap!(furniture[index])
                  : null,
            ),
      );

// @override
  // Widget build(BuildContext context) =>
  //     FutureBuilder<List<Furniture>>(
  //       future: furniture,
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //         if (snapshot.hasError) {
  //           return const Center(
  //             child: Text('Error loading furniture'),
  //           );
  //         }
  //         return ListView.builder(
  //           itemCount: snapshot.data!.length,
  //           itemBuilder: (context, index) =>
  //               ListTile(
  //                 title: Text(
  //                   snapshot.data![index].title,
  //                 ),
  //                 subtitle: Text(
  //                   snapshot.data![index].description,
  //                 ),
  //                 trailing: Image.network(snapshot.data![index].image),
  //                 onTap: onTap != null
  //                     ? () => onTap!(snapshot.data![index])
  //                     : null,
  //               ),
  //         );
  //       },
  //     );
}
