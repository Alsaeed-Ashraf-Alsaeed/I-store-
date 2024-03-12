class Product {
  String name;

  String type;

  String details;

  String price;

  String quantity;

  String imageUrl;

  String date;
  bool addedToCart=false;
  int? numOf;

  Product({
    required this.name,
    required this.type,
    required this.details,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.date,
    this.addedToCart = false,
    this.numOf = 1,
  });

  toJson() {
    return {
      'name': name,
      'type': type,
      'details': details,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'date': date,
    };
  }

  factory Product.fromJson(Map<dynamic, dynamic> e) {
    return Product(
      name: e['name'],
      type: e['type'],
      details: e['details'],
      price: e['price'],
      quantity: e['quantity'],
      imageUrl: e['imageUrl'],
      date: e['date'],
    );
  }
}
