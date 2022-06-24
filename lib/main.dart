// External
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// Internal
import './models/user.dart' as user_m;
import './helpers/auth.dart';
import './helpers/user_backend.dart' as user_b;
import './screens/home_screen.dart';
import './screens/authentication_screen.dart';
import './screens/home_screen_d/recharge_screen.dart';
import './screens/home_screen_d/purchase_history_screen.dart';
import './screens/home_screen_d/receipt_preview_screen.dart';
import './screens/home_screen_d/generating_token_screen.dart';
import './screens/home_screen_d/generated_token_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        FutureProvider<user_m.User?>(
          initialData: null,
          create: (_) => user_b.UserBackend().getUser(),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
        RechargeUnitsScreen.routeName: (ctx) => const RechargeUnitsScreen(),
        PurchaseHistoryScreen.routeName: (ctx) => PurchaseHistoryScreen(),
        ReceiptPreviewScreen.routeName: (ctx) => ReceiptPreviewScreen(),
        GeneratingTokenScreen.routeName: (ctx) => const GeneratingTokenScreen(),
        GeneratedTokenScreen.routeName: (ctx) => GeneratedTokenScreen(),
      },
    );
  }
}
