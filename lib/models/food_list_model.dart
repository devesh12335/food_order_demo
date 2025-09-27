import 'package:equatable/equatable.dart';

class FoodListModel extends Equatable{
  List<FoodItem>? data;

  FoodListModel({this.data});

  FoodListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <FoodItem>[];
      json['data'].forEach((v) {
        data!.add(new FoodItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

class FoodItem extends Equatable{
  int? id;
  String? name;
  String? description;
  String? image;
  int? price;
  bool? veg;
  Rating? rating;
  String? category;

  FoodItem(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.price,
      this.veg,
      this.rating,
      this.category});

  FoodItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    veg = json['veg'];
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> foodItem = new Map<String, dynamic>();
    foodItem['id'] = this.id;
    foodItem['name'] = this.name;
    foodItem['description'] = this.description;
    foodItem['image'] = this.image;
    foodItem['price'] = this.price;
    foodItem['veg'] = this.veg;
    if (this.rating != null) {
      foodItem['rating'] = this.rating!.toJson();
    }
    foodItem['category'] = this.category;
    return foodItem;
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [id,name,description,image,price,veg,rating,category];
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['count'] = this.count;
    return data;
  }
}
