import 'package:amazonclone/common/widgets/loader.dart';
import 'package:amazonclone/features/home/services/home_services.dart';
import 'package:amazonclone/features/product_details/screens/product_details_screen.dart';
import 'package:amazonclone/models/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealODay extends StatefulWidget {
  const DealODay({super.key});

  @override
  State<DealODay> createState() => _DealODayState();
}

class _DealODayState extends State<DealODay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDealOfTheDay();
  }

  void fetchDealOfTheDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToProductDetailsScreen(){
    Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
              onTap: navigateToProductDetailsScreen,

              child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(top: 15, left: 10),
                      child: Text(
                        "Deal of the day",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "\$100",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: Text(
                        "Amazing Products",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images.map((e) => Image.network(
                          e,
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        ),).toList(),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "See All Deals",
                        style: TextStyle(color: Colors.cyan[800]),
                      ),
                    )
                  ],
                ),
            );
  }
}
