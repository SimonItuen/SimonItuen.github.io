class OrderModel {
  String id;
  String textRef;
  String customerId;
  int amount;
  String customerPhone;
  bool success;
  bool processed;
  bool cancelled;
  String createdAt;
  String transactionId;
  String transactionTimestamp;
  List<String> vaccineIds;

  OrderModel({
    this.id = '',
    this.textRef = '',
    this.customerId = '',
    this.customerPhone = '',
    this.amount = 0,
    this.createdAt = '',
    this.transactionId = '',
    this.transactionTimestamp = '',
    this.success = false,
    this.cancelled = false,
    this.processed = false,
    this.vaccineIds = const [],
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<String> vaccineIdsList = [];
    if (json['vaccine_ids'] != null) {
      for (String i in json['vaccine_ids']) {
        vaccineIdsList.add(i.toString());
      }
    }

    return OrderModel(
      textRef: json['text_ref'].toString(),
      customerPhone: json['customer_phone'].toString(),
      customerId: json['customer_id'].toString(),
      vaccineIds: vaccineIdsList,
      amount: json['amount'],
      createdAt: json['createdAt'].toString(),
      id: json['_id'].toString(),
      transactionId: json['transaction_id'].toString(),
      transactionTimestamp: json['transaction_timestamps'].toString(),
      success: json['success'],
      processed: json['processed'],
      cancelled: json['cancelled'],
    );
  }

  Map toMap() {
    return {
      "_id": id,
      "text_ref": textRef,
      "customer_id": customerId,
      "amount": amount,
      "customer_phone": customerPhone,
      "vaccine_ids": vaccineIds,
      "success": success,
      "processed": processed,
      "cancelled": cancelled,
      "createdAt": createdAt,
      "transaction_id": transactionId,
      "transaction_timeStamp": transactionTimestamp
    };
  }
}
