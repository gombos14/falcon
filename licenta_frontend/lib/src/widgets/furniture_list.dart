import 'package:flutter/material.dart';

import '../data.dart';

class FurnitureList extends StatelessWidget {
  final Future<List<Furniture>> furniture;
  final ValueChanged<Furniture>? onTap;

  const FurnitureList({
    required this.furniture,
    this.onTap,
    super.key,
  });


  @override
  Widget build(BuildContext context) =>
      FutureBuilder<List<Furniture>>(
        future: furniture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading furniture'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) =>
                ListTile(
                  title: Text(
                    snapshot.data![index].title,
                  ),
                  subtitle: Text(
                    snapshot.data![index].description,
                  ),
                  trailing: Image.network(
                      snapshot.data![index].image,
                      errorBuilder: (_, __, ___) =>
                          Image.network('https://picsum.photos/250'),
                  ),
                  onTap: onTap != null
                      ? () => onTap!(snapshot.data![index])
                      : null,
                ),
          );
        },
      );
}
