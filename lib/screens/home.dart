import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vk_bank/database/bank_db.dart';
import 'package:vk_bank/models/user_model.dart';
import 'package:vk_bank/screens/all_transactions.dart';
import 'package:vk_bank/screens/amount_entry.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentSliderItemIndex = 1;
  bool isSearching = false;
  String searchAcc = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //decoder(context);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    currentSliderItemIndex == 0
                        ? Container(
                            width: 40,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.deepPurpleAccent,
                            ),
                          )
                        : const Icon(
                            Icons.circle,
                            size: 12,
                            color: Color(0xFFF2f2f2),
                          ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    currentSliderItemIndex == 1
                        ? Container(
                            width: 40,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.deepPurpleAccent,
                            ),
                          )
                        : const Icon(
                            Icons.circle,
                            size: 12,
                            color: Color(0xFFF2f2f2),
                          ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    currentSliderItemIndex == 2
                        ? Container(
                            width: 40,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.deepPurpleAccent,
                            ),
                          )
                        : const Icon(
                            Icons.circle,
                            size: 12,
                            color: Color(0xFFF2f2f2),
                          ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    currentSliderItemIndex == 3
                        ? Container(
                            width: 40,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.deepPurpleAccent,
                            ),
                          )
                        : const Icon(
                            Icons.circle,
                            size: 12,
                            color: Color(0xFFF2f2f2),
                          ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    currentSliderItemIndex == 4
                        ? Container(
                            width: 40,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.deepPurpleAccent,
                            ),
                          )
                        : const Icon(
                            Icons.circle,
                            size: 12,
                            color: Color(0xFFF2f2f2),
                          ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                leading: FutureBuilder<String>(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CircleAvatar(
                        backgroundColor: const Color(0xFFF2f2f2),
                        backgroundImage: NetworkImage(snapshot.data!),
                      );
                    } else {
                      return const CircleAvatar(
                        backgroundColor: Color(0xFFF2f2f2),
                        child: CupertinoActivityIndicator(),
                      );
                    }
                  },
                  future: BankDatabase.instance.getDefaultProfile(),
                ),
                subtitle: FutureBuilder<String>(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 1.0,
                        ),
                      );
                    } else {
                      return const Text("Fetching name");
                    }
                  },
                  future: BankDatabase.instance.getDefaultName(),
                ),
                title: Text(
                  "Welcome Back !!",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/svg/bell.svg',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color(0xFFF2f2f2),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  //color: const Color(0xFFF2f2f2),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/svg/back.jpg',
                        width: width,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                      FutureBuilder<double>(
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Account Balance",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "\u{20B9} ${snapshot.data!}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AllTransactions()))
                                          .then((value) => setState(() {}));
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/svg/transaction.svg',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Account Balance",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    "Fetching account balance",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        future: BankDatabase.instance.getDefaultAmount(),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder<List<UserModel>>(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    debugPrint("${snapshot.data!.length}");
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 36.0, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "My merchants",
                                style: GoogleFonts.poppins(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "All your friends appear below. This also includes your last transaction people",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemBuilder: (context, index) => ExpansionTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                snapshot.data!.elementAt(index).profile,
                              ),
                            ),
                            title: Text(
                              snapshot.data!.elementAt(index).name,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              "${snapshot.data!.elementAt(index).accountNo}",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                              ),
                            ),
                            children: [
                              ListTile(
                                leading: SvgPicture.asset(
                                    'assets/svg/identification.svg'),
                                title: Text(
                                  "Bank Identification code (BIC)",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                    "${snapshot.data!.elementAt(index).bankID}"),
                              ),
                              ListTile(
                                leading:
                                    SvgPicture.asset('assets/svg/bank.svg'),
                                title: Text(
                                  "Account Number",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                    "${snapshot.data!.elementAt(index).accountNo}"),
                              ),
                              ListTile(
                                leading:
                                    SvgPicture.asset('assets/svg/money.svg'),
                                title: Text(
                                  "Account Balance",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                    "₹ ${snapshot.data!.elementAt(index).amount}"),
                              ),
                              // ListTile(
                              //   leading: Icon(Icons.money_outlined),
                              //   title: Text("Account Balance"),
                              //   subtitle: Text(
                              //       "${snapshot.data!.elementAt(index).amount}"),
                              // ),
                            ],
                          ),
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                      ],
                    );
                  } else {
                    return const CupertinoActivityIndicator();
                  }
                },
                future: BankDatabase.instance.retreiveUsers(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 24),
        child: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              context: context,
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: 50,
                    height: 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color(0xFFF2f2f2),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 36,
                        top: 24,
                        left: 36,
                        right: 36),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.montserrat(),
                          onSubmitted: (account) {
                            setState(() {
                              isSearching = true;
                              searchAcc = account;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Account Number / Bank ID",
                            border: const OutlineInputBorder(),
                            hintText: 'Account number / Bank ID',
                            suffixIcon: Visibility(
                              child: const CupertinoActivityIndicator(),
                              visible: isSearching,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        FutureBuilder<Map<String, dynamic>>(
                          builder: (context, snapshot) {
                            searchAcc = '';
                            isSearching = false;
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        snapshot.data!['PROFILE_URL'],
                                      ),
                                    ),
                                    title: Text(snapshot.data!['NAME']),
                                    subtitle:
                                        Text("${snapshot.data!['ACCOUNT_NO']}"),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AmountEntry(
                                              bankId: snapshot.data!['BANK_ID'],
                                              accountNo:
                                                  snapshot.data!['ACCOUNT_NO'],
                                              name: snapshot.data!['NAME'],
                                              profileUrl:
                                                  snapshot.data!['PROFILE_URL'],
                                            ),
                                          )).then((value) {
                                        setState(() {});
                                      });
                                    },
                                    child: Container(
                                      width: width,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.deepPurple,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Continue',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            if (snapshot.hasError) {
                              Map<String, dynamic> err =
                                  snapshot.error as Map<String, dynamic>;
                              return Container(
                                  padding: const EdgeInsets.all(16),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                      color: err['color'],
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Row(
                                    children: [
                                      Icon(err['icon']),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                          child: Text(
                                        "${err['error']}",
                                        style: GoogleFonts.poppins(),
                                      )),
                                    ],
                                  ));
                            } else {
                              return const SizedBox();
                            }
                          },
                          future: BankDatabase.instance
                              .extractSingleUser(searchAcc),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          label: const Text("New Payment"),
          icon: const Icon(Icons.payment_outlined),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        ),
      ),
    );
  }

  Widget sliderItem(double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.network(
        'https://images.unsplash.com/photo-1633306946374-d64e9fca8734?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80',
        width: width,
        height: 180,
        fit: BoxFit.cover,
      ),
    );
  }
}
