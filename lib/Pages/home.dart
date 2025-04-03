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
      body:Container(
        margin: EdgeInsets.only(top: 30.0,left:10.0,right:10.0),
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.start ,
           children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween ,
              children: [
                Text(
                  "Foodos",
                  style: AppWidget.boldTextFieldStyle(),
                ),
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(color:Colors.black,borderRadius:BorderRadius.circular(8)),
              child:Icon(Icons.shopping_cart_outlined,color: Colors.white,)
              ,
            )
              ],
            ),
            SizedBox(height: 20,),
             Text(
                  "Delicious Food",
                  style: AppWidget.HeaderTextFieldStyle(),
                ),
                    Text(
                  "Discover and Get Great Food",
                  style: AppWidget.HeaderTextFieldStyle(),
                ),
            
          ],
      
      ),),
    );
  }
}