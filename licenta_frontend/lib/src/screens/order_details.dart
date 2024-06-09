import 'package:flutter/material.dart';

import '../data.dart';

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
              Image.network(
                  order.furniture.image,
                  errorBuilder: (_, __, ___) =>
                    Image.network('https://picsum.photos/250'),
              ),
              Text(
                order.furniture.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                order.furniture.description,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Period: ${order.period}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Monthly Wage: ${order.wage.toString()}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Starting from: ${order.rentingStartsAt.toString()}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      );
}
