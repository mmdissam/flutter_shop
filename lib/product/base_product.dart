import 'package:flutterappnew/category/base_category.dart';
import 'package:flutterappnew/category/category_controller.dart';
import 'package:flutterappnew/discount/base_discount.dart';
import 'package:flutterappnew/discount/discount_controller.dart';
import 'package:flutterappnew/image/base_image.dart';
import 'package:flutterappnew/image/image_controller.dart';
import 'package:flutterappnew/product_option/base_option.dart';
import 'package:flutterappnew/tag/base_tag.dart';
import 'package:flutterappnew/tag/tag_controller.dart';

class BaseProduct {
  String id, title, description;
  double price, quantity;
  List<BaseImage> images;
  List<BaseProductOption> options;
  List<BaseCategory> categories;
  List<BaseTag> tags;
  List<BaseDiscount> discounts;

  BaseProduct(this.id, this.title, this.description, this.price, this.quantity,
      this.images, this.options, this.categories, this.tags, this.discounts);

  BaseProduct.fromJson(Map<String, dynamic> jsonObject) {
    this.id = jsonObject['id'];
    this.title = jsonObject['title'];
    this.description = jsonObject['description'];
    this.price = jsonObject['price'];
    this.quantity = jsonObject['quantity'];
    this.images = ImageController.toImages(jsonObject['images']);
    this.categories = CategoryController.toCategories(jsonObject['categories']);
    this.tags = TagController.toTags(jsonObject['tags']);
    this.discounts = DiscountController.toDiscounts(jsonObject['discounts']);
  }
}
