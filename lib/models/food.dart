// food item

class Food {
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final FoodCatagory catagory;
  List<Addon> availableAddons;
  Food({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.catagory,
    required this.availableAddons,
  });
}

//  food catagories
 enum FoodCatagory{
   
    bugers,
    pizza,
    salads,
    sides,
    desserts,
    drinks,
 }
  // food  addons
  class Addon{

    String name;
    double price;

    Addon({
      required this.price,
      required this.name,
    });
  } 