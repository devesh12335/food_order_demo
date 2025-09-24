class CreateOrderModel {
  int? id;
  int? userId;
  int? tip;
  List<Products>? products;

  CreateOrderModel({this.id, this.userId, this.tip, this.products});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    tip = json['tip'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['tip'] = this.tip;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  int? quantity;

  Products({this.id, this.name, this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    return data;
  }
}
