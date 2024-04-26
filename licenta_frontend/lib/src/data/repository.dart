// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:bookstore/src/data.dart';
import 'package:bookstore/src/data/falconAPI.dart';


class FurnitureRepository {
  List<Furniture> allFurniture = [];

  void addFurniture({required Furniture furniture}) {
    allFurniture.add(furniture);
  }

  Furniture getFurniture(String id) {
    return allFurniture[int.parse(id) - 1];
  }

  List<Furniture> get popularFurniture => [
    ...allFurniture.where((furniture) => furniture.isPopular),
  ];

  List<Furniture> get newFurniture => [
    ...allFurniture.where((furniture) => furniture.isNew),
  ];

  List<Furniture> getAllFurniture() {
    FalconAPI().fetchFurniture().then((value) => allFurniture = value);
    return allFurniture;
  }
}

class OrderRepository {
  List<Order> allOrders = [];

  List<Order> getOrders(String userId) {
    return allOrders.where((order) => order.userId == int.parse(userId)).toList();
  }

  Order getOrder(String id) {
    return allOrders.where((order) => order.id == int.parse(id)).first;
  }

  List<Order> getAllOrders(int userId) {
    FalconAPI().getOrders(userId).then((value) => allOrders = value);
    return allOrders;
  }
}
