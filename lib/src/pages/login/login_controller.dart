import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/providers/users_providers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void goToRegisterPager() {
    Get.toNamed('/register');
  }

  void login() async {
    String email = emailController.text.trim();
    String pass = passController.text;

    print('Email: $email');
    print('pass: $pass');

    if (isValidForm(email, pass)) {
      ResponseApi responseApi = await usersProvider.login(email, pass);
      

      print('Response Api: ${responseApi.toJson()}');

      if (responseApi.success == true) {
        GetStorage().write('user',responseApi.data); //ALMACENAMOS LOS DATOS DEL USUARIO EN EL STORAGE
        //goToHomePage();
        User myUser = User.fromJson(GetStorage().read('user') ?? {});
        if (myUser.roles!.length > 1) { //SI TIENE MAS DE UN ROL
          goToRolesPage();
        } else { // SI SOLO TIENE UN ROL
          goToClientProductPage();
        }
      } else {
        Get.snackbar('Login fallido: ', responseApi.message ?? '');
      }
    }
  }

  void goToClientProductPage() {
    Get.offNamedUntil('/client/products/list', (route) => false);
  }

  void goToRolesPage() {
    Get.offNamedUntil('/roles', (route) => false);
  }

  bool isValidForm(String email, String pass) {
    if (email.isEmpty) {
      Get.snackbar('Formulario no valido: ', 'Debes ingresar el Email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;
    }

    if (pass.isEmpty) {
      Get.snackbar('Formulario no valido: ', 'Debes ingresar la contraseña');
      return false;
    }
    return true;
  }
}
