import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Below_App_Bar extends StatelessWidget {
  const Below_App_Bar({super.key});

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context).user;
    return Container(
      decoration: BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),

      padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: 'Hello, ',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                text: user.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.black,
                ),
                )
              ]
            ),
          ),
        ],
      ),
    );
  }
}
