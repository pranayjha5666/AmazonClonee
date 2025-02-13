import 'package:amazonclone/common/widgets/stars.dart';
import 'package:amazonclone/models/products.dart';
import 'package:flutter/material.dart';

class SearchProductsWidget extends StatelessWidget {
  final Product product;
  const SearchProductsWidget({super.key, required this.product});



  @override
  Widget build(BuildContext context) {

    double totalRating=0;
    double avgRatings=0;
    for(int i=0;i<product.rating!.length; i++){
      totalRating+=product.rating![i].rating;
    }
    if(totalRating!=0){
      avgRatings=totalRating/product.rating!.length;
    }

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child:  Stars(
                      rating: avgRatings,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text('\$${product.price}',style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 2,),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Eligible For Free Shipping",

                    ),
                  ),
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "In Stock",
                      style:
                          TextStyle(color: Colors.teal),
                      maxLines: 2,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
