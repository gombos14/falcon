import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';

import '../auth.dart';
import '../data.dart';
import '../data/falconAPI.dart';
import 'order_details.dart';

const Map<String, String> periodOptions = {
  '6 month': '6',
  '12 month': '12',
  '18 month': '18',
  '24 month': '24',
  'undetermined': 'undetermined'
};


class FurnitureDetailsScreen extends StatefulWidget {
  final Furniture? furniture;

  const FurnitureDetailsScreen({
    super.key,
    this.furniture,
  });

  @override
  State<FurnitureDetailsScreen> createState() => _FurnitureDetailsScreenState();
}

class _FurnitureDetailsScreenState extends State<FurnitureDetailsScreen> {
  TextEditingController periodSelect = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.furniture == null) {
      return const Scaffold(
        body: Center(
          child: Text('No furniture found.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.furniture!.title),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
                widget.furniture!.image,
                errorBuilder: (_, __, ___) =>
                  Image.network('https://picsum.photos/250'),
            ),
            const Padding(padding: EdgeInsets.all(8)),
            Text(
              widget.furniture!.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              widget.furniture!.description,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Price: ${widget.furniture!.price.toString()} \$ per month',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Padding(padding: EdgeInsets.all(16)),
            DropdownMenu<String>(
              controller: periodSelect,
              label: const Text('Select period'),
              initialSelection: periodOptions.keys.first,
              dropdownMenuEntries: periodOptions.keys.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
            const Padding(padding: EdgeInsets.all(16)),
            ElevatedButton(
              child: const Text('Order now'),
              onPressed: () async {
                var orderCreated = FalconAPI().createOrder(
                    widget.furniture!.id,
                    FalconAuth.of(context).getUserId,
                    period: periodOptions[periodSelect.text] ?? 'undetermined',
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
