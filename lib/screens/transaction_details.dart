import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vk_bank/database/bank_db.dart';

class TransactionDetails extends StatelessWidget {
  final String transactionId;
  const TransactionDetails({Key? key, required this.transactionId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_backspace_outlined,
          ),
          color: const Color(0xFF3c3c3c),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Details",
          style: GoogleFonts.poppins(
            color: const Color(0xFF3c3c3c),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: BankDatabase.instance.retrieveTransaction(transactionId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 48,
                  ),
                  CircleAvatar(
                    radius: 28,
                    backgroundImage:
                        NetworkImage(snapshot.data![BankDatabase.profilePic]),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "To ${snapshot.data![BankDatabase.columnName]}",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "\u{20B9} ${snapshot.data![BankDatabase.amount]}",
                    style: GoogleFonts.poppins(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      snapshot.data![BankDatabase.status] == 'Processing'
                          ? const CupertinoActivityIndicator()
                          : snapshot.data![BankDatabase.status] == 'Processing'
                              ? const Icon(
                                  Icons.close_rounded,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Colors.green,
                                ),
                      const SizedBox(
                        width: 12,
                      ),
                      snapshot.data![BankDatabase.status] == 'Processing'
                          ? Text(
                              "Processing payment \u2022 ${formatDateTime(snapshot.data![BankDatabase.time])}",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                //fontWeight: FontWeight.w500,
                              ),
                            )
                          : snapshot.data![BankDatabase.status] == 'Failed'
                              ? Text(
                                  'Payment Failed \u2022 ${formatDateTime(snapshot.data![BankDatabase.time])}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    //fontWeight: FontWeight.w500,
                                  ),
                                )
                              : Text(
                                  'Payment successful \u2022 ${formatDateTime(snapshot.data![BankDatabase.time])}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    //fontWeight: FontWeight.w500,
                                  ),
                                ),
                    ],
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    //padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(
                          0xFFF2f2f2,
                        ),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        Theme(
                          data: ThemeData()
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            title: Text(
                              "VK Bank PVT LTD",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                //fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              "265458745211232",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                letterSpacing: 1.0,
                                //fontWeight: FontWeight.w500,
                              ),
                            ),
                            children: [
                              ListTile(
                                title: Text(
                                  "Payment initiated",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    letterSpacing: 1.0,
                                    //fontWeight: FontWeight.w500,
                                  ),
                                ),
                                leading: const Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Colors.green,
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "Payment received by ${snapshot.data![BankDatabase.columnName]}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,

                                    //fontWeight: FontWeight.w500,
                                  ),
                                ),
                                leading: const Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Colors.green,
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "Payment Confirmed",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    letterSpacing: 1.0,
                                    //fontWeight: FontWeight.w500,
                                  ),
                                ),
                                leading: const Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 2.0,
                          thickness: 2.0,
                        ),
                        ListTile(
                          title: Text(
                            "Transaction Id",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(transactionId),
                        ),
                        ListTile(
                          title: Text(
                            "To : ${snapshot.data![BankDatabase.columnName]}",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle:
                              Text("${snapshot.data![BankDatabase.accountNo]}"),
                        ),
                        ListTile(
                          title: FutureBuilder<String>(
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    "From : ${snapshot.data}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      letterSpacing: 1.0,
                                      //fontWeight: FontWeight.w500,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "From",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                }
                              },
                              future: BankDatabase.instance.getDefaultName()),
                          subtitle: Text(
                            "265458745211232",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              letterSpacing: 1.0,
                              //fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Bank Id's",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                              "110211 -> ${snapshot.data![BankDatabase.bankID]}"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return Column(
              children: [
                SvgPicture.asset(
                  'assets/svg/warning.svg',
                  color: Colors.red,
                ),
                Text(
                  "${snapshot.error}",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );
          } else {
            return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CupertinoActivityIndicator(),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Please wait",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Fetching payment details",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      //fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  String formatDateTime(int millisecondsSince) {
    int day = DateTime.fromMillisecondsSinceEpoch(millisecondsSince).day;
    int month = DateTime.fromMillisecondsSinceEpoch(millisecondsSince).month;
    String strTransactionTime = "";
    switch (month) {
      case 1:
        strTransactionTime = "Jan";
        break;
      case 2:
        strTransactionTime = "Feb";
        break;
      case 3:
        strTransactionTime = "Mar";
        break;
      case 4:
        strTransactionTime = "Apr";
        break;
      case 5:
        strTransactionTime = "May";
        break;
      case 6:
        strTransactionTime = "Jun";
        break;
      case 7:
        strTransactionTime = "Jul";
        break;
      case 8:
        strTransactionTime = "Aug";
        break;
      case 9:
        strTransactionTime = "Sep";
        break;
      case 10:
        strTransactionTime = "Oct";
        break;
      case 11:
        strTransactionTime = "Nov";
        break;
      case 12:
        strTransactionTime = "Dec";
        break;
      default:
        break;
    }

    strTransactionTime = "$strTransactionTime $day, ";

    if (DateTime.fromMillisecondsSinceEpoch(millisecondsSince).hour >= 0 &&
        DateTime.fromMillisecondsSinceEpoch(millisecondsSince).hour <= 9) {
      strTransactionTime =
          "$strTransactionTime 0${DateTime.fromMillisecondsSinceEpoch(millisecondsSince).hour}:";
    }

    if (DateTime.fromMillisecondsSinceEpoch(millisecondsSince).hour > 9 &&
        DateTime.fromMillisecondsSinceEpoch(millisecondsSince).hour <= 12) {
      strTransactionTime =
          "$strTransactionTime ${DateTime.fromMillisecondsSinceEpoch(millisecondsSince).hour}:";
    }
    if (DateTime.fromMillisecondsSinceEpoch(millisecondsSince).hour > 12) {
      strTransactionTime =
          "$strTransactionTime ${DateTime.fromMillisecondsSinceEpoch(millisecondsSince).hour}:";
    }

    if (DateTime.fromMillisecondsSinceEpoch(millisecondsSince).minute >= 0 &&
        DateTime.fromMillisecondsSinceEpoch(millisecondsSince).minute <= 9) {
      strTransactionTime =
          "$strTransactionTime 0${DateTime.fromMillisecondsSinceEpoch(millisecondsSince).minute}";
    }
    if (DateTime.fromMillisecondsSinceEpoch(millisecondsSince).hour > 9) {
      strTransactionTime =
          "$strTransactionTime ${DateTime.fromMillisecondsSinceEpoch(millisecondsSince).minute}";
    }

    if (DateTime.fromMillisecondsSinceEpoch(millisecondsSince).hour >= 0 &&
        DateTime.fromMillisecondsSinceEpoch(millisecondsSince).hour < 12) {
      strTransactionTime = "$strTransactionTime AM";
    } else {
      strTransactionTime = "$strTransactionTime PM";
    }
    return strTransactionTime;
  }
}
