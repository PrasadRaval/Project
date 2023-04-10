import 'package:flutter/material.dart';

import '../models/product1.dart';
import 'post/detail.dart';



class ProductTile extends StatelessWidget {
  final Product1 product1;
  const ProductTile(this.product1, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: InkWell(
                    onTap:  (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => const Detail()));
                    },
                    child: Hero(
                      tag: 'Location-img',
                      child: Image.network(
                        product1.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 8),
            Text(
              product1.title,
              maxLines: 2,
              style:
              const TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w800),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text('\$${product1.price}',
                style: const TextStyle(fontSize: 32, fontFamily: 'avenir')),
          ],
        ),
      ),
    );
  }
}