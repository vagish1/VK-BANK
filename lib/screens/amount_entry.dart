import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vk_bank/screens/transaction_start.dart';

class AmountEntry extends StatelessWidget {
  final int bankId;
  final int accountNo;
  final String name;
  final String profileUrl;

  final _amtController = TextEditingController();

  AmountEntry(
      {Key? key,
      required this.bankId,
      required this.accountNo,
      required this.name,
      required this.profileUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFFF2f2f2),
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          child: ListTile(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
              ),
            ),
            title: Text(
              "Bank Id",
              style: GoogleFonts.poppins(),
            ),
            subtitle: Text("$bankId"),
          ),
          preferredSize: Size(width, 60),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Paying",
                style: GoogleFonts.poppins(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(profileUrl),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                name,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                "$accountNo",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2f2f2),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                width: width / 2,
                child: TextField(
                  controller: _amtController,
                  style: GoogleFonts.montserrat(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Text(
                      "\u20B9",
                      style: GoogleFonts.montserrat(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    hintText: 'Amount',
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Color(
              0xFFF2f2f2,
            ),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                width: 40,
                height: 6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 24,
                ),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16.0,
                    ),
                    const Icon(
                      Icons.info_outline,
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: Text(
                        "Please do'nt press back when transaction is in process",
                        style: GoogleFonts.poppins(),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (double.parse(_amtController.text) > 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionStart(
                          bankID: bankId,
                          accountNo: accountNo,
                          columnName: name,
                          amount: double.parse(_amtController.text),
                          profileUrl: profileUrl,
                        ),
                      ),
                    ).then((value) {
                      Navigator.pop(context);
                    });
                    // _amtController.dispose();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter amount more than 0"),
                      ),
                    );
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 24,
                  ),
                  width: width,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    "Pay Now",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
            mainAxisSize: MainAxisSize.min,
          ),
        ),
      ),
    );
  }
}
