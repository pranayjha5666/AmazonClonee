import 'package:amazonclone/common/widgets/loader.dart';
import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/home/services/home_services.dart';
import 'package:amazonclone/features/product_details/screens/product_details_screen.dart';
import 'package:amazonclone/models/products.dart';
import 'package:flutter/material.dart';

class Category_Deals_Screens extends StatefulWidget {
  static const String routeName = "/category-screen";
  final String category;
  const Category_Deals_Screens({super.key, required this.category});

  @override
  State<Category_Deals_Screens> createState() => _Category_Deals_ScreensState();
}

class _Category_Deals_ScreensState extends State<Category_Deals_Screens> {
  final HomeServices homeServices = HomeServices();
  List<Product>? productList;

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
              "Keep Shopping for ${widget.category}",
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: productList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final product = productList![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context, ProductDetailScreen.routeName,
                      arguments: product,
                    );
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12, width: 0.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.network(product.images[0], fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
                        child: Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}