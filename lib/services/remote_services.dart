import 'package:http/http.dart'as http;
import '../models/product1.dart';

class RemoteServices{

  static var client = http.Client();

  static Future<List<Product1>?> fetchProducts() async {
    var response = await client.get(
        Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return product1FromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }


}