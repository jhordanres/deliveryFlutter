import 'dart:io';

import 'package:flutter_delivery/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class ClientProfileUpdateController extends GetxController {
  User user = User.fromJson(GetStorage().read('user'));

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  ClientProfileUpdateController() {
    nameController.text = user.name ?? '';
    lastNameController.text = user.lastname ?? '';
    phoneController.text = user.phone ?? '';
  }

  void updateInfo(BuildContext context) async {
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;

    

    if (isValidForm(name, lastName, phone)) {

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Actualizando datos...');

      User myUser = User(
        id: user.id,
          name: name,
          lastname: lastName,
          phone: phone,);

      /*
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
      */
    }
  }

  bool isValidForm(String name, String lastName, String phone) {
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
