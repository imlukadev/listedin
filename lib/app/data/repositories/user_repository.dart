

import 'package:dio/dio.dart';

import '../model/file.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/model/user.dart';

abstract class IUserRepository{
  Future<User> findById(int id);
  Future<List<User>> findAll();
  Future<User> create(User user);
  Future<void> delete(int userId);
  Future<User> patchName(int userId, String name);
  Future<User> patchPassword(int userId, String password);
  Future<User> patchEmail(int userId, String email);
  Future<User> patchImage(int userId, File image);
  Future<User> patchIsDark(int userId, bool isDark);
  Future<User> patchIsNotificationsActive(int userId, bool isNotificationsActive);
}

class UserRepository extends IUserRepository{

  final HttpClient client;
  UserRepository(this.client);



  @override
  Future<User> create(User user) async {
    String URI = "/user";
    Map<String, dynamic> json = user.toJSON();
    Response response = await client.save(URI, json);
    // print(response.data);
    // print("response.data");
    return User.getDTO(response.data);
  }

  @override
  Future<void> delete(int userId) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<User>> findAll() async {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<User> findById(int id) async {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<User> patchEmail(int userId, String email) async {
    // TODO: implement patchEmail
    throw UnimplementedError();
  }

  @override
  Future<User> patchImage(int userId, File image) async {
    // TODO: implement patchImage
    throw UnimplementedError();
  }

  @override
  Future<User> patchIsDark(int userId, bool isDark) async {
    // TODO: implement patchIsDark
    throw UnimplementedError();
  }

  @override
  Future<User> patchIsNotificationsActive(int userId, bool isNotificationsActive) async {
    // TODO: implement patchIsNotificationsActive
    throw UnimplementedError();
  }

  @override
  Future<User> patchName(int userId, String name) async {
    // TODO: implement patchName
    throw UnimplementedError();
  }

  @override
  Future<User> patchPassword(int userId, String password) async {
    // TODO: implement patchPassword
    throw UnimplementedError();
  }



}
