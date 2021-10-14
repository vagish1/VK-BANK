import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class SendTransactionEmail {
  final String email;
  final String name;
  final String subject;
  final String message;

  final String serviceId = "service_XXXX";
  final String templateID = "template_XXXX";
  final String userID = "user_XXXXX";

  //visit https://email.js to create your account and service id's

  SendTransactionEmail(
      {required this.email,
      required this.name,
      required this.subject,
      required this.message});

  Future sendTransactionAlert() async {
    final Uri uri = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final Response response = await http.post(
      uri,
      headers: {
        'Origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "service_id": serviceId,
        "template_id": templateID,
        "user_id": userID,
        "template_params": {
          "user_email": email,
          "to_name": name,
          "user_message": message,
          "user_subject": subject,
          "user_account": "265458745211232",
          "user_bankID": "110211",
        },
      }),
    );
    debugPrint(response.body);
  }
}
