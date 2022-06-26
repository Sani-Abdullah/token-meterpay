import 'package:flutter/material.dart';

class GeneratingTokenScreen extends StatelessWidget {
  const GeneratingTokenScreen({Key? key}) : super(key: key);
  static const routeName = 'home:recharge:genrating-token';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Generating Token ..',
              style: TextStyle(
                fontFamily: 'Abel',
                fontSize: 21,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
