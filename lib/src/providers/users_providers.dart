import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_delivery/src/environment/environment.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;

class UsersProvider extends GetConnect {
  String url = Environment.API_URL + 'api/user';

  Future<Response> create(User user) async {
    Response response = await post('$url/create', user.toJson(), headers: {
      'Content-Type': 'application/json'
    }); //ESPERAR HASTA QUE EL SERVIDOR RETORNE LA RESPUESTA
    return response;
  }

  Future<Stream> createWithImage(User user, File image) async {
    print('============Value URL_OLD============== ${Environment.API_URL_OLD}');
    Uri uri = Uri.http(Environment.API_URL_OLD,'/api/user/createWithImage');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
        'image', 
        http.ByteStream(image.openRead().cast()), 
        await image.length(),
        filename: basename(image.path)));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
        '$url/login', {'email': email, 'password': password},
        headers: {'Content-Type': 'application/json'});

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo eejecutar la petición');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}
