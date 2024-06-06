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
              onPressed: () async {
                var orderCreated = FalconAPI().createOrder(
                    furniture!.id,
                    FalconAuth.of(context).getUserId
                );
                var message = '';
                if (await orderCreated) {
                  message = 'Order created successfully';
                }
                else {
                  message = 'Error creating order';
                }
                await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(message),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
