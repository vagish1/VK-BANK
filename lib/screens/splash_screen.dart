import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vk_bank/database/bank_db.dart';
import 'package:vk_bank/screens/default_entry.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => checkFirstStart());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  void checkFirstStart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? firstStart = preferences.getBool('FirstStart');
    if (firstStart != null) {
      if (firstStart) {
        //decoder(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const DefaultEntry();
        }));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const Home();
        }));
      }
    } else {
      //decoder(context);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return const DefaultEntry();
      }));
    }
  }

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

    // List<Map<String, dynamic>> map =
    //     await BankDatabase.instance.retreiveUsers();
    // print(map);
  }
}
