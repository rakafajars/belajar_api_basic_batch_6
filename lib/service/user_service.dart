import 'dart:convert';

import 'package:belajar_api/model/user_model.dart';
import 'package:dio/dio.dart';

class UserService {
  static Dio dio = Dio();

  static Future<List<UserModel>> getUser() async {
    try {
      final response = await dio.get(
        'https://jsonplaceholder.typicode.com/users',
      );

      // final userDynamic = response.data as List<dynamic>;

      // cara di looping, tapi minus di element 
      // List<UserModel> userModel = [];

      // userDynamic.forEach((element) {
      //   userModel.add(
      //     UserModel(
      //       name: element["name"],
      //       username: element["username"]
      //     ),
      //   );
      // });

      // return userModel;

      // cara dengan pake from json
      // return userDynamic.map((e) => UserModel.fromJson(e)).toList();

      // pake pake decode

      final convertJsonToObject = jsonEncode(response.data);

      return userModelFromJson(convertJsonToObject);

    } catch (e) {
      throw Exception('User Error API $e');
    }
  }
}
