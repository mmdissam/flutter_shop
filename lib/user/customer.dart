
import 'package:flutterappnew/order/base_order.dart';
import 'package:flutterappnew/order/order_controller.dart';
import 'package:flutterappnew/product/base_product.dart';
import 'package:flutterappnew/product/product_controller.dart';

import 'address.dart';
import 'user.dart';

class Customer extends User {
  List<BaseOrder> orders;
  List<BaseProduct> watchList;
  Address shippingAddress;
  Address billingAddress;

  Customer(
      String id,
      String firstName,
      String lastName,
      String email,
      String phone,
      String gender,
      List<BaseOrder> orders,
      List<BaseProduct> watchList,
      Address shippingAddress,
      Address billingAddress)
      : super(id, firstName, lastName, email, phone, gender) {
    this.watchList = watchList;
    this.orders = orders;
    this.shippingAddress = shippingAddress;
    this.billingAddress = billingAddress;
  }

  Customer.fromJson(Map<String, dynamic> jsonObject)
      : super(
          jsonObject['id'],
          jsonObject['first_name'],
          jsonObject['last_name'],
          jsonObject['email'],
          jsonObject['phone'],
          jsonObject['gender'],
        ) {
    this.shippingAddress = Address.formJson(jsonObject['shipping_address']);
    this.billingAddress = Address.formJson(jsonObject['billing_address']);
    ProductController.toProducts(jsonObject['watch_list']);
    OrderController.toOrders(jsonObject['orders']);
  }
}
