import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:food_delivery_app/models/cart_item.dart';

import 'food.dart';

class Restauarant extends ChangeNotifier {
  //list of food menu
  final List<Food> _menu = [
// burgers

    //VEG burger
    Food(
      name: "Veg Burger",
      description:
          "A wholesome and flavorful vegetarian burger featuring a crisp veggie patty made from fresh vegetables.",
      imagePath: "lib/images/Burger/veg_burger.png",
      price: 89,
      catagory: FoodCatagory.bugers,
      availableAddons: [
        Addon(price: 20, name: "Extra Avocado"),
        Addon(price: 30, name: "Grilled Tofu"),
        Addon(price: 35, name: "Pickled Cucumbers"),
      ],
    ),


    // Classic cheese burger
    Food(
      name: "Classic Burger",
      description: "A juicy beef patty topped with melted cheddar cheese, "
          "fresh lettuce, tomatoes.",
      imagePath: "lib/images/Burger/cheese_burger.png",
      price: 120,
      catagory: FoodCatagory.bugers,
      availableAddons: [
        Addon(price: 20, name: "Extra Cheese"),
        Addon(price: 30, name: "Jalapenos"),
        Addon(price: 35, name: "Avocado"),
      ],
    ),

    // Aloha burger
    Food(
      name: "Aloha Burger",
      description:
          "A delicious burger featuring a grilled beef patty topped with melted Swiss cheese.",
      imagePath: "lib/images/Burger/aloha_burger.png",
      price: 130,
      catagory: FoodCatagory.bugers,
      availableAddons: [
        Addon(price: 20, name: "Extra Pineapple"),
        Addon(price: 30, name: "Grilled Onions"),
        Addon(price: 35, name: "Avocado"),
      ],
    ),

    // BBq burger
    Food(
      name: "BBQ Burger",
      description:
          "A mouthwatering burger featuring a juicy beef patty smothered in smoky barbecue sauce.",
      imagePath: "lib/images/Burger/bbq_burger.png",
      price: 140,
      catagory: FoodCatagory.bugers,
      availableAddons: [
        Addon(price: 20, name: "Extra Bacon"),
        Addon(price: 30, name: "Extra BBQ Sauce"),
        Addon(price: 35, name: "Pickles"),
      ],
    ),

    // Blue moon burger
    Food(
      name: "Blue Moon Burger",
      description:
          "A unique and delicious burger with a savory beef patty, tangy blue cheese.",
      imagePath: "lib/images/Burger/blueMoon_buger.png",
      price: 150,
      catagory: FoodCatagory.bugers,
      availableAddons: [
        Addon(price: 20, name: "Extra Blue Cheese"),
        Addon(price: 30, name: "Grilled Mushrooms"),
        Addon(price: 35, name: "Caramelized Onions"),
      ],
    ),

// salads
    // Asiansesame salad
    Food(
      name: "Asiansesame salad",
      description:
          "A refreshing salad with a mix of crisp greens, crunchy carrots.",
      imagePath: "lib/images/Salad/Asiansesame_salad.jpg",
      price: 100,
      catagory: FoodCatagory.salads,
      availableAddons: [
        Addon(price: 20, name: "Crispy Noodles"),
        Addon(price: 30, name: "Extra Sesame Seeds"),
        Addon(price: 35, name: "Avocado"),
      ],
    ),

    // Caeser salad
    Food(
      name: "Caeser salad",
      description:
          "A classic Caesar salad with crisp romaine lettuce, crunchy croutons. ",
      imagePath: "lib/images/Salad/Caeser_salad.jpeg",
      price: 110,
      catagory: FoodCatagory.salads,
      availableAddons: [
        Addon(price: 20, name: "Bacon Bits"),
        Addon(price: 30, name: "Extra Parmesan"),
        Addon(price: 35, name: "Crispy Onions"),
      ],
    ),

    // Greek Salad
    Food(
      name: "Greek Salad",
      description:
          "A vibrant and healthy salad featuring crisp cucumbers, juicy tomatoes.",
      imagePath: "lib/images/Salad/Greek_salad.jpeg",
      price: 120,
      catagory: FoodCatagory.salads,
      availableAddons: [
        Addon(price: 20, name: "Extra Feta"),
        Addon(price: 30, name: "Bell Peppers"),
        Addon(price: 35, name: "Toasted Nuts"),
      ],
    ),

    // Quinoa Salad
    Food(
      name: "Quinoa Salad",
      description:
          "A nourishing salad made with fluffy quinoa, mixed greens, cherry tomatoes.",
      imagePath: "lib/images/Salad/Quinoa_salad.jpeg",
      price: 130,
      catagory: FoodCatagory.salads,
      availableAddons: [
        Addon(price: 20, name: "Extra Feta"),
        Addon(price: 30, name: "Bell Peppers"),
        Addon(price: 35, name: "Toasted Almonds"),
      ],
    ),

    // South west salad
    Food(
      name: "South West Salad",
      description:
          "A bold and flavorful salad featuring crisp romaine lettuce, black beans.",
      imagePath: "lib/images/Salad/Southwest_salad.jpeg",
      price: 150,
      catagory: FoodCatagory.salads,
      availableAddons: [
        Addon(price: 25, name: "Grilled Chicken"),
        Addon(price: 20, name: "Avocado"),
        Addon(price: 15, name: "Extra Cheese"),
      ],
    ),

// sides

    // Garlic Side
    Food(
      name: "Garlic Bread Side",
      description:
          "A delicious side dish featuring crispy, golden-brown garlic bread slices brushed with herb butter, perfect for complementing any meal.",
      imagePath: "lib/images/Sides/Garlic_sides.jpg",
      price: 100,
      catagory: FoodCatagory.sides,
      availableAddons: [
        Addon(price: 20, name: "Extra Cheese"),
        Addon(price: 15, name: "Chili Flakes"),
        Addon(price: 10, name: "Herb Butter"),
      ],
    ),

    // Loaded fries
    Food(
      name: "Loaded Fries",
      description:
          "A generous portion of crispy golden fries topped with melted cheese.",
      imagePath: "lib/images/Sides/Loaded_fries.jpeg",
      price: 99,
      catagory: FoodCatagory.sides,
      availableAddons: [
        Addon(price: 30, name: "Extra Cheese"),
        Addon(price: 25, name: "Jalapeños"),
        Addon(price: 20, name: "BBQ Sauce"),
      ],
    ),

    // mac side
    Food(
      name: "Mac Side",
      description:
          "A creamy and delicious macaroni and cheese dish made with tender pasta smothered in a rich.",
      imagePath: "lib/images/Sides/mac_sides.jpg",
      price: 110,
      catagory: FoodCatagory.sides,
      availableAddons: [
        Addon(price: 25, name: "Extra Cheese"),
        Addon(price: 30, name: "Bacon Bits"),
        Addon(price: 20, name: "Truffle Oil"),
      ],
    ),

    // onion rings
    Food(
      name: "Onion Rings",
      description:
          "Crispy and golden-brown onion rings coated in a seasoned batter, fried to perfection.",
      imagePath: "lib/images/Sides/Onion_rings.jpeg",
      price: 120,
      catagory: FoodCatagory.sides,
      availableAddons: [
        Addon(price: 15, name: "Extra Dipping Sauce"),
        Addon(price: 20, name: "Cheese Sauce"),
        Addon(price: 25, name: "Spicy Seasoning"),
      ],
    ),

    // sweet potato
    Food(
      name: "Sweet Potato Fries",
      description:
          "Deliciously crispy sweet potato fries, lightly seasoned and served .",
      imagePath: "lib/images/Sides/Sweet_potato_side.jpg",
      price: 130,
      catagory: FoodCatagory.sides,
      availableAddons: [
        Addon(price: 20, name: "Honey Mustard"),
        Addon(price: 25, name: "Cheese Sauce"),
        Addon(price: 15, name: "Cinnamon Sugar"),
      ],
    ),

// pizza

    // Margherita pizza
    Food(
      name: "Margherita Pizza",
      description:
          "A classic Italian pizza featuring a thin crust topped with rich tomato sauce.",
      imagePath: "lib/images/Pizza/Margherita_pizza.jpg",
      price: 150,
      catagory: FoodCatagory.pizza,
      availableAddons: [
        Addon(price: 30, name: "Extra Cheese"),
        Addon(price: 40, name: "Olives"),
        Addon(price: 35, name: "Cherry Tomatoes"),
      ],
    ),

    // Veggie supreme pizza
    Food(
      name: "Veggie Supreme Pizza",
      description:
          "A delightful pizza loaded with a medley of fresh vegetables, including bell peppers.",
      imagePath: "lib/images/Pizza/veggie_supreme_pizza.jpg",
      price: 280,
      catagory: FoodCatagory.pizza,
      availableAddons: [
        Addon(price: 30, name: "Extra Cheese"),
        Addon(price: 40, name: "Jalapeños"),
        Addon(price: 35, name: "Pineapple"),
      ],
    ),

    // Chicago pizza
    Food(
      name: "Chicago Pizza",
      description:
          "A hearty deep-dish pizza with a thick, buttery crust filled with layers of rich tomato sauce.",
      imagePath: "lib/images/Pizza/Chicago_pizza.png",
      price: 350,
      catagory: FoodCatagory.pizza,
      availableAddons: [
        Addon(price: 40, name: "Italian Sausage"),
        Addon(price: 50, name: "Extra Mozzarella"),
        Addon(price: 30, name: "Grilled Chicken"),
      ],
    ),

    // BBQ pizza

    Food(
      name: "BBQ Pizza",
      description:
          "A delicious pizza featuring a smoky BBQ sauce base, topped with tender grilled chicken.",
      imagePath: "lib/images/Pizza/Bbq_pizza.png",
      price: 300,
      catagory: FoodCatagory.pizza,
      availableAddons: [
        Addon(price: 40, name: "Extra BBQ Sauce"),
        Addon(price: 50, name: "Bacon Bits"),
        Addon(price: 30, name: "Grilled Mushrooms"),
      ],
    ),

    //  Four cheese pizza
    Food(
      name: "Four Cheese Pizza ",
      description:
          "A rich and flavorful pizza topped with a blend of four delicious cheeses.",
      imagePath:
          "lib/images/Pizza/Four_cheese_pizza_(Quattro _Formaggi) _pizza.png",
      price: 320,
      catagory: FoodCatagory.pizza,
      availableAddons: [
        Addon(price: 40, name: "Extra Mozzarella"),
        Addon(price: 50, name: "Grilled Chicken"),
        Addon(price: 35, name: "Olives"),
      ],
    ),

// desserts

    // chessecake
    Food(
      name: "Cheesecake",
      description:
          "A creamy and rich cheesecake with a buttery graham cracker crust.",
      imagePath: "lib/images/Desserts/Cheesecake.jpg",
      price: 180,
      catagory: FoodCatagory.desserts,
      availableAddons: [
        Addon(price: 20, name: "Chocolate Sauce"),
        Addon(price: 25, name: "Strawberry Compote"),
        Addon(price: 15, name: "Whipped Cream"),
      ],
    ),

    // Chocolate lava cake

    Food(
      name: "Chocolate Lava Cake",
      description:
          "A decadent, warm chocolate cake with a molten center of rich, gooey chocolate.",
      imagePath: "lib/images/Desserts/Chocolate_lava_cake.jpeg",
      price: 200,
      catagory: FoodCatagory.desserts,
      availableAddons: [
        Addon(price: 25, name: "Vanilla Ice Cream"),
        Addon(price: 20, name: "Chocolate Sauce"),
        Addon(price: 30, name: "Caramel Sauce"),
      ],
    ),

    // fruit tart

    Food(
      name: "Fruit Tart",
      description:
          "A delicious tart with a buttery, crisp pastry crust, filled with smooth custard.",
      imagePath: "lib/images/Desserts/Fruit_tart.jpg",
      price: 220,
      catagory: FoodCatagory.desserts,
      availableAddons: [
        Addon(price: 20, name: "Whipped Cream"),
        Addon(price: 25, name: "Chocolate Drizzle"),
        Addon(price: 15, name: "Almonds"),
      ],
    ),

    // Gulab jamun

    Food(
      name: "Gulab Jamun",
      description:
          "A popular Indian dessert made of deep-fried dough balls soaked in a fragrant rose-flavored sugar syrup.",
      imagePath: "lib/images/Desserts/Gulab_jamun.jpg",
      price: 150,
      catagory: FoodCatagory.desserts,
      availableAddons: [
        Addon(price: 20, name: "Vanilla Ice Cream"),
        Addon(price: 15, name: "Chopped Pistachios"),
        Addon(price: 25, name: "Chocolate Sauce"),
      ],
    ),

    // tiramisu

    Food(
      name: "Tiramisu",
      description:
          "A classic Italian dessert made with layers of coffee-soaked ladyfingers.",
      imagePath: "lib/images/Desserts/Tiramisu.jpg",
      price: 250,
      catagory: FoodCatagory.desserts,
      availableAddons: [
        Addon(price: 20, name: "Cocoa Powder"),
        Addon(price: 25, name: "Whipped Cream"),
        Addon(price: 30, name: "Chocolate Shavings"),
      ],
    ),

// drinks

    // iced coffee

    Food(
      name: "Iced Coffee",
      description:
          "A refreshing and energizing beverage made with chilled brewed coffee.",
      imagePath: "lib/images/Drinks/Iced_coffee.jpg",
      price: 120,
      catagory: FoodCatagory.drinks,
      availableAddons: [
        Addon(price: 20, name: "Extra Espresso Shot"),
        Addon(price: 15, name: "Vanilla Syrup"),
        Addon(price: 25, name: "Whipped Cream"),
      ],
    ),

    // Lemon mint cooler
    Food(
      name: "Lemon Mint Cooler",
      description:
          "A refreshing and tangy drink made with freshly squeezed lemon juice.",
      imagePath: "lib/images/Drinks/Lemon_mint_cooler.jpg",
      price: 100,
      catagory: FoodCatagory.drinks,
      availableAddons: [
        Addon(price: 15, name: "Extra Mint"),
        Addon(price: 10, name: "Lemon Slice"),
        Addon(price: 20, name: "Honey"),
      ],
    ),

    // mango lassi

    Food(
      name: "Mango Lassi",
      description:
          "A creamy and delicious traditional Indian yogurt-based drink made with fresh mango pulp.",
      imagePath: "lib/images/Drinks/Mango_lassi.jpeg",
      price: 130,
      catagory: FoodCatagory.drinks,
      availableAddons: [
        Addon(price: 20, name: "Honey"),
        Addon(price: 15, name: "Chia Seeds"),
        Addon(price: 25, name: "Pineapple"),
      ],
    ),

    // strawberry milk shake

    Food(
      name: "Strawberry Milkshake",
      description:
          "A creamy and indulgent milkshake made with fresh strawberries, vanilla ice cream, and milk.",
      imagePath: "lib/images/Drinks/Strawberry_milkshake.jpeg",
      price: 150,
      catagory: FoodCatagory.drinks,
      availableAddons: [
        Addon(price: 20, name: "Extra Strawberries"),
        Addon(price: 25, name: "Chocolate Syrup"),
        Addon(price: 15, name: "Whipped Cream"),
      ],
    ),

    // virgin mojito

    Food(
      name: "Virgin Mojito",
      description:
          "A refreshing mocktail made with fresh mint leaves, lime juice, sugar syrup, and soda water.",
      imagePath: "lib/images/Drinks/Virgin_mojito.jpeg",
      price: 120,
      catagory: FoodCatagory.drinks,
      availableAddons: [
        Addon(price: 15, name: "Extra Mint"),
        Addon(price: 10, name: "Lime Slices"),
        Addon(price: 20, name: "Sugar Syrup"),
      ],
    ),
  ];
  //  user Cart
  final List<CartItem> _cart = [];

