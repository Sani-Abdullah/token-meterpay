// External
import 'package:flutter/material.dart';

// Internal
import '../../components/record_tile.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  PurchaseHistoryScreen({Key? key}) : super(key: key);
  static const routeName = 'home:purchase-history';

  final Map<String, TextStyle> _purchaseHistoryScreenStyle = {
    'toolbar': const TextStyle(
      fontFamily: 'Abel',
      fontSize: 21,
    )
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Records',
            style: _purchaseHistoryScreenStyle['toolbar'],
          ),
        ),
        body: ListView.builder(
          //<TBD>: bringing from user records
          padding: const EdgeInsets.only(top: 4.0),
          physics: const BouncingScrollPhysics(),
          itemCount: 15,
          itemBuilder: (context, n) => RecordTile(),
        ));
  }
}
