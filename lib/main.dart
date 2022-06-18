// External
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// Internal
import './helpers/auth.dart';
import './screens/home_screen.dart';
import './screens/authentication_screen.dart';
import './screens/home_screen_d/recharge_screen.dart';
import './screens/home_screen_d/purchase_history_screen.dart';
import './screens/home_screen_d/receipt_preview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = Auth();
    return MaterialApp(
      title: 'meterpay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        // appBarTheme: const AppBarTheme(
        //   titleTextStyle: TextStyle(
        //     fontFamily: 'ComicNeue',
        //     fontSize: 25.0,
        //   ),
        //   toolbarTextStyle: TextStyle(
        //     fontFamily: 'Abel',
        //     fontSize: 19,
        //   ),
        // )
      ),
      home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else {
              return StreamBuilder<User?>(
                  stream: _auth.onAuthStateChanged,
                  builder: (authCtx, authSnapshot) {
                    return (authSnapshot.hasData)
                        ? HomeScreen()
                        : const AuthenticationScreen();
                  });
            }
          }),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        RechargeUnitsScreen.routeName: (ctx) => RechargeUnitsScreen(),
        PurchaseHistoryScreen.routeName: (ctx) => PurchaseHistoryScreen(),
        ReceiptPreviewScreen.routeName: (ctx) => ReceiptPreviewScreen(),
      },
    );
  }
}
