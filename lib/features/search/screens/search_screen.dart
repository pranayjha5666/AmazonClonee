import 'package:amazonclone/common/widgets/loader.dart';
import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/home/widgets/adress_box.dart';
import 'package:amazonclone/features/product_details/screens/product_details_screen.dart';
import 'package:amazonclone/features/search/services/search_services.dart';
import 'package:amazonclone/features/search/widgets/search_products.dart';
import 'package:amazonclone/models/products.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search-screen";
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchServices searchServices = SearchServices();
  List<Product>? products;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSearchProducts();
  }

  fetchSearchProducts() async {
    products = await searchServices.fetchSearchProducts(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                      height: 42,
                      margin: EdgeInsets.only(left: 15),
                      child: Material(
                        borderRadius: BorderRadius.circular(7),
                        elevation: 1,
                        child: TextFormField(
                          onFieldSubmitted: navigateToSearchScreen,
                          decoration: InputDecoration(
                              prefixIcon: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.only(left: 6),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                    size: 23,
                                  ),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.only(top: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                  borderSide: BorderSide.none),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 1)),
                              hintText: "Search Amazon.in",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 17)),
                        ),
                      )),
                ),
                Container(
                  color: Colors.transparent,
                  height: 40,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.mic,
                    color: Colors.black,
                    size: 25,
                  ),
                )
              ],
            ),
          ),
        ),
        body: products == null
            ? const Loader()
            : Column(
                children: [
                  const AdressBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.symmetric(vertical: 2),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  ProductDetailScreen.routeName,
                                  arguments: products![index],
                                );
                              },
                              child: SearchProductsWidget(
                                  product: products![index])));
                    },
                  ))
                ],
              ));
  }
}
