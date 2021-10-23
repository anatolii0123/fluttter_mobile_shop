import 'dart:convert';

class ModelProduct {
  String id, name, image, description, qty, price, cut_off, short_des, sellar_name, shipping_charge;
  double rating;
  ModelProduct(this.id, this.name, this.description, this.qty, this.price, this.cut_off, this.short_des, this.image, this.rating, this.sellar_name,
      this.shipping_charge);
  ModelProduct.New({
    required this.id,
    required this.name,
    required this.description,
    required this.qty,
    required this.price,
    required this.cut_off,
    required this.short_des,
    required this.image,
    required this.rating,
    required this.sellar_name,
    required this.shipping_charge,
  });

  factory ModelProduct.fromJson(Map<String, dynamic> jsonData) {
    return ModelProduct.New(
        id: jsonData['id'],
        name: jsonData['name'],
        description: jsonData['description'],
        qty: jsonData['qty'],
        price: jsonData['price'],
        cut_off: jsonData['cut_off'],
        short_des: jsonData['short_des'],
        image: jsonData['image'],
        rating: jsonData['rating'],
        sellar_name: jsonData['sellar_name'],
        shipping_charge: jsonData['shipping_charge']);
  }

  static Map<String, dynamic> toMap(ModelProduct music) => {
        'id': music.id,
        'name': music.name,
        'description': music.description,
        'qty': music.qty,
        'price': music.price,
        'cut_off': music.cut_off,
        'short_des': music.short_des,
        'image': music.image,
        'rating': music.rating,
        'sellar_name': music.sellar_name,
        'shipping_charge': music.shipping_charge,
      };
  static String encode(List<ModelProduct> musics) => json.encode(
        musics.map<Map<String, dynamic>>((music) => ModelProduct.toMap(music)).toList(),
      );

  static List<ModelProduct> decode(String musics) =>
      (json.decode(musics) as List<dynamic>).map<ModelProduct>((item) => ModelProduct.fromJson(item)).toList();
}
