import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/model/list.dart';

abstract class IListRepository {
  Future<ShopList> findById(int id);
  Future<List<ShopList>> findAll();
  Future<ShopList> create(int userId);
  Future<ShopList> patchName(int listId, String name);
  Future<ShopList> patchIsFavorited(int listId, bool isFavorited);
  Future<ShopList> patchLastAccess(int listId, DateTime lastAccess);
  Future<ShopList> patchPurchasedQuantity(int listId, int purchasedQuantity);
  Future<ShopList> patchSchedules(int listId, ShopList list);
  Future delete(int id);
}

class ListRepository extends IListRepository {
  final HttpClient client;
  ListRepository(this.client);

  @override
  Future<ShopList> create(int userId) async {
    try {
      Response response = await client.save("/list/user/$userId", {});
      Map<String, dynamic> list = json.decode(response.data);
      return ShopList.fromJSON(list);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future delete(int id) async {
    try {
      await client.delete("/list/$id");
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ShopList>> findAll() async {
    try {
      Response response = await client.get("/list");
      List<Map<String, dynamic>> lists = json.decode(response.data);
      return lists.map((list) => ShopList.fromJSON(list)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ShopList> findById(int id) async {
    try {
      Response response = await client.get("/list/$id");
      Map<String, dynamic> list = json.decode(response.data);
      return ShopList.fromJSON(list);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ShopList> patchIsFavorited(int listId, bool isFavorited) async {
    try {
      Response response = await client.patch(
          "/list/$listId", <String, dynamic>{"isFavorited": isFavorited});
      Map<String, dynamic> list = json.decode(response.data);
      return ShopList.fromJSON(list);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ShopList> patchLastAccess(int listId, DateTime lastAccess) async {
    try {
      Response response = await client.patch("/list/$listId",
          <String, dynamic>{"lastAccess": lastAccess.toString()});
      Map<String, dynamic> list = json.decode(response.data);
      return ShopList.fromJSON(list);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ShopList> patchName(int listId, String name) async {
    try {
      Response response =
          await client.patch("/list/$listId", <String, dynamic>{"name": name});
      Map<String, dynamic> list = json.decode(response.data);
      return ShopList.fromJSON(list);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ShopList> patchPurchasedQuantity(
      int listId, int purchasedQuantity) async {
    try {
      Response response = await client.patch("/list/$listId",
          <String, dynamic>{"purchasedQuantity": purchasedQuantity});
      Map<String, dynamic> list = json.decode(response.data);
      return ShopList.fromJSON(list);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ShopList> patchSchedules(int listId, ShopList list) async {
    Map<String, dynamic> listJSON = list.toJSON();
    try {
      Response response =
          await client.patchLists("/list/$listId", listJSON['schedulings']);
      Map<String, dynamic> list = json.decode(response.data);
      return ShopList.fromJSON(list);
    } catch (e) {
      throw Exception(e);
    }
  }
}
