import "package:flutter/material.dart";
import "package:food_delivery_application/Widgets/widget_support.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Foodos", style: AppWidget.boldTextFieldStyle()),
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("Delicious Food", style: AppWidget.HeaderTextFieldStyle()),
            Text(
              "Discover and Get Great Food",
              style: AppWidget.LightTextFieldStyle(),
            ),
            SizedBox(height:20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Material(
              elevation:5.0 ,
              borderRadius: BorderRadius.circular(10),
  child: Container(
    padding:EdgeInsets.all(8) ,
    child: Image.asset(
      "assets/images/ice-cream-cone-100.png",
      height: 50,
      width: 50,
      fit: BoxFit.cover,
    ),
  ),
),
            Material(
              elevation:5.0 ,
              borderRadius: BorderRadius.circular(10),
  child: Container(
    padding:EdgeInsets.all(8) ,
    child: Image.asset(
      "assets/images/pizza.png",
      height: 50,
      width: 50,
      fit: BoxFit.cover,
    ),
  ),
),
            Material(
              elevation:5.0 ,
              borderRadius: BorderRadius.circular(10),
  child: Container(
    padding:EdgeInsets.all(8) ,
    child: Image.asset(
      "assets/images/salad.png",
      height: 50,
      width: 50,
      fit: BoxFit.cover,
    ),
  ),
),
            Material(
              elevation:5.0 ,
              borderRadius: BorderRadius.circular(10),
  child: Container(
    padding:EdgeInsets.all(8) ,
    child: Image.asset(
      "assets/images/burger.png",
      height: 50,
      width: 50,
      fit: BoxFit.cover,
    ),
  ),
)

              ],
            ),
          ],
        ),
      ),
    );
  }
}
