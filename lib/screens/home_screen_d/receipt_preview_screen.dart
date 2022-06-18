// External
import 'package:flutter/material.dart';

class ReceiptPreviewScreen extends StatelessWidget {
  ReceiptPreviewScreen({Key? key}) : super(key: key);
  static const routeName = 'records:preview';

  final Map<String, TextStyle> _receiptPreviewScreenStyle = {
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
            'Receipt Preview',
            style: _receiptPreviewScreenStyle['toolbar'],
          ),
        ),
        body: ListView(children: <Widget>[
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
            rows: const [
              DataRow(cells: [
                // DataCell(Text('1')),
                DataCell(Text('Stephen')),
                DataCell(Text('Actor')),
              ]),
              DataRow(cells: [
                // DataCell(Text('5')),
                DataCell(Text('John')),
                DataCell(Text('Student')),
              ]),
              DataRow(cells: [
                // DataCell(Text('10')),
                DataCell(Text('Harry')),
                DataCell(Text('Leader')),
              ]),
              DataRow(cells: [
                // DataCell(Text('15')),
                DataCell(Text('Peter')),
                DataCell(Text('Scientist')),
              ]),
            ],
          ),
        ]));
  }
}
