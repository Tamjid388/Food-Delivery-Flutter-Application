import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/restauarant.dart';
import 'package:provider/provider.dart';

class MyCurrentLocation extends StatelessWidget {
  MyCurrentLocation({super.key});

  // TextEditingController to handle user input
  final TextEditingController textController = TextEditingController();

  void openLocationSearchBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        // Get current restaurant instance
        final restaurant = context.read<Restauarant>();

        return AlertDialog(
          title: const Text('Your Location'),
          content: TextField(
            controller: textController, // Attach controller
            decoration: const InputDecoration(
              hintText: "Enter Address..",
            ),
            onChanged: (value) {
              // Dynamically update the address as the user types
              restaurant.updateDeliveryAddress(value.trim());
            },
          ),
          actions: [
            // Cancel button
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                textController.clear();
              },
              child: const Text("Cancel"),
            ),
            // Save button
            TextButton(
              onPressed: () {
                String newAddress = textController.text.trim();

                if (newAddress.isNotEmpty) {
                  restaurant.updateDeliveryAddress(newAddress);
                }

                Navigator.pop(context);
                textController.clear();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on,
                  color: Theme.of(context).colorScheme.inversePrimary),
              SizedBox(
                width: 5,
              ),
              Text(
                "Deliver now",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => openLocationSearchBox(context),
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                // Consumer to update UI when address changes
                Consumer<Restauarant>(
                  builder: (context, restaurant, child) => Text(
                    restaurant.deliveryAddress.isEmpty
                        ? "Enter Address" // Placeholder if empty
                        : restaurant.deliveryAddress,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
