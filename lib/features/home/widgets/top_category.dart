import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/home/screens/category_deals_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});


  void navigateToCategoryPage(BuildContext context,String category){
    Navigator.pushNamed(context, Category_Deals_Screens.routeName,arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 100,
        itemCount: GlobalVariables.categoryImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateToCategoryPage(context,GlobalVariables.categoryImages[index]['title']!),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      GlobalVariables.categoryImages[index]['image']!,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text( GlobalVariables.categoryImages[index]['title']!,
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),)
              ],
            ),
          );
      },
      ),

    );
  }
}