  // delivery address

  String _deliveryAddress = '';
  /*  

          Getter


   */

  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;
  int get cartItemsCount => _cart.length;

/*  

          Operations
           
          
   */

  // add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    // see if there is a cart item  already with  the same food and selected addons
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if the food  items  are  the same
      bool isSameFood = item.food == food;
      // check if the  list of selected addons are the same

      bool isSameAddons =
          ListEquality().equals(item.selectedAddons, selectedAddons);
      return isSameFood && isSameAddons;
    });

    // if item is already exists , increase it's quantity
    if (cartItem != null) {
      cartItem.quantity++;
    }
    // otherwise , add a new cart item to the cart
    else {
      _cart.add(
        CartItem(
          food: food,
          selectedAddons: selectedAddons,
        ),
      );
    }
    notifyListeners();
  }

  // remove from cart

  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);
    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  // get total price of cart
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;
      for (Addon addon in cartItem.selectedAddons) {
        itemTotal = itemTotal + addon.price;
      }
      total = total + itemTotal * cartItem.quantity;
    }
    return total;
  }
  // get total number of items in cart

  int getTotalItemCount() {
    int totalItemCount = 0;
    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

  // clear cart

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // update delivery address

  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }
/*  

          helper

          

   */

  // Generate receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here your Receipt..");
    receipt.writeln();

    // Format the date to include up to seconds only
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(formattedDate);
   receipt.writeln();
    for (final cartItem in _cart) {
      receipt.writeln(
          '${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}');
      if (cartItem.selectedAddons.isNotEmpty) {
        receipt
            .writeln("   Add-ons : ${_formateAddons(cartItem.selectedAddons)}");
      }
    }

    // Calculate total price
    double totalPrice = getTotalPrice();
    double gst = totalPrice * 0.05; // 5% GST
    double deliveryCharge = 40.0; // Fixed delivery charge
    double finalAmount = totalPrice + gst + deliveryCharge;

    receipt.writeln("Total Items  :  ${getTotalItemCount()}");
    receipt.writeln("Total Price  :  ${_formatPrice(totalPrice)}");
    receipt.writeln("GST (5%)     :  ${_formatPrice(gst)}");
    receipt.writeln("Delivery Fee :  ${_formatPrice(deliveryCharge)}");
    receipt.writeln("Final Amount :  ${_formatPrice(finalAmount)}");
    receipt.writeln();
    receipt.writeln("Delivered To : $deliveryAddress");

    return receipt.toString();
  }

// Format double value into money
  String _formatPrice(double price) {
    return "Rs.${price.toStringAsFixed(2)}";
  }

// Format a list of addons into a string summary
  String _formateAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(", ");
  }
}
