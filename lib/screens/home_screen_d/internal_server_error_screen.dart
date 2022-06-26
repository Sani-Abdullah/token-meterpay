import 'package:flutter/material.dart';

class InternalServerErrorScreen extends StatelessWidget {
  const InternalServerErrorScreen({Key? key}) : super(key: key);
  static const routeName = 'home:recharge:internal-server-error';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
              'An error occured. Please try again later ..',
              style: TextStyle(
                fontFamily: 'Abel',
                fontSize: 21,
              ),
            ),
      ),
    );
  }
}
