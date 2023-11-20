import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/login/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  
  LoginController con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: _textDontHaveAcount(),
      ),
        body: Stack(
      children: [
        _backgroudCover(context),
        _boxForm(context),
        Column(
          children: [
            _imageCover(),
            _textName()
          ],
        )
      ],
    ));
  }

  Widget _backgroudCover(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.42,
      color: Colors.amber,
    );
  }

  Widget _textName() {
    return const Text(
      'DELIVERY MYSQL',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black
      ),
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35, left: 50, right: 50),
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
            _texFieldEmail(),
            _texFieldPassword(),
            _buttonLogin()
          ],
        ),
      ),
    );
  }

  Widget _texFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Correo electronico',
          prefixIcon: Icon(Icons.email)
        ),
      ),
    );
  }
  Widget _texFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.passController,
        obscureText: true,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Contraseña',
          prefixIcon: Icon(Icons.lock),
        ),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
        onPressed: () => con.login(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15)
        ), 
        child: Text(
          'INGRESAR',
          style: TextStyle(
            color: Colors.black
          ),
        )
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 45),
      child: Text(
        'INGRESA TU INFORMACIÓN',
        style: TextStyle(
          color: Colors.black
        ),
      ),
    );
  }

  Widget _textDontHaveAcount(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('No tienes cuenta?',
          style: TextStyle(
            fontSize: 17,
            color: Colors.black
          ),
        ),
        const SizedBox(width: 7,),
        GestureDetector(
          onTap: () =>con.goToRegisterPager(),
          child: const Text('Registrate Aquí',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.amber
            ),
          ),
        ),
      ],
    );
  }

  Widget _imageCover() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/img/delivery.png',
        width: 130,
        height: 130,
      )),
    );
  }
}
