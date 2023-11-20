import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/providers/users_providers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  void register(BuildContext context) async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;
    String pass = passController.text;
    String confirmPass = confirmPassController.text;

    print('Email: $email');
    print('pass: $pass');

    if (isValidForm(email, name, lastName, phone, pass, confirmPass)) {

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Registrando datos...');

      User user = User(
          email: email,
          name: name,
          lastname: lastName,
          phone: phone,
          password: pass);

      Stream stream = await usersProvider.createWithImage(user,imageFile!);
      stream.listen((res) {

        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        if (responseApi.success == true) {
          GetStorage().write('user',
            responseApi.data); //ALMACENAMOS LOS DATOS DEL USUARIO EN EL STORAGE
          goToHomePage();
        }
        else {
          Get.snackbar('Registro faliido', responseApi.message ?? '');
        }
      });
    }
  }

  void goToHomePage() {
    Get.offNamedUntil('/client/products/list', (route) => false);
  }

  bool isValidForm(String email, String name, String lastName, String phone,
      String pass, String confirmPass) {
    if (email.isEmpty) {
      Get.snackbar('Formulario no valido: ', 'Debes ingresar el Email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;
    }

    if (name.isEmpty) {
      Get.snackbar('Formulario no valido: ', 'Debes ingresar tú nombre');
      return false;
    }

    if (lastName.isEmpty) {
      Get.snackbar('Formulario no valido: ', 'Debes ingresar tú apellido');
      return false;
    }

    if (phone.isEmpty) {
      Get.snackbar('Formulario no valido: ', 'Debes ingresar tú teléfono');
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

    if (confirmPass.isEmpty) {
      Get.snackbar(
          'Formulario no valido: ', 'Debes ingresar la contraseña a confirmar');
      return false;
    }

    if (pass != confirmPass) {
      Get.snackbar('Formulario no valido: ', 'Las contraseñas no conciden');
      return false;
    }

    if (imageFile == null) {
      Get.snackbar(
          'Formulario no valido', 'Debes seleccionar una imagen de perfil');
      return false;
    }
    return true;
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text(
          "GALERIA",
          style: TextStyle(color: Colors.black),
        ));
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text(
          "CAMARA",
          style: TextStyle(color: Colors.black),
        ));

    AlertDialog alertDialog = AlertDialog(
      title: Text("Selecciona una opción"),
      actions: [galleryButton, cameraButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
