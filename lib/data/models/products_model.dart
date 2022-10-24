class ProductModel {
  late int status;
  late String message;
  late List<dynamic> products;

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    // json['products'].forEach((v) {
    //   products.add(Products.fromJson(v));
    // });
    products = json['products'];
  }
}

class Products {
  late int id;
  late String company;
  late String name;
  late String type;
  late String price;
  late String image;
  late String description;
  bool isFavorite = false;

  Products(
    this.id,
    this.company,
    this.name,
    this.type,
    this.price,
    this.image,
    this.description,
    this.isFavorite,
  );

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    company = json['company'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
    isFavorite = json['isFavorite']?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['company'] = company;
    data['name'] = name;
    data['type'] = type;
    data['price'] = price;
    data['image'] = image;
    data['description'] = description;
    data['isFavorite'] = isFavorite;
    return data;
  }
}
