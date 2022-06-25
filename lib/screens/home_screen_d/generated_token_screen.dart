// External
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

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
      body: SizedBox(
        // height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight,
        child: Column(
          children: [
            InkWell(
              onTap: () => Share.share(txnRecord.token, subject: 'Token from MeterPay.NG'),
              child: Ink(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      top: 30.0, bottom: 25.0, left: 20.0, right: 20.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: Colors.green.shade300,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Text(txnRecord.token,
                      style: _generatedTokenScreenStyle['toolbar']),
                ),
              ),
            ),
            Expanded(child: ReceitpView(txnRecord: txnRecord)),
          ],
        ),
      ),
    );
  }
}
