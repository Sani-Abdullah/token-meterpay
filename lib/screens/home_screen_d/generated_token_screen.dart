// External
import 'package:flutter/material.dart';

// Internal
import '../../models/transaction_record.dart';
import '../../components/receipt_view.dart';

class GeneratedTokenScreen extends StatelessWidget {
  GeneratedTokenScreen({Key? key}) : super(key: key);
  static const routeName = 'home:recharge:generared-token';

  final Map<String, TextStyle> _generatedTokenScreenStyle = {
    'toolbar': const TextStyle(
      fontFamily: 'Abel',
      fontSize: 21,
    )
  };

  @override
  Widget build(BuildContext context) {
    final TransactionRecord txnRecord =
        ModalRoute.of(context)!.settings.arguments as TransactionRecord;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Receipt Preview',
            style: _generatedTokenScreenStyle['toolbar'],
          ),
        ),
        body: ReceitpView(txnRecord: txnRecord));
  }
}
