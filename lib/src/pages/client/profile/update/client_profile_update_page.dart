import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/client/profile/update/client_profile_update_controller.dart';
import 'package:get/get.dart';

class ClientProfileUpdatePage extends StatelessWidget {
  
  ClientProfileUpdateController con = Get.put(ClientProfileUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroudCover(context),
          _boxForm(context),
          _imageUser(context),
          _buttonBack()
        ],
      ),
    );
  }

  Widget _buttonBack() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30,),
        ),
      ),
    );
  }

  Widget _backgroudCover(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.amber,
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.48,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25, left: 45, right: 45),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            blurRadius: 15,
            offset: Offset(0, 0.75)
          )
        ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _texFieldName(),
            _texFielLastName(),
            _texFielLastPhone(),
            _buttonUpdate(context)
          ],
        ),
      ),
    );
  }

  Widget _texFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: con.nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Nombre',
          prefixIcon: Icon(Icons.person)
        ),
      ),
    );
  }

  Widget _texFielLastName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: con.lastNameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Apellido',
          prefixIcon: Icon(Icons.person_outline)
        ),
      ),
    );
  }
  Widget _texFielLastPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: 'Telefono',
          prefixIcon: Icon(Icons.phone)
        ),
      ),
    );
  }

  Widget _buttonUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: ElevatedButton(
        onPressed: () => con.updateInfo(context),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15)
        ), 
        child: Text(
          'ACTUALIZAR',
          style: TextStyle(
            color: Colors.black
          ),
        )
      ),
    );
  }

  Widget _imageUser (BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () => con.showAlertDialog(context),
          child: GetBuilder<ClientProfileUpdateController> (
            builder: (value) => CircleAvatar(
            backgroundImage: con.imageFile != null 
            ? FileImage(con.imageFile!)
            : con.user.image != null 
              ? NetworkImage(con.user.image!)
              :AssetImage('assets/img/user_profile.png') as ImageProvider,
            radius: 60,
            backgroundColor: Colors.white,
          ),
          )
        ),
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 30),
      child: Text(
        'INGRESA TU INFORMACIÓN',
        style: TextStyle(
          color: Colors.black
        ),
      ),
    );
  }
}