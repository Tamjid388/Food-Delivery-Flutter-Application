import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_quantity_selector.dart';
import 'package:food_delivery_app/models/cart_item.dart';
import 'package:food_delivery_app/models/restauarant.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;

  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restauarant>(
      builder: (context, restauarant, child) => Container(
        decoration: BoxDecoration(
          color:Theme.of(context).colorScheme.onBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // food image
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(cartItem.food.imagePath,
                        height: 100, width: 100),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                //  name and price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // food name
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10,),
                      child: Text(cartItem.food.name, style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      ),),
                    ),
                    // food price
                    Container(margin: EdgeInsets.only(left:15, top: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '₹${cartItem.food.price}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // increment or decrement the quantity
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 5),
                  child: MyQuantitySelector(
                    
                      quantity: cartItem.quantity,
                      food: cartItem.food,
                      onDecreament: () {
                        restauarant.removeFromCart(cartItem);
                      },
                      onIncreament: () {
                        restauarant.addToCart(
                            cartItem.food, cartItem.selectedAddons);
                      }),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            // addons
            SizedBox(
              height: cartItem.selectedAddons.isEmpty ? 0 : 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 10, right: 10),
                children: cartItem.selectedAddons
                    .map(
                      (addon) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Row(
                            children: [
                              // addon name
                              Text(addon.name),
                              // addon price
                              Text(
                                "(₹${addon.price})",
                              ),
                            ],
                          ),
                          shape: StadiumBorder(
                              side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          )),
                          onSelected: (value) {},
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
