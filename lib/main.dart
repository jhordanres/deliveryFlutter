import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/pages/client/products/list/client_products_list_page.dart';
import 'package:flutter_delivery/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:flutter_delivery/src/pages/client/profile/update/client_profile_update_page.dart';
import 'package:flutter_delivery/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:flutter_delivery/src/pages/home/home_controller.dart';
import 'package:flutter_delivery/src/pages/home/home_page.dart';
import 'package:flutter_delivery/src/pages/login/login_page.dart';
import 'package:flutter_delivery/src/pages/register/register_pager.dart';
import 'package:flutter_delivery/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:flutter_delivery/src/pages/roles/roles_pages.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

User userSession = User.fromJson(GetStorage().read('user')?? {});

void main() async{
  await GetStorage.init(); 
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState(){
    
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Delivery',
      debugShowCheckedModeBanner: false,
      initialRoute: userSession.id != null ? userSession.roles!.length >  1 ?'/roles': '/home' : '/client/products/list',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/roles', page: () => RolesPage()),
        GetPage(name: '/restaurant/orders/list', page: () => RestaurantOrdersListPage()),
        GetPage(name: '/delivery/orders/list', page: () => DeliveryOrdersListPage()),
        GetPage(name: '/client/products/list', page: () => ClientProductsListPage()),
        GetPage(name: '/client/profile/info', page: () => ClientProfileInfoPage()),
        GetPage(name: '/client/profile/update', page: () => ClientProfileUpdatePage()),
      ],
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: ColorScheme(
          primary: Colors.amber, 
          secondary: Colors.amberAccent, 
          brightness: Brightness.light, 
          onPrimary: Colors.grey, 
          onSecondary: Colors.grey, 
          error: Colors.grey, 
          onError: Colors.grey, 
          background: Colors.grey, 
          onBackground: Colors.grey, 
          surface: Colors.grey, 
          onSurface: Colors.grey,
        )
      ),
      navigatorKey: Get.key,
    );
  }
}