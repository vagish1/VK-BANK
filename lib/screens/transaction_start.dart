import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vk_bank/database/bank_db.dart';

class TransactionStart extends StatefulWidget {
  final int bankID;
  final int accountNo;
  final String columnName;
  final double amount;
  final String profileUrl;

  const TransactionStart({
    Key? key,
    required this.bankID,
    required this.accountNo,
    required this.columnName,
    required this.amount,
    required this.profileUrl,
  }) : super(key: key);

  @override
  State<TransactionStart> createState() => _TransactionStartState();
}

class _TransactionStartState extends State<TransactionStart> {
  final AudioPlayer audioPlayer = AudioPlayer();
  String transactionId = "";

  void playSuccessSound() async {
    final ByteData data = await rootBundle.load('assets/apple_pay_success.mp3');
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/apple_pay_success.mp3');
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);

    await audioPlayer.play(tempFile.uri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: FutureBuilder<int>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              playSuccessSound();
              BankDatabase.instance.updatePaymentStatus(
                  transactionId, "Success", widget.profileUrl);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    LottieBuilder.asset('assets/payment_successful.json'),
                    Text(
                      "Payment Successful",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF3c3c3c),
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Payment successfully transferred to ${widget.accountNo}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF3c3c3c),
                        fontSize: 14,
                        //fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LottieBuilder.asset('assets/failed.json'),
                      Text(
                        "Transaction failed",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF3c3c3c),
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${snapshot.error}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF3c3c3c),
                          fontSize: 14,
                          //fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    LottieBuilder.asset(
                      'assets/process.json',
                      width: 180,
                      height: 180,
                    ),
                    Text(
                      "Processing payment",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF3c3c3c),
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Please wait we are processing your request",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF3c3c3c),
                        fontSize: 14,
                        //fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.red.shade100,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/svg/warning.svg',
                                width: 24, height: 24),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Text(
                                "Please do not go back while we are processing your request",
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
          future: BankDatabase.instance.processPayment({
            BankDatabase.bankID: widget.bankID,
            BankDatabase.accountNo: widget.accountNo,
            BankDatabase.columnName: widget.columnName,
            BankDatabase.amount: widget.amount,
            BankDatabase.transactionId: transactionId = const Uuid().v1(),
            BankDatabase.time: DateTime.now().millisecondsSinceEpoch,
            BankDatabase.status: "Processing",
            BankDatabase.profilePic: widget.profileUrl,
          }),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Payment secured by VK BANK",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Your payment is under high security and are encrypted with 256 bit encryption key",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
