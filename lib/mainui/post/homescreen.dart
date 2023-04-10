import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:project/mainui/post/detail.dart';

import '../../controller/product1_controller.dart';
import '../product_tile.dart';
import '../../models/product.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int myIndex = 0;
  final Product1Controller product1Controller = Get.put(Product1Controller());
  final auth = FirebaseAuth.instance;

  List<Product> productList = [];

  Future<List<Product>> getproductApi() async{
    final responce = await http.get(Uri.parse('https://webhook.site/79f25a82-3479-41f1-bab1-1e7c57812365'));
    var data = jsonDecode(responce.body.toString());
    if(responce.statusCode == 200){
      for(Map<String,dynamic> i in data){
        productList.add(Product.fromJson(i));
      }
      return productList;
    }else{
      return productList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getproductApi(),
                builder:(context,snapshot){
                if(!snapshot.hasData){
                  return const Text("Loading");
                }else {
                  return ListView.builder(
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height:300,
                                width:400,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0)
                                  ),
                                  child: Stack(
                                   children: [
                                     Image.network(
                                       snapshot.data![index].image.toString(),
                                       fit: BoxFit.cover,
                                     ),
                                     Column(
                                       children: [
                                         const SizedBox(
                                           height: 200,
                                         ),
                                         Row(
                                           children: [
                                             Expanded(
                                               child: Column(
                                                 children: [
                                                   (Text(snapshot.data![index].title.toString())),
                                                   (Text(snapshot.data![index].category.toString())),
                                                 ],
                                               ),
                                             ),
                                             Expanded(
                                               child: ElevatedButton(
                                                   onPressed: (){
                                                     Navigator.push(context,
                                                         MaterialPageRoute(
                                                         builder: (context) => const Detail()));
                                                   },
                                                   child: const Text("Explore"),
                                               ),
                                             )
                                           ],
                                         ),
                                       ],
                                     ),

                                   ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      });
                }
                }),
          ),
          const Text("New Arrivels",style: TextStyle(fontSize: 32),),
          Expanded(
              child: Obx(() {
                if (product1Controller.isLoading.value){
                  return const Center(child: CircularProgressIndicator());
                }else{
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: product1Controller.productlist.length,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    itemBuilder: (context, index) {
                      return ProductTile(product1Controller.productlist[index]);
                      },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                  );
                }

              })),
          BottomNavigationBar(
              backgroundColor: Colors.black,
              onTap: (ctt){
                setState(() {
                  myIndex = ctt;
                });
              },
              currentIndex: myIndex,
              items: const [
                BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    label: 'Home',
                    icon: Icon(Icons.home)),
                BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    label: "VIew",
                    icon: Icon(Icons.grid_view)),
                BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    label: "Search",
                    icon: Icon(Icons.search)),
                BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    label: "Save",
                    icon: Icon(Icons.queue_outlined)),
                BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    label: "Cart",
                    icon: Icon(Icons.shopping_cart)),
              ]
          )

        ],
      ),
    );
  }
}

