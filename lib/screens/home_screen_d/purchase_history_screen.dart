// External
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Internal
import '../../components/record_tile.dart';
import '../../models/transaction_record.dart';
import '../../helpers/auth.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  PurchaseHistoryScreen({Key? key}) : super(key: key);
  static const routeName = 'home:purchase-history';

  final Map<String, TextStyle> _purchaseHistoryScreenStyle = {
    'toolbar': const TextStyle(
      fontFamily: 'Abel',
      fontSize: 21,
    ),
    'empty': const TextStyle(
      fontFamily: 'Abel',
      fontSize: 25,
    )
  };

  @override
  Widget build(BuildContext context) {
    final Auth _auth = Auth();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Records',
            style: _purchaseHistoryScreenStyle['toolbar'],
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(_auth.currentUser()!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final List transactions = snapshot.data!.get('transactions');
                // filter out failed transactions
                transactions.removeWhere((transaction) => transaction['message'] != 'Success');
                if (transactions.isEmpty) {
                  return Center(
                    child: Text(
                      'Records Empty',
                      style: _purchaseHistoryScreenStyle['empty'],
                    ),
                  );
                }
                return ListView.builder(
                    //Done ... <TBD>: bringing from user records
                    padding: const EdgeInsets.only(top: 4.0),
                    physics: const BouncingScrollPhysics(),
                    itemCount: transactions.length,
                    itemBuilder: (context, transactionIndex) {
                      final TransactionRecord transaction =
                          TransactionRecord.fromMap(
                              transactions[transactionIndex]);
                      return RecordTile(
                          txnRecord: TransactionRecord(
                        txnReference: transaction.txnReference,
                        token: transaction.token,
                        receiptID: transaction.receiptID,
                        units: transaction.units,
                        passed: transaction.passed,
                        message: transaction.message,
                        meterNumber: transaction.meterNumber,
                        meterName: transaction.meterName,
                        date: transaction.date,
                        priceGross: transaction.priceGross,
                        priceNet: transaction.priceNet,
                        debt: transaction.debt,
                        vat: transaction.vat,
                        serviceCharge: transaction.serviceCharge,
                        freeUnits: transaction.freeUnits,
                        paymentType: transaction.paymentType,
                        username: transaction.username,
                        address: transaction.address,
                        meterCategory: transaction.meterCategory,
                      ));
                    });
              }
            }));
  }
}
