class OrderListModel {
  List<Order>? data;

  OrderListModel({this.data});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Order>[];
      json['data'].forEach((v) {
        data!.add(new Order.fromJson(v));
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
}

class Order {
  int? orderId;
  int? userId;
  List<Products>? products;
  int? totalAmount;
  String? orderDate;
  String? status;
  String? deliveryAddress;
  String? paymentMethod;
  String? deliveryTime;

  Order(
      {this.orderId,
      this.userId,
      this.products,
      this.totalAmount,
      this.orderDate,
      this.status,
      this.deliveryAddress,
      this.paymentMethod,
      this.deliveryTime});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    userId = json['userId'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    totalAmount = json['totalAmount'];
    orderDate = json['orderDate'];
    status = json['status'];
    deliveryAddress = json['deliveryAddress'];
    paymentMethod = json['paymentMethod'];
    deliveryTime = json['deliveryTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['userId'] = this.userId;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['totalAmount'] = this.totalAmount;
    data['orderDate'] = this.orderDate;
    data['status'] = this.status;
    data['deliveryAddress'] = this.deliveryAddress;
    data['paymentMethod'] = this.paymentMethod;
    data['deliveryTime'] = this.deliveryTime;
    return data;
  }
}

class Products {
  int? id;
  String? name;
  int? quantity;
  int? price;
  int? totalPrice;

  Products({this.id, this.name, this.quantity, this.price, this.totalPrice});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}
