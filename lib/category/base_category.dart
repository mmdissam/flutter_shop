class BaseCategory {
  String id, title;

  BaseCategory(this.id, this.title);

  BaseCategory.fromJson(Map<String, dynamic> jsonObject) {
    this.id = jsonObject['id'];
    this.title = jsonObject['title'];
  }
}
