class ModelDB {
  int transactionId;
  String typeTransaction;
  String title;
  String description;
  int totalMount;
  String refUser;
  String createdAt;

  ModelDB({this.transactionId, this.typeTransaction, this.title, this.description, this.totalMount, this.refUser, this.createdAt});
  
  Map<String, dynamic> toMap() {
    return {
      "transaction_id": transactionId,
      "transaction_type": typeTransaction,
      "transaction_title": title,
      "transaction_description": description,
      "transaction_mount": totalMount,
      "transaction_ref_user": refUser,
      "transaction_created_at": createdAt,
    };
  }
}