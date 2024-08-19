import 'dart:convert';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../utils/http/http_client.dart';
import '../../utils/localStorage/storage_utility.dart';


class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  Future<void> createEmployee(String userName, String userPassword, String profileTypeName) async {

      final tk = await MyLocalStorage().readData('@rs:progapp_tk');
      print('Username: $userName, Password: $userPassword, ProfileTypeName: $profileTypeName');

      Map<String, dynamic> body = {
        'name': userName,
        'password': userPassword,
        'profileTypeName': profileTypeName
      };

      await MyHttpHelper.postAuthorized('user', body, tk);
  }

  Future<void> updateEmployee(int id, String userName, String userPassword, String profileTypeName) async {
    final tk = await MyLocalStorage().readData('@rs:progapp_tk');
    print('Id: $id, Username: $userName, Password: $userPassword, ProfileTypeName: $profileTypeName');

    Map<String, dynamic> body = {
      'name': userName,
      'password': userPassword,
      'profileTypeName': profileTypeName
    };

    await MyHttpHelper.putAuthorized('user/$id', body, tk);
  }

  Future<Map<String, dynamic>> getEmployee(int id) async {
    final tk = await MyLocalStorage().readData('@rs:progapp_tk');
    final response = await MyHttpHelper.getAuthorized('user/$id', tk);
    return json.decode(response.body);
  }

  Future<dynamic> getLoggedEmployee() async {
    final tk = await MyLocalStorage().readData('@rs:progapp_tk');
    final response = await MyHttpHelper.getAuthorized('auth/account', tk);
    return json.decode(response.body);
  }

  Future<List<Map<String, dynamic>>> getAllEmployees() async {
    final tk = await MyLocalStorage().readData('@rs:progapp_tk');
    print('Token: $tk');
    final response = await MyHttpHelper.getAllAuthorized('user', tk);
    print('Response: $response.body');
    List<dynamic> employeesJson = json.decode(response.body) as List<dynamic>;
    List<Map<String, dynamic>> employees = employeesJson.map((e) => {
      'id': e['id'],
      'name': e['name'],
      'profileTypeName': e['profileTypeName']
    }).toList();
    return employees;
  }

  Future<void> deleteEmployee(int id) async {
    final tk = await MyLocalStorage().readData('@rs:progapp_tk');
    await MyHttpHelper.delete('user/$id', tk);
  }

}
