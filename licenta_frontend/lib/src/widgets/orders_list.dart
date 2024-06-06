import 'package:flutter/material.dart';

import '../data.dart';

class OrderList extends StatelessWidget {
  final List<Order> orders;
  final ValueChanged<Order>? onTap;

  const OrderList({
    required this.orders,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            orders[index].furniture.title,
          ),
          subtitle: Text(
            orders[index].period,
          ),
          onTap: onTap != null ? () => onTap!(orders[index]) : null,
        ),
      );
}
