
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCatagory.values.length, vsync: this);
    _checkFirstTimeUser();
  }