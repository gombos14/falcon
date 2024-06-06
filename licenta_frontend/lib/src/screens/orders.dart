import 'package:flutter/material.dart';

import '../data/order.dart';
import '../widgets/orders_list.dart';

class OrdersScreen extends StatelessWidget {
  final String title;
  final ValueChanged<Order> onTap;
  final Future<List<Order>> ordersFuture;

  const OrdersScreen({
    required this.onTap,
    required this.ordersFuture,
    this.title = 'My Orders',
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: FutureBuilder<List<Order>>(
          future: ordersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final orders = snapshot.data!;

              return OrderList(
                orders: orders,
                onTap: onTap,
              );
            } else {
              return Center(child: Text('No orders found'));
            }
          },
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
