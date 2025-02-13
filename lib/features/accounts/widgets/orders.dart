import 'package:amazonclone/common/widgets/loader.dart';
import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/accounts/services/account_services.dart';
import 'package:amazonclone/features/accounts/widgets/single_product.dart';
import 'package:amazonclone/features/order_detaills/screens/order_details_screen.dart';
import 'package:amazonclone/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
 List<Order>? order;
 final AccountServices accountServices=AccountServices();

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders();
  }

  void fetchOrders()async{
   order=await accountServices.fetchMyOrders(context: context);
   setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return order==null?const Loader():Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Your Order",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 15),
              child: Text(
                "See All",
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ),
          ],
        ),
        // listview builder to display product
        Container(
          height: 170,
          padding: EdgeInsets.only(
            left: 10,
            top: 20,
            right: 0,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: order!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetails.routeName,arguments: order![index]);
                } ,
                child: Single_Product(
                  img: order![index].products[0].images[0],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
