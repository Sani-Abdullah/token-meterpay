// External
import 'package:flutter/material.dart';

// Internal
import '../../models/transaction_record.dart';

class ReceitpView extends StatelessWidget {
  const ReceitpView({
    Key? key,
    required this.txnRecord,
  }) : super(key: key);

  final TransactionRecord txnRecord;

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      DataTable(
        border: TableBorder.all(width: 0.08, color: Colors.grey),
        columns: const [
          DataColumn(
              label: Text('MeterPay.NG',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold))),
        ],
        rows: [
          DataRow(cells: [
            // DataCell(Text('1')),
            const DataCell(Text('Transaction Reference')),
            DataCell(Text(txnRecord.txnReference)),
          ]),
          DataRow(cells: [
            // DataCell(Text('5')),
            const DataCell(Text('Token')),
            DataCell(Text(txnRecord.token)),
          ]),
          DataRow(cells: [
            const DataCell(Text('Units')),
            DataCell(Text(txnRecord.units)),
          ]),
          DataRow(cells: [
            const DataCell(Text('Meter Number')),
            DataCell(Text(txnRecord.meterNumber)),
          ]),
          DataRow(cells: [
            const DataCell(Text('Meter Name')),
            DataCell(Text(txnRecord.meterName)),
          ]),
          DataRow(cells: [
            const DataCell(Text('Date')),
            DataCell(Text(txnRecord.date.toString())),
          ]),
          DataRow(cells: [
            const DataCell(Text('Price Gross')),
            DataCell(Text(txnRecord.priceGross)),
          ]),
          DataRow(cells: [
            const DataCell(Text('Price Net')),
            DataCell(Text(txnRecord.priceNet)),
          ]),
          DataRow(cells: [
            const DataCell(Text('Debt')),
            DataCell(Text(txnRecord.debt)),
          ]),
          DataRow(cells: [
            const DataCell(Text('Service Charge')),
            DataCell(Text(txnRecord.serviceCharge)),
          ]),DataRow(cells: [
            const DataCell(Text('Receipt ID')),
            DataCell(Text(txnRecord.receiptID)),
          ]),DataRow(cells: [
            const DataCell(Text('Free Units')),
            DataCell(Text(txnRecord.freeUnits)),
          ]),DataRow(cells: [
            const DataCell(Text('Payment Type')),
            DataCell(Text(txnRecord.paymentType)),
          ]),DataRow(cells: [
            const DataCell(Text('User Name')),
            DataCell(Text(txnRecord.username)),
          ]),DataRow(cells: [
            const DataCell(Text('Address')),
            DataCell(Text(txnRecord.address)),
          ]),DataRow(cells: [
            const DataCell(Text('Meter Category')),
            DataCell(Text(txnRecord.meterCategory)),
          ]),DataRow(cells: [
            const DataCell(Text('VAT')),
            DataCell(Text(txnRecord.vat)),
          ]),
        ],
      ),
    ]);
  }
}