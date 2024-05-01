import 'package:dio/dio.dart';
import 'package:listedin/app/data/http/http_client.dart';
import 'package:listedin/app/data/model/product_list.dart';

abstract class IProductListRepository {
  Future<ProductList> create(ProductList productList);
  Future<void> delete(int productId, int listId);
  Future<ProductList> patchProductQunatity(int productId, int listId, int quantity);
}

class ProductListRepository extends IProductListRepository{

  final String root = "/productList";
  final HttpClient client;
  ProductListRepository(this.client);

  @override
  Future<ProductList> create(ProductList productList) async {
    try{
      Response response = await client.save(root, productList.toJSON());
      return ProductList.fromJSON(response.data);
    } catch (e){
      throw Exception(e);
    }
  }

  @override
  Future<void> delete(int productId, int listId) async {
    try{
      String uri = "/product/$productId/list/$listId/delete";
      await client.delete(root+uri);
    } catch (e){
      throw Exception(e);
    }
  }

  @override
  Future<ProductList> patchProductQunatity(int productId, int listId, int quantity) async {
    try{
      String uri = "/product/$productId/list/$listId/quantity";
      Response response = await client.patch(root+uri, <String, dynamic>{"quantity":quantity});
      return ProductList.fromJSON(response.data);
    } catch (e){
      throw Exception(e);
    }
  }

}