// Core
import 'dart:convert';
import 'dart:math';

// External
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:crypto/crypto.dart';

// Internal
import './../../helpers/auth.dart';
import '../../models/transaction_record.dart';
import '../../models/user.dart' as userM;

class RechargeUnitsScreen extends StatelessWidget {
  RechargeUnitsScreen({Key? key}) : super(key: key);
  static const routeName = 'home:recharge';

  final GlobalKey<FormBuilderState> _purchaseFormKey =
      GlobalKey<FormBuilderState>();
  final TextEditingController _amountTextController = TextEditingController();

  final Map<String, TextStyle> _rechargeScreenStyle = {
    // 'title': const TextStyle(
    //   fontFamily: 'ComicNeue',
    //   fontSize: 25.0,
    // ),
    'toolbar': const TextStyle(
      fontFamily: 'Abel',
      fontSize: 21,
    ),
  };

  final _auth = Auth();

  String referencer() {
    final randomTin = Random();
    var fullRef = sha1
        .convert(utf8.encode(DateTime.now().millisecondsSinceEpoch.toString() +
            (_auth.currentUser()!.uid +
                List.generate(12, (_) => randomTin.nextInt(100)).toString())))
        .toString()
        .toLowerCase();
    var partialRef = '';
    for (var i in List.generate(16, (_) => randomTin.nextInt(fullRef.length))) {
      partialRef += fullRef[i];
    }
    return partialRef;
  }

  // TransactionRecord makeTransactionRecord (String units, ) {
  //   final TransactionRecord transactionRecord = TransactionRecord(
  //     txnReference: referencer(),
  //     token: token,
  //     receiptID: referencer(),
  //     units: units,
  //     meterNumber: meterNumber,
  //     meterName: meterName,
  //     date: DateTime.now().microsecondsSinceEpoch,
  //     priceGross: priceGross,
  //     priceNet: priceNet,
  //     debt: debt,
  //     vat: vat,
  //     serviceCharge: serviceCharge,
  //     freeUnits: freeUnits,
  //     paymentType: paymentType,
  //     username: username,
  //     address: address,
  //     meterCategory: meterCategory,
  //   );
  //   return transactionRecord;
  // }

  @override
  Widget build(BuildContext context) {
    var _isLoading = false;
    final Map<String, String> _payData = {};
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recharge',
          style: _rechargeScreenStyle['toolbar'],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListTile(
              // Add or remove meter
              onTap: () => {},
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0),
              ),
              child: FormBuilder(
                key: _purchaseFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'amount-enter',
                        controller: _amountTextController,
                        keyboardType: TextInputType.number,
                        // decoration: InputDecoration(
                        //     isDense: true,
                        // labelStyle: widget._styles['formlabel'],
                        //     labelText: 'Email',
                        //     hintText: 'e.g mymail@mail.com'),
                        // onSubmitted: (_) {
                        //   FocusScope.of(context).requestFocus(_passwordFocusNode);
                        // },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter an amount';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          if (value != null) {
                            _payData['amount'] = value.trim();
                          } else {}
                        },
                      ),
                      if (_isLoading) const CircularProgressIndicator(),
                      if (!_isLoading)
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            // backgroundColor: Theme.of(context).primaryColor.withAlpha(50),
                            fixedSize: const Size(100, 10),
                            side: const BorderSide(
                              color: Color(0xff2A6041),
                              style: BorderStyle.solid,
                              width: 0.5,
                            ),
                            // shape: const RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.all(Radius.circular(20))),
                          ),
                          child: const Text('Purchase'),
                          onPressed: () {},
                        )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
