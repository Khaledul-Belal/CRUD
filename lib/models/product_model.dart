class Product {
  final String? id;
  final String name;
  final int code;
  final String img;
  final int qty;
  final int unitPrice;
  final int totalPrice;

  Product({
    this.id,
    required this.name,
    required this.code,
    required this.img,
    required this.qty,
    required this.unitPrice,
    required this.totalPrice,
  });

  // JSON → Product (API theke data ashle)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['ProductName'] ?? '',
      code: _toInt(json['ProductCode']),
      img: json['Img'] ?? '',
      qty: _toInt(json['Qty']),
      unitPrice: _toInt(json['UnitPrice']),
      totalPrice: _toInt(json['TotalPrice']),
    );
  }

  // Product → JSON (API te pathate hole)
  Map<String, dynamic> toJson() {
    return {
      'ProductName': name,
      'ProductCode': code,
      'Img': img,
      'Qty': qty,
      'UnitPrice': unitPrice,
      'TotalPrice': totalPrice,
    };
  }

  // Number kokhono int, double ba string hoye ashte pare, tai safe convert
  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }
}