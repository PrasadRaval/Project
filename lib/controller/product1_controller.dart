import 'package:get/state_manager.dart';
import '../models/product1.dart';
import '../services/remote_services.dart';

class Product1Controller extends GetxController {
  var isLoading = true.obs;
  var productlist = <Product1>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        productlist.value = products.cast<Product1>();
      }
    } finally {
      isLoading(false);
    }
  }
}