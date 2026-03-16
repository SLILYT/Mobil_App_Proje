import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_katalog_app/model/products_model.dart';
// import 'package:mini_katalog_app/model/products_model.dart';

class ApiSercive {
  Future<ProductsModel> fetchProducts() async {
    final response = await http.get(
      Uri.parse("https://wantapi.com/products.php"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return ProductsModel.fromJson(data);
    } else {
      throw Exception("Ürünler yüklenirken hata oldu.");
    }
  }
}


