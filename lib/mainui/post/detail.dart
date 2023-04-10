import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:project/theme/theme_constants.dart';
import 'package:project/theme/theme_manager.dart';
import 'package:project/widget/round_button.dart';
import '../../models/product.dart';


class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  @override
  void dispose() {
   _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener(){

    if(mounted){
      setState(() {

      });
    }

  }


  final ThemeManager _themeManager = ThemeManager();
  int myIndex = 0;
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
    return MaterialApp(
      theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: _themeManager.themeMode,
        home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text("Detail"),
            actions: [
              const Icon(
                  Icons.more_vert
              ),
              PopupMenuButton(
                  itemBuilder: (context) =>
                  [
                    PopupMenuItem(
                        child:Switch(
                            value: _themeManager.themeMode == ThemeMode.dark,
                            onChanged: (newValue){
                              _themeManager.toggleTheme(newValue);
                            })

                    )
                  ]
              )
            ],

          ),
          body: Column(
            children: [
              Expanded(
                child:  FutureBuilder(
                    future: getproductApi(),
                    builder:(context,snapshot){
                      if(!snapshot.hasData){
                        return const Text("Loading");
                      }else {
                        return  ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index){
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                    child: SizedBox(
                                      height: 400,
                                      width: double.infinity,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16.0)
                                        ),
                                        child: Hero(
                                          tag: 'Location-img',
                                          child: Image.network(
                                            snapshot.data![index].image.toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0)
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 10,),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(snapshot.data![index].title.toString()),
                                                ),
                                                const Expanded(
                                                    child: SizedBox(width: 0,)),
                                                Expanded(
                                                  child: Text("Price ${snapshot.data![index].price.toString()}"),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children:  [
                                                const Text("Color"),
                                                const SizedBox(height: 1,),
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: (){},
                                                    child: const CircleAvatar(
                                                      backgroundColor: Colors.brown,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 1,),
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: (){},
                                                    child: const CircleAvatar(
                                                      backgroundColor: Colors.deepOrangeAccent,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 1,),
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: (){},
                                                    child: const CircleAvatar(
                                                      backgroundColor: Colors.lightGreen,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 1,),
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: (){},
                                                    child: const CircleAvatar(
                                                      backgroundColor: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(snapshot.data![index].description.toString()),
                                          ),
                                          const SizedBox(height:30,),
                                          RoundButton(
                                              title: "Shop Now",
                                              onTap: (){})
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }
                        );
                      }
                    }
                ),
              )
            ],
          ),
        )
    );
      ;
      }
  }
