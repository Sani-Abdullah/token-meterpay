// External
import 'package:flutter/material.dart';

// Internal
import '../../components/record_tile.dart';
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
          itemBuilder: (context, n) => const RecordTile(
              txnRecord: TransactionRecord(
            txnReference: 'oajfe23kmkwo32m3',
            token: '2222-3333-4444-5555-6666',
            receiptID: 'oajfe23kmkwo32m3',
            units: '32.4',
            meterNumber: '4502718',
            meterName: 'work-nasrda',
            date: 44444444444444444,
            priceGross: '5500.43',
            priceNet: '4500.00',
            debt: '0.0',
            vat: '100.0',
            serviceCharge: '50.0',
            freeUnits: '0.0',
            paymentType: 'card-visa',
            username: 'Abdul',
            address: '23 Nnkisi Street, Area 11, Garki, FCT',
            meterCategory: 'trunk-c7',
          )),
        ));
  }
}
