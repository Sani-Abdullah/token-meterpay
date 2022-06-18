// External
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';

// Internal
import '../models/transaction_record.dart';
import '../screens/home_screen_d/receipt_preview_screen.dart';

class RecordTile extends StatelessWidget {
  final Map<String, TextStyle> _recordTileStyle = {
    'token': const TextStyle(
      fontFamily: 'PTSans',
      fontSize: 22,
    ),
    'reference': const TextStyle(
      fontFamily: 'Abel',
      fontSize: 15,
    ),
    'date': const TextStyle(
      fontFamily: 'Abel',
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ),
    'price': const TextStyle(
      fontFamily: 'PTSans',
      fontSize: 15,
    ),
  };

  final TransactionRecord txnRecord;

  RecordTile({Key? key, required this.txnRecord}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(
        // fit: StackFit.expand,
        children: [
          DetailsView(recordTileStyle: _recordTileStyle, txnRecord: txnRecord),
          OptionsView(txnRecord: txnRecord),
        ],
      ),
    );
  }
}

class OptionsView extends StatelessWidget {
  final TransactionRecord txnRecord;
  const OptionsView({
    Key? key,
    required this.txnRecord,
  }) : super(key: key);

  Widget optionButton(
    String title,
    Icon icon,
    Color color,
    void Function() handler,
  ) {
    return OutlinedButton.icon(
      onPressed: handler,
      icon: icon,
      label: Text(title),
      style: ButtonStyle(
          side: MaterialStateProperty.all(
              const BorderSide(color: Colors.black87)),
          alignment: Alignment.center,
          foregroundColor:
              MaterialStateProperty.all(Colors.white.withOpacity(0.8)),
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 0.1),
        color: Colors.black.withOpacity(0.7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          optionButton('Preview', const Icon(Icons.preview_outlined),
              Colors.lightGreen.withOpacity(.45), () => Navigator.of(context).pushNamed(ReceiptPreviewScreen.routeName, arguments: txnRecord)),
          optionButton('Save PDF', const Icon(Icons.picture_as_pdf_outlined),
              const Color.fromARGB(52, 255, 153, 0), () {}),
          optionButton('Save Image', const Icon(Icons.image_outlined),
              Colors.black.withOpacity(.55), () {}),
        ],
      ),
    );
  }
}

class DetailsView extends StatelessWidget {
  final TransactionRecord txnRecord;
  const DetailsView({
    Key? key,
    required this.txnRecord,
    required Map<String, TextStyle> recordTileStyle,
  })  : _recordTileStyle = recordTileStyle,
        super(key: key);

  final Map<String, TextStyle> _recordTileStyle;

  @override
  Widget build(BuildContext context) {
    final MoneyFormatter _priceGross = MoneyFormatter(
      amount: double.parse(txnRecord.priceGross), // product.cost
      settings: MoneyFormatterSettings(
        // symbol: '₦',
        symbol: 'N ',
        thousandSeparator: ',',
        decimalSeparator: '.',
        symbolAndNumberSeparator: '',
        fractionDigits: 2,
        // compactFormatType: CompactFormatType.short,
      ),
    );
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Ink(
            height: 80.0,
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 0.1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Chip(
                        label: FittedBox(child: Text(_priceGross.output.symbolOnLeft)),
                        backgroundColor: Colors.amber,
                        labelStyle: _recordTileStyle['price'],
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    Flexible(
                      flex: 8,
                      child: FittedBox(
                        child: Text(
                          txnRecord.token,
                          softWrap: false,
                          style: _recordTileStyle['token'],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: FittedBox(
                          child: Text(
                            DateFormat('yyyy-MM-dd - kk:mm')
                                .format(DateTime.fromMicrosecondsSinceEpoch(txnRecord.date)),
                            style: _recordTileStyle['date'],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                'Transaction Ref  :  ${txnRecord.txnReference}',
                                style: _recordTileStyle['reference'],
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                'Receipt Ref         :  ${txnRecord.receiptID}',
                                style: _recordTileStyle['reference'],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5.0)
      ],
    );
  }
}
