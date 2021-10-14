class TransactionsModel {
  String name;
  String profileUrl;
  int accountNo;
  double amount;
  String transactionId;
  String status;
  int bankID;
  int transactionTime;

  TransactionsModel(this.bankID, this.profileUrl, this.accountNo, this.name,
      this.amount, this.transactionId, this.status, this.transactionTime);

  factory TransactionsModel.fromMap(Map<String, dynamic> json) {
    return TransactionsModel(
      json['BANK_ID'],
      json['PROFILE_URL'],
      json['ACCOUNT_NO'],
      json['NAME'],
      json['AMOUNT'],
      json['TRANSACTION_ID'],
      json['TRANSACTION_STATUS'],
      json['TRANSACTION_TIME'],
    );
  }
}
