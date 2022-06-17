// External
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionRecord {
  final String token;
  final String units;
  final String meterNumber;
  final String meterName;
  final String date;
  final String priceGross;
  final String priceNet;
  final String debt;
  final String vat;
  final String serviceCharge;
  final String txnReference;
  final String receiptID;
  final String freeUnits;
  final String paymentType;
  final String username;
  final String address;
  final String meterCategory;

  const TransactionRecord({
    required this.token,
    required this.units,
    required this.meterNumber,
    required this.meterName,
    required this.date,
    required this.priceGross,
    required this.priceNet,
    required this.debt,
    required this.vat,
    required this.serviceCharge,
    required this.txnReference,
    required this.receiptID,
    required this.freeUnits,
    required this.paymentType,
    required this.username,
    required this.address,
    required this.meterCategory,
  });

  TransactionRecord.fromFireStore(DocumentSnapshot record)
      : txnReference = record.get('txnReference'),
        token = record.get('token'),
        units = record.get('units'),
        meterNumber = record.get('meterNumber'),
        meterName = record.get('meterName'),
        date = record.get('date'),
        priceGross = record.get('priceGross'),
        priceNet = record.get('priceNet'),
        debt = record.get('debt'),
        vat = record.get('vat'),
        serviceCharge = record.get('serviceCharge'),
        receiptID = record.get('receiptID'),
        freeUnits = record.get('freeUnits'),
        paymentType = record.get('paymentType'),
        username = record.get('username'),
        address = record.get('address'),
        meterCategory = record.get('meterCategory');
}
