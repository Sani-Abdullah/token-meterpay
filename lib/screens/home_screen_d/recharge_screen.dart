// External
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
                      FormBuilderDropdown(
                        name: 'meter-select',
                        items: const [
                          DropdownMenuItem(child: Text('Meter 1')),
                          DropdownMenuItem(child: Text('Meter 2')),
                        ],
                      ),
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
