// External
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Internal
import '../../components/record_tile.dart';
import '../../helpers/auth.dart';
import '../../models/transaction_record.dart';

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
          itemBuilder: (context, n) => RecordTile(
              txnRecord: const TransactionRecord(
            txnReference: 'txnRef',
            token: 'token',
            receiptID: 'receiptID',
            units: 'units',
            meterNumber: 'meterNumber',
            meterName: 'meterName',
            date: 44444444444444444,
            priceGross: '5500.43',
            priceNet: '4500.00',
            debt: 'debt',
            vat: 'vat',
            serviceCharge: 'serviceCharge',
            freeUnits: 'freeUnits',
            paymentType: 'paymentType',
            username: 'username',
            address: 'address',
            meterCategory: 'meterCategory',
          )),
        ));
  }
}
