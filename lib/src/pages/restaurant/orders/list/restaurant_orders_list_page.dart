import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/restaurant/orders/list/restaurant_orders_list_controller.dart';
import 'package:get/get.dart';

class RestaurantOrdersListPage extends StatelessWidget {
  
  RestaurantOrderListController con = Get.put(RestaurantOrderListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Restaurant Orders'),
      ),
    );
  }
}