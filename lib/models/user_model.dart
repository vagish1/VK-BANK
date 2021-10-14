class UserModel {
  String profile;
  int bankID;
  int accountNo;
  String name;
  double amount;

  UserModel(this.bankID, this.accountNo, this.name, this.profile, this.amount);

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      json['BANK_ID'],
      json['ACCOUNT_NO'],
      json['NAME'],
      json['PROFILE_URL'],
      json['AMOUNT'],
    );
  }
}
