import 'base_cart_item.dart';

class BaseCartItemController {
  List<BaseCartItem> items;

  BaseCartItemController(this.items);

  static List<BaseCartItem> toBaseCartItems(
      List<Map<String, dynamic>> jsonObject) {}
}
