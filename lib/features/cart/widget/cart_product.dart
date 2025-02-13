import 'package:amazonclone/features/cart/services/cart_services.dart';
import 'package:amazonclone/features/product_details/services/product_details_services.dart';
import 'package:amazonclone/models/products.dart';
import 'package:amazonclone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {

  final ProductDetailsServices productDetailsServices=ProductDetailsServices();

  final CartServices cartServices=CartServices();

  void increasQuantity(Product product){
    productDetailsServices.addToCart(context: context, product: product);
  }

  void decreaseQuantity(Product product){
    cartServices.removeFromCart(context: context, product: product);
  }





  @override
  Widget build(BuildContext context) {
    final productCart=context.watch<UserProvider>().user.cart[widget.index];
    final product=Product.fromMap(productCart['product']);
    final quantity=productCart['quantity'];
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
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12
                ),
                child: Container(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => decreaseQuantity(product),
                          child: Container(
                            width: 35,height: 32,
                            alignment: Alignment.center,
                            child: const Icon(Icons.remove,size: 18,),

                          ),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12,width: 1.5),
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.white
                          ),
                          child: Container(
                            width: 35,height: 32,
                            alignment: Alignment.center,
                            child: Text(quantity.toString()),

                          ),
                        ),
                        InkWell(
                          onTap: () => increasQuantity(product),
                          child: Container(
                            width: 35,height: 32,
                            alignment: Alignment.center,
                            child: const Icon(Icons.add,size: 18,),

                          ),
                        ),
                      ],
                    ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
