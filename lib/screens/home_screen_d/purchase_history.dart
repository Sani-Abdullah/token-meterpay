// External
import 'package:flutter/material.dart';

class PurchaseHistory extends StatelessWidget {
  const PurchaseHistory({Key? key}) : super(key: key);
  static const routeName = 'home:purchase-history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemBuilder: (context, __) => const ListTile(),
    ));
  }
}
