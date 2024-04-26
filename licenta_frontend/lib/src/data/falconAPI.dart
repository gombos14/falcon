import 'dart:convert';

import 'package:bookstore/src/data.dart';
import 'package:http/http.dart' as http;

class FalconAPI {
  final String _baseUrl = 'http://192.168.1.9:8080';

  List<Furniture> parseFurniture(String responseBody) {
    final parsed =
        (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();
    return parsed.map<Furniture>((json) => Furniture.fromJson(json)).toList();
  }

  Future<List<Furniture>> fetchFurniture() async {
    final response = await http.get(Uri.parse('$_baseUrl/furniture/furniture/'));
    if (response.statusCode == 200) {
      return parseFurniture(response.body);
    } else {
      throw Exception('Failed to fetch furniture from the API');
    }
  }

  Future<bool> createOrder(int furnitureId, int userId) async {
    Map<String, String> orderData = {
      'furniture': furnitureId.toString(),
      'user': userId.toString(),
      'period': 'undetermined',
    };
    final response = await http.post(Uri.parse('$_baseUrl/order/orders/'),
        body: orderData);

    return response.statusCode == 200;
  }

  Future<List<Order>> getOrders(int userId) async {
    final response = await http.get(Uri.parse('$_baseUrl/order/orders/?user=$userId'));
    if (response.statusCode == 200) {
      final parsed = (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
      return parsed.map<Order>((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch orders from the API');
    }
  }
}
