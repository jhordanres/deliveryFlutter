
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_delivery/src/models/user.dart';

class ClientProfileInfoController extends GetxController {

  User user = User.fromJson(GetStorage().read('user'));

  void signOut() {
    GetStorage().remove('user');

    Get.offNamedUntil('/', (route) => false); //ELIMINAR EL HISTOTRIAL DE PANTALLAS
  }

  void goToProfileUpdate(){
    Get.toNamed('/client/profile/update');
  }

}