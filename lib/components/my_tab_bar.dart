import 'package:flutter/material.dart';

import '../models/food.dart';

class MyTabBar extends StatelessWidget {

 final  TabController tabController;

  const MyTabBar({super.key,
  required this.tabController,
  });


  List<Tab> _buildCatagoryTabs() {
    return FoodCatagory.values.map((catagory){
 
    return Tab(
      
      text:catagory.toString().split('.').last,
      
    );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
    labelColor:Theme.of(context).colorScheme.inversePrimary, // Selected tab text color
    unselectedLabelColor: Theme.of(context).colorScheme.primary, // Unselected tab text color
    indicatorColor: Colors.orange, // 
      controller: tabController,
      tabs: _buildCatagoryTabs(),
    );
  }
}