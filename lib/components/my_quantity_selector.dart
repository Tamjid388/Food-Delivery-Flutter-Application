import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/food.dart';

class MyQuantitySelector extends StatelessWidget {

  final  int quantity;
  final Food food;
  final VoidCallback onIncreament;
  final VoidCallback onDecreament;

  const MyQuantitySelector({
    super.key,
    required this.quantity,
    required this.food,
    required this.onIncreament,
    required this.onDecreament,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const  EdgeInsets.all(1),
      
      child: Row(
     mainAxisSize: MainAxisSize.min,
     children: [
        // decrease button
      GestureDetector(
        onTap:onDecreament,
        child: Icon(Icons.remove,
        size: 15,
        color:Theme.of(context).colorScheme.primary),
      ),

      //  quantity count
        Padding(padding: EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          width: 15,
          child: Center(
            child: Text(
              quantity.toString(),
            ),
          ),
        ),
      ),
      // increase button
      GestureDetector(
        onTap:onIncreament,
        child: Icon(Icons.add,
        size: 15,
        color:Theme.of(context).colorScheme.primary),
      ),
     ],
      ),
    );
  }
}