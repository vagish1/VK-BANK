import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vk_bank/models/transaction_model.dart';
import 'package:vk_bank/models/user_model.dart';
import 'package:vk_bank/services/send_transaction_email.dart';

class BankDatabase {
  static const String _dbName = "VKBank.db";
  static const int _dbVer = 1;

  static const String userTable = "USERS";
  static const String columnName = "NAME";
  static const String bankID = "BANK_ID";
  static const String amount = "AMOUNT";
  static const String accountNo = "ACCOUNT_NO";
  static const String profilePic = "PROFILE_URL";

  static const String transactionTable = "TRANSACTIONS";
  static const String transactionId = "TRANSACTION_ID";
  static const String status = "TRANSACTION_STATUS";
  static const String time = "TRANSACTION_TIME";

  static const Map<String, dynamic> defaultData = {
    bankID: 110211,
    columnName: "Vishal Pathak",
    accountNo: 265458745211232,
    amount: 25412551.00
  };

  static Database? _database;
  BankDatabase.init();
  static final BankDatabase instance = BankDatabase.init();

  Future<Database> initializeDb() async {
    if (_database != null) return _database!;
    _database = await initiateDb();
    return _database!;
  }

  Future<Database> initiateDb() async {
    Directory dbPath = await getApplicationDocumentsDirectory();
    return await openDatabase(join(dbPath.path, _dbName),
        version: _dbVer, onCreate: createDb);
  }

