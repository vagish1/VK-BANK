import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vk_bank/database/bank_db.dart';
import 'package:vk_bank/models/transaction_model.dart';
import 'package:vk_bank/screens/transaction_details.dart';

class AllTransactions extends StatelessWidget {
  const AllTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
          ),
          color: const Color(0xFF3c3c3c),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "All transactions",
          style: GoogleFonts.poppins(
            color: const Color(0xFF3c3c3c),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<TransactionsModel>>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 60),
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(snapshot.data!.elementAt(index).profileUrl),
                ),
                title: Text(snapshot.data!.elementAt(index).name),
                subtitle: Text(snapshot.data!.elementAt(index).status),
                trailing: Text(
                  "- \u{20B9} ${snapshot.data!.elementAt(index).amount}",
                  style: GoogleFonts.poppins(color: Colors.red),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionDetails(
                        transactionId:
                            snapshot.data!.elementAt(index).transactionId,
                      ),
                    ),
                  );
                },
              ),
              itemCount: snapshot.data!.length,
            );
          } else if (snapshot.hasError) {
            return Column(
              children: [
                const SizedBox(
                  height: 48,
                ),
                Image.asset('assets/svg/yoga.png'),
                const CupertinoActivityIndicator(),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "No transaction to show",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF3c3c3c),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "your all transaction will appear here",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF3c3c3c),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 48,
                  ),
                  Image.asset('assets/svg/yoga.png'),
                  const CupertinoActivityIndicator(),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Your transaction",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF3c3c3c),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "your all transaction will appear here",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF3c3c3c),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }
        },
        future: BankDatabase.instance.getAllTransactions(),
      ),
    );
  }
}
