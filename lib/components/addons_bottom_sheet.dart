import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/food.dart';
import 'package:food_delivery_app/models/restauarant.dart';
import 'package:provider/provider.dart';


class AddonSelectionBottomSheet extends StatefulWidget {
  final Food food;

  const AddonSelectionBottomSheet({super.key, required this.food});

  @override
  _AddonSelectionBottomSheetState createState() =>
      _AddonSelectionBottomSheetState();
}

class _AddonSelectionBottomSheetState extends State<AddonSelectionBottomSheet> {
  List<Addon> selectedAddons = [];

  // Calculate only the add-on price separately
  double get totalAddonPrice =>
      selectedAddons.fold(0, (sum, addon) => sum + addon.price);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 400,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Customize Your Order",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Food Details
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(widget.food.imagePath,
                      height: 70, width: 70, fit: BoxFit.cover),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(widget.food.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                Text(
                  '₹${widget.food.price + totalAddonPrice}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Add-ons Selection
            Expanded(
              child: ListView(
                children: widget.food.availableAddons.map((addon) {
                  return CheckboxListTile(
                    title:
                        Text(addon.name, style: const TextStyle(fontSize: 14)),
                    subtitle: Text('₹${addon.price}',
                        style: const TextStyle(color: Colors.green)),
                    value: selectedAddons.contains(addon),
                    onChanged: (value) {
                      setState(() {
                        if (selectedAddons.contains(addon)) {
                          selectedAddons.remove(addon);
                        } else {
                          selectedAddons.add(addon);
                        }
                      });
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                  );
                }).toList(),
              ),
            ),

            // Add to Cart Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<Restauarant>(context, listen: false)
                      .addToCart(widget.food, selectedAddons);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
