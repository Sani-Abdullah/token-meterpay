// External
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

// Internal
import '../../models/transaction_record.dart';
import '../../components/receipt_view.dart';
import '../../util/gen_pdf.dart';


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
          'Token Generated',
          style: _generatedTokenScreenStyle['toolbar'],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: PopupMenuButton(
              child: const Icon(
                Icons.menu,
                // color: Colors.black54,
              ),
              offset: const Offset(0, 50.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                    value: 0,
                    child: Text(
                      'Share as PDF',
                      style:
                          TextStyle(fontFamily: 'Monteserat', fontSize: 15.0),
                    )),
                    const PopupMenuItem(
                    value: 1,
                    child: Text(
                      'Share as Image',
                      style:
                          TextStyle(fontFamily: 'Monteserat', fontSize: 15.0),
                    )),
                
              ],
              onSelected: (value) async {
                if (value == 0) {
                  sharePDF(txnRecord);
                } else if (value == 1) {
                shareRenderedPDFImage(txnRecord, Colors.white);
                }
              },
            ),
          ),
        ],
      ),
      body: SizedBox(
        // height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - kToolbarHeight,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Share.share(txnRecord.token,
                  subject: 'Token from MeterPay.NG'),
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: txnRecord.token)).then(
                    (value) => ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text('Copied to clipboard'),
                        )));
              },
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
            Expanded(child: ReceitpView(txnRecord: txnRecord)),
          ],
        ),
      ),
    );
  }
}
