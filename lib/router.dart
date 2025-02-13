import 'package:amazonclone/common/widgets/bottom_bar.dart';
import 'package:amazonclone/features/address/screens/address_screen.dart';
import 'package:amazonclone/features/admin/screens/add_product_screen.dart';
import 'package:amazonclone/features/admin/screens/admin_screen.dart';
import 'package:amazonclone/features/auth/screens/auth.dart';
import 'package:amazonclone/features/home/screens/category_deals_screen.dart';
import 'package:amazonclone/features/home/screens/home_screens.dart';
import 'package:amazonclone/features/order_detaills/screens/order_details_screen.dart';
import 'package:amazonclone/features/product_details/screens/product_details_screen.dart';
import 'package:amazonclone/features/search/screens/search_screen.dart';
import 'package:amazonclone/models/order.dart';
import 'package:amazonclone/models/products.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );

    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );
    case Add_Product_Screen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Add_Product_Screen(),
      );

    case Category_Deals_Screens.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  Category_Deals_Screens(category: category),
      );
    case SearchScreen.routeName:
      var searchQuery=routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailScreen.routeName:
      var product=routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  ProductDetailScreen(
          product: product,
        ),
      );
    case AddressScreen.routeName:
      var totalAmount=routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    case OrderDetails.routeName:
      var order=routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  OrderDetails(
          order: order,
        ),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exits!'),
          ),
        ),
      );
  }
}
