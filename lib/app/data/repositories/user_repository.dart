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
  Future<User> login(String email, String password);
}

class UserRepository extends IUserRepository{

  final HttpClient client;
  final String path = "/user";
  UserRepository(this.client);



  @override
  Future<User> create(User user) async {
    try{
      Map<String, dynamic> json = user.toJSON();
      Response response = await client.save(path, json);
      return User.fromJSON(response.data);
    } catch (e){
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
      return usersJson.map((user) => User.fromJSON(user)).toList();
    } catch (e){
      throw Exception(e);
    }
  }

  @override
  Future<User> findById(int userId) async {
    try{
      String uri = "/$userId";
      Response response = await client.get(path+uri);
      return User.fromJSON(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<User> patchEmail(int userId, String email) async {
    try{
      String uri = "/$userId/email";
      Response response = await client.patch(path+uri, <String, dynamic>{"email": email});
      return User.fromJSON(response.data);
    } catch (e){
      throw Exception(e);
    }
  }

  @override
  Future<User> patchImage(int userId, File image) async {
    try{
      String uri = "/$userId/image";
      Response response = await client.patch(path+uri, <String, dynamic>{"image": image});
      return User.fromJSON(response.data);
    } catch (e){
      throw Exception(e);
    }
  }

  @override
  Future<User> patchIsDark(int userId, bool isDark) async {
    try{
      String uri = "/$userId/isDark";
      Response response = await client.patch(path+uri, <String, dynamic>{"isDark": isDark});
      return User.fromJSON(response.data);
    } catch (e){
      throw Exception(e);
    }
  }

  @override
  Future<User> patchIsNotificationsActive(int userId, bool isNotificationsActive) async {
    try{
      String uri = "/$userId/isNotificationsActive";
      Response response = await client.patch(path+uri, <String, dynamic>{"isNotificationsActive": isNotificationsActive});
      return User.fromJSON(response.data);
    } catch (e){
      throw Exception(e);
    }
  }

  @override
  Future<User> patchName(int userId, String name) async {
    try{
      String uri = "/$userId/name";
      Response response = await client.patch(path+uri, <String, dynamic>{"name": name});
      return User.fromJSON(response.data);
    } catch (e){
      throw Exception(e);
    }
  }

  @override
  Future<User> patchPassword(int userId, String password) async {
    try{
      String uri = "/$userId/password";
      Response response = await client.patch(path+uri, <String, dynamic>{"password": password});
      return User.fromJSON(response.data);
    } catch (e){
      throw Exception(e);
    }
  }
  
  @override
  Future<User> login(String email, String password) async {
    try{
      String uri = "/login";
      Response response = await client.save(path+uri, <String, dynamic>{"email": email, "password":password});
      return User.fromJSON(response.data);
    } catch (e){
      throw Exception(e);
    }
  }



}
