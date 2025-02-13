import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/accounts/widgets/below_app_bar.dart';
import 'package:amazonclone/features/accounts/widgets/orders.dart';
import 'package:amazonclone/features/accounts/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreens extends StatefulWidget {
  const AccountScreens({super.key});

  @override
  State<AccountScreens> createState() => _AccountScreensState();
}

class _AccountScreensState extends State<AccountScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset('assets/images/amazon_in.png',
                    width: 120, height: 45, color: Colors.black),
              ),
              Container(
                padding: EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(right: 15),
                    child: Icon(Icons.notifications_outlined),),
                    Icon(Icons.search)
                  ],
                  
                ),
              )
            ],
          ),
        ),
      ),
      body: const Column(
        children: [
          Below_App_Bar(),
          SizedBox(height: 10,),
          TopButtons(),
          SizedBox(height: 20,),
          Orders()
        ],
      ),
    );
  }
}