  Future<FutureOr<void>> createDb(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE $userTable(
         $profilePic TEXT,
         $bankID INTEGER PRIMARY KEY,
         $accountNo INTEGER UNIQUE NOT NULL,
         $columnName TEXT,
         $amount double
      );
    ''');

    await db.execute(''' 
      CREATE TABLE $transactionTable(
         $bankID INTEGER NOT NULL,
         $profilePic TEXT NOT NULL,
         $accountNo INTEGER NOT NULL,
         $columnName TEXT,
         $amount double,
         $transactionId TEXT NOT NULL,
         $time INTEGER,
         $status TEXT
      );
    ''');
  }

  Future<int> insertDummyData(Map<String, dynamic> row) async {
    Database db = await instance.initializeDb();
    return await db.insert(userTable, row);
  }

  Future<List<UserModel>> retreiveUsers() async {
    List<UserModel> users = [];
    Database db = await instance.initializeDb();
    await db.query(userTable).then((value) {
      value.map((e) => users.add(UserModel.fromMap(e)));
    });
    List<Map<String, dynamic>> uL = await db.query(userTable);
    debugPrint("${uL.length}");
    for (int i = 0; i < uL.length; i++) {
      users.add(UserModel.fromMap(uL.elementAt(i)));
    }
    return users;
  }

  Future<Map<String, dynamic>> extractSingleUser(String accId) async {
    Database db = await initializeDb();
    if (accId.isEmpty) {
      return Future.error({
        "error":
            "You have to enter the account no/ bank id to send payments instantly",
        "icon": Icons.info_outline,
        "color": Colors.deepPurple.shade100
      });
    }

    if (accId.length <= 6) {
      List<Map<String, dynamic>> found =
          await db.query(userTable, where: "$bankID = ?", whereArgs: [accId]);
      if (found.isEmpty) {
        return Future.error({
          "error":
              "No account is associated with this bank id, please check the number you have entered",
          "icon": Icons.warning_outlined,
          "color": Colors.redAccent.shade100
        });
      }
      return found.elementAt(0);
    } else {
      List<Map<String, dynamic>> found = await db
          .query(userTable, where: "$accountNo = ?", whereArgs: [accId]);
      if (found.isEmpty) {
        return Future.error({
          "error":
              "No account is associated with this account number, please check the number you have entered",
          "icon": Icons.warning_outlined,
          "color": Colors.redAccent.shade100
        });
      }
      return found.elementAt(0);
    }
  }

  Future<int> processPayment(Map<String, dynamic> row) async {
    await Future.delayed(const Duration(seconds: 5));
    Database db = await instance.initializeDb();
    Map<String, dynamic> paidToInfo = await extractSingleUser("${row[bankID]}");
    Map<String, dynamic> updatePaidToInfo = {
      bankID: paidToInfo[bankID],
      accountNo: paidToInfo[accountNo],
      columnName: paidToInfo[columnName],
      amount: paidToInfo[amount] + row[amount],
      profilePic: paidToInfo[profilePic],
    };
    //row[amount] += paidToInfo[amount];
    double defaultAmt = await instance.getDefaultAmount();
    if (defaultAmt < row[amount]) {
      return Future.error("Insufficient fund");
    }
    await updateRemainingAmount(defaultAmt - row[amount]);

    await db.update(userTable, updatePaidToInfo,
        where: "$bankID = ?", whereArgs: [row[bankID]]);

    //await db.update();
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setDouble('default_amount', )

    debugPrint(row[transactionId]);
    return db.insert(transactionTable, row);
  }

  void firstStartInsertDefaultData(
      Map<String, dynamic> defaultUserDetails) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(columnName, defaultUserDetails[columnName]);
    await preferences.setString(
        "Alert_Email", defaultUserDetails['Alert_Email']);
    await preferences.setDouble(amount, defaultUserDetails[amount]);
    await preferences.setInt(accountNo, 265458745211232);
    await preferences.setInt(bankID, 110211);
    await preferences.setString(profilePic, defaultUserDetails[profilePic]);
    await preferences.setBool('FirstStart', false);
  }

  Future<String> getDefaultName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(columnName)!;
  }

  Future<String> getDefaultEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('Alert_Email')!;
  }

  Future<bool> updateRemainingAmount(double amt) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setDouble(amount, amt);
  }

  Future<double> getDefaultAmount() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getDouble(amount)!;
  }

  Future<int> getDefaultBankID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(bankID)!;
  }

  Future<String> getDefaultProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(profilePic)!;
  }

  Future<int> getDefaultAccount() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(accountNo)!;
  }

  Future<List<TransactionsModel>> getAllTransactions() async {
    await Future.delayed(const Duration(seconds: 3));
    Database db = await instance.initializeDb();
    List<Map<String, dynamic>> transactionsMap =
        await db.query(transactionTable);
    if (transactionsMap.isEmpty) {
      return Future.error('No transaction history');
    }
    List<TransactionsModel> transactionModel = [];
    for (var json in transactionsMap) {
      transactionModel.add(TransactionsModel.fromMap(json));
    }
    transactionModel
        .sort((b, a) => a.transactionTime.compareTo(b.transactionTime));

    return transactionModel;
  }

  Future<Map<String, dynamic>> retrieveTransaction(String transactionID) async {
    await Future.delayed(const Duration(seconds: 3));
    Database db = await instance.initializeDb();
    // List<Map<String, dynamic>> transactions = await db.rawQuery(
    //     '''select * from $transactionTable where $transactionId=$transactionID;''');

    List<Map<String, dynamic>> transactions = await db.query(transactionTable,
        where: "$transactionId = ?", whereArgs: [transactionID]);

    if (transactions.isEmpty) {
      return Future.error('Unavialable transaction');
    }

    return transactions.elementAt(0);
  }

  void updatePaymentStatus(
      String transaction, String stus, String profileUrl) async {
    debugPrint(transaction);
    Database db = await instance.initializeDb();
    Map<String, dynamic> oldTransactionData =
        await retrieveTransaction(transaction);
    Map<String, dynamic> newTransactionData = {
      BankDatabase.bankID: oldTransactionData[bankID],
      BankDatabase.accountNo: oldTransactionData[accountNo],
      BankDatabase.columnName: oldTransactionData[columnName],
      BankDatabase.amount: oldTransactionData[amount],
      BankDatabase.transactionId: transaction,
      BankDatabase.time: oldTransactionData[time],
      //BankDatabase.status: "Processing",
      BankDatabase.profilePic: profileUrl,
      BankDatabase.status: stus,
    };

    return await db.update(transactionTable, newTransactionData,
        where: "${BankDatabase.transactionId} = ?",
        whereArgs: [
          transaction
        ]).then((value) => sendAlertMsg(
        oldTransactionData[bankID].toString(), oldTransactionData[amount]));
  }

  void sendAlertMsg(String bank, double amt) async {
    SendTransactionEmail(
            email: await getDefaultEmail(),
            name: await getDefaultName(),
            subject: "Transaction Processed successfully",
            message:
                "Your account debited with \u{20B9}$amt and transferred to $bank. If not done by you call ${"tel:XXX78XX255"} to block your account temporarily or if done by you leave this message.")
        .sendTransactionAlert();
  }
}
