class BasePayment {
  String paymentID, paymentMethod;
  double amount;
  DateTime paymentDate;

  BasePayment(
      this.paymentID, this.paymentMethod, this.amount, this.paymentDate);

  BasePayment.fromJson(Map<String, dynamic> jsonObject) {
    this.paymentID = jsonObject['payment_id'];
    this.paymentMethod = jsonObject['payment_method'];
    this.amount = jsonObject['double'];
    this.paymentDate = DateTime.parse(jsonObject['payment_date']);
  }
}
