import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vk_bank/database/bank_db.dart';
import 'package:vk_bank/screens/home.dart';

class DefaultEntry extends StatefulWidget {
  const DefaultEntry({Key? key}) : super(key: key);

  @override
  State<DefaultEntry> createState() => _DefaultEntryState();
}

class _DefaultEntryState extends State<DefaultEntry> {
  int profileSelected = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _bankIdController = TextEditingController();
  final TextEditingController _accountNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _bankIdController.text = '110211';
      _accountNoController.text = '265458745211232';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Default User")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose profile image",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      setState(() {
                        profileSelected = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: profileSelected == index
                          ? CircleAvatar(
                              radius: 30,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    NetworkImage(profileUrl.elementAt(index)),
                              ),
                            )
                          : CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(profileUrl.elementAt(index)),
                            ),
                    ),
                  ),
                  itemCount: 4,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Your name',
                    label: Text("Your name")),
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Your Email',
                    label: Text("Your Email")),
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Amount',
                    label: Text("Amount")),
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: _bankIdController,
                enabled: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("BankID"),
                    helperText: "110211"),
                style: GoogleFonts.poppins(),
              ),
              TextField(
                controller: _accountNoController,
                enabled: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Account Number"),
                    helperText: '265458745211232'),
                style: GoogleFonts.poppins(),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Row(
                              children: const [
                                CircularProgressIndicator(),
                                SizedBox(
                                  width: 16,
                                ),
                                Text("Creating default user")
                              ],
                            ),
                          ));
                  if (_nameController.text.isNotEmpty) {
                    if (_emailController.text.isNotEmpty) {
                      if (_amountController.text.isNotEmpty) {
                        Map<String, dynamic> defaultMap = {
                          BankDatabase.columnName: _nameController.text,
                          'Alert_Email': _emailController.text,
                          BankDatabase.amount:
                              double.parse(_amountController.text),
                          BankDatabase.profilePic:
                              profileUrl.elementAt(profileSelected),
                        };
                        BankDatabase.instance
                            .firstStartInsertDefaultData(defaultMap);
                        decoder(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please enter a valid amount")));
                        Navigator.pop(context);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please enter a valid email")));
                      Navigator.pop(context);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please enter a valid name")));
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Continue",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> profileUrl = [
    'https://images.unsplash.com/photo-1483726234545-481d6e880fc6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80',
    'https://images.unsplash.com/photo-1554126807-6b10f6f6692a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80',
    'https://images.unsplash.com/photo-1496440737103-cd596325d314?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=387&q=80',
    'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=387&q=80'
  ];
  void decoder(BuildContext context) async {
    List<Map<String, dynamic>> fakeBankers = [
      {
        "PROFILE_URL":
            "https://images.unsplash.com/photo-1519764622345-23439dd774f7?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=387&q=80",
        "BANK_ID": 110212,
        "NAME": "Ashish Sahi",
        "ACCOUNT_NO": 14526587412452,
        "AMOUNT": 87452
      },
      {
        "PROFILE_URL":
            "https://images.unsplash.com/photo-1551022372-0bdac482b9d6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=327&q=80",
        "BANK_ID": 110213,
        "NAME": "Ujjwal Kumar",
        "ACCOUNT_NO": 145265874245157,
        "AMOUNT": 9904
      },
      {
        "PROFILE_URL":
            "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=387&q=80",
        "BANK_ID": 110214,
        "NAME": "Manas Jha",
        "ACCOUNT_NO": 145265412874152,
        "AMOUNT": 7525
      },
      {
        "PROFILE_URL":
            "https://images.unsplash.com/photo-1602546005687-372f3c6455ed?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=387&q=80",
        "BANK_ID": 110215,
        "NAME": "Yash Raj",
        "ACCOUNT_NO": 145294523017820,
        "AMOUNT": 10051
      },
      {
        "PROFILE_URL":
            "https://images.indianexpress.com/2021/09/PTI09_17_2021_000215B-1.jpg",
        "BANK_ID": 110216,
        "NAME": "Narendara Modi",
        "ACCOUNT_NO": 145287427441152,
        "AMOUNT": 1002542
      },
      {
        "PROFILE_URL":
            "https://akm-img-a-in.tosshub.com/indiatoday/images/story/201807/Rahul_Gandhi_PTI.jpeg?52q77cfYvG6Cxh6aGGr25KkZC1UhKanV&size=1200:675",
        "BANK_ID": 110217,
        "NAME": "Pappu",
        "ACCOUNT_NO": 145294523017920,
        "AMOUNT": 151
      },
      {
        "PROFILE_URL":
            "https://qph.fs.quoracdn.net/main-qimg-346df649e17d9f58ad4d4ecdcc7fc79b",
        "BANK_ID": 110218,
        "NAME": "Amit shah",
        "ACCOUNT_NO": 145287452452458,
        "AMOUNT": 100242
      },
      {
        "PROFILE_URL": "https://i.aaj.tv/primary/2021/09/61485e8a962a3.jpg",
        "BANK_ID": 110219,
        "NAME": "Arnav Goswami",
        "ACCOUNT_NO": 145294523019854,
        "AMOUNT": 100
      },
      {
        "PROFILE_URL": "https://pbs.twimg.com/media/E2ybQE-VgAMzbxK.jpg",
        "BANK_ID": 110220,
        "NAME": "Sudhir chaudhary",
        "ACCOUNT_NO": 145294523098217,
        "AMOUNT": 50
      }
    ];
    int rowAffected = 0;
    for (int i = 0; i < fakeBankers.length; i++) {
      rowAffected +=
          await BankDatabase.instance.insertDummyData(fakeBankers.elementAt(i));
    }
    debugPrint("Row affected : $rowAffected");
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Home()));

    // List<Map<String, dynamic>> map =
    //     await BankDatabase.instance.retreiveUsers();
    // print(map);
  }
}
