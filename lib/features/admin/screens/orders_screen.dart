import 'package:amazonclone/common/widgets/loader.dart';
import 'package:amazonclone/features/accounts/widgets/single_product.dart';
import 'package:amazonclone/features/admin/services/admin_services.dart';
import 'package:amazonclone/features/order_detaills/screens/order_details_screen.dart';
import 'package:amazonclone/models/order.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final AdminServices adminServices = AdminServices();
  List<Order>? orders;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrders(context);
  }

  void fetchOrders(BuildContext context) async {
    orders = await adminServices.fetchAllOrder(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders==null ? Loader():GridView.builder(

      itemCount: orders!.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final orderData=orders![index];
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, OrderDetails.routeName,arguments: orderData);
          },
          child: SizedBox(
            height: 140,
            child: Single_Product(img: orderData.products[0].images[0],),
          ),
        );
      },
    );
  }
}
