
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

  // Add first-time user check and redirect to ProfileCreationPage
  Future<void> _checkFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isProfileCreated = prefs.getBool('isProfileCreated');

    if (!isProfileCreated!) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileCreationPage()),
        );
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    HomeContent(),
    CartPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        buttonBackgroundColor: Theme.of(context).colorScheme.surface,
        color: Theme.of(context).colorScheme.primary,
        items: [
          Icon(Icons.home, color: Theme.of(context).colorScheme.inversePrimary),
          Consumer<Restauarant>(
            builder: (context, restaurant, child) {
              final cartItemCount = restaurant.cart.length;
              return cartItemCount > 0
                  ? Badge(
                      label: Text(cartItemCount.toString()),
                      child: Icon(Icons.shopping_cart,
                          color: Theme.of(context).colorScheme.inversePrimary),
                    )
                  : Icon(Icons.shopping_cart,
                      color: Theme.of(context).colorScheme.inversePrimary);
            },
          ),
          Icon(Icons.person,
              color: Theme.of(context).colorScheme.inversePrimary),
          Icon(Icons.settings,
              color: Theme.of(context).colorScheme.inversePrimary),
        ],
        index: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      drawer: MyDrawer(),
      body: _pages[_index],
    );
  }
}

// ..........