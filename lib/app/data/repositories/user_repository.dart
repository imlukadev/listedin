

import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/file.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/model/user.dart';

abstract class IUserRepository{
  Future<User> findById(int userId);
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
  final String path = "/user";
  UserRepository(this.client);



  @override
  Future<User> create(User user) async {
    print("to aq");
    try{
      Map<String, dynamic> json = user.toJSON();
      Response response = await client.save(path, json);
      print("response.data");
      print(response.data);
      print("User.fromJson(response.data)");
      print(User.fromJson(response.data).toString());
      return User.fromJson(response.data);
    } catch (e){
      print("deu excecao");
      throw Exception(e);
    }
  }

  @override
  Future<void> delete(int userId) async {
    try{
      String uri = "/$userId";
      await client.delete(path+uri);
    } catch (e){
      throw Exception(e);
    }
  }

  @override
  Future<List<User>> findAll() async {
    try{
      Response response = await client.get(path);
      List<Map<String, dynamic>> usersJson = json.decode(response.data); 
      return usersJson.map((user) => User.getDTO(user)).toList();
    } catch (e){
      throw Exception(e);
    }
  }

  @override
  Future<User> findById(int userId) async {
    try{
      String uri = "/$userId";
      Response response = await client.get(path+uri);
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
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
