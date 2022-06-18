// Core
import 'dart:convert';
import 'dart:math';

// External
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:crypto/crypto.dart';

// Internal
import './../../helpers/auth.dart';
import '../../models/transaction_record.dart';
import '../../helpers/user_backend.dart' as userB;
import '../../secret.dart' as secret;

class RechargeUnitsScreen extends StatefulWidget {
  const RechargeUnitsScreen({Key? key}) : super(key: key);
  static const routeName = 'home:recharge';

  @override
  State<RechargeUnitsScreen> createState() => _RechargeUnitsScreenState();
}

class _RechargeUnitsScreenState extends State<RechargeUnitsScreen> {
  final plugin = PaystackPlugin();
  final GlobalKey<FormBuilderState> _purchaseFormKey =
      GlobalKey<FormBuilderState>();

  final TextEditingController _amountTextController = TextEditingController();

  final Map<String, TextStyle> _rechargeScreenStyle = {
    'toolbar': const TextStyle(
      fontFamily: 'Abel',
      fontSize: 21,
    ),
    'payButton': const TextStyle(
      fontFamily: 'Abel',
      fontSize: 21,
    ),
    'meterName': const TextStyle(
      fontFamily: 'Abel',
      fontSize: 16,
    ),
    'meterNumber': const TextStyle(
      fontFamily: 'Abel',
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    'editmeterlabel': const TextStyle(
      fontFamily: 'Abel',
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
  };

  final Auth _auth = Auth();

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

  @override
  void initState() {
    plugin.initialize(publicKey: secret.publicKey_test);
    super.initState();
  }

  // TransactionRecord makeTransactionRecord (String units, ) {
  @override
  Widget build(BuildContext context) {
    final userB.UserBackend _userBackend = userB.UserBackend();
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
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  // 'https://unsplash.it/600/400?image=501',
                  'https://media.istockphoto.com/photos/payment-of-utility-services-concept-part-of-an-electricity-meter-picture-id1307617970?b=1&k=20&m=1307617970&s=170667a&w=0&h=_-KliTRVs-Yi8z1SVx156JLBZq1U96N0aYyfZsOjvjs=',
                  height: 200.0,
                  width: 450.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              decoration: BoxDecoration(
                border: Border.all(width: 1.0),
              ),
              child: FormBuilder(
                key: _purchaseFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.bottomRight,
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        label: Text('Add/Remove Meter', style: _rechargeScreenStyle['editmeterlabel'],),
                        icon: const Icon(Icons.edit, color: Colors.black,),
                        style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.black45)),
                        onPressed: () {
                          //<TBD: show modal>
                        },
                      ),
                    ),
                    FutureBuilder<dynamic>(
                        future: _userBackend.getMeters(),
                        builder: (context, snapshotDropDown) {
                          if (snapshotDropDown.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            final dataDropDown = snapshotDropDown.data;
                            return FormBuilderDropdown(
                              name: 'meter',
                              decoration: const InputDecoration(
                                labelText: 'Meter',
                              ),
                              // initialValue: 'Male',
                              allowClear: true,
                              hint: const Text('Select Meter'),
                              validator: (_) {
                                // <TBD> validate meters
                                return null;
                              },
                              items: List.generate(
                                  snapshotDropDown.data!.length,
                                  (index) => DropdownMenuItem(
                                        value: index,
                                        child: Row(children: [
                                          Text(
                                            dataDropDown![index]['meterName'] + ': ',
                                            style: _rechargeScreenStyle['meterName'],
                                          ),
                                          Text(
                                            dataDropDown[index]['meterNumber'],
                                            style: _rechargeScreenStyle['meterNumber'],
                                          ),
                                        ]),
                                      )),
                            );
                          }
                        }),
                    FormBuilderTextField(
                      name: 'Amount',
                      controller: _amountTextController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        isDense: true,
                        labelText: 'Enter Amount',
                      ),
                      onSubmitted: (_) {},
                      validator: (value) {
                        if (value == null) {
                          return 'Enter amount below 100';
                        } else if (int.parse(value) > 100) {
                          return 'Amout too high';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {},
                    ),
                    const SizedBox(height: 15.0),
                    ElevatedButton(
                        onPressed: () async {
                          if (_purchaseFormKey.currentState!.validate()) {
                            Charge charge = Charge()
                              ..amount = int.parse('${_amountTextController}00')
                              ..reference =
                                  '${DateTime.now().microsecondsSinceEpoch}'
                              //  ..email = _auth.currentUser()?.email;
                              ..email = 'heatwavemachine@gmail.com';

                            CheckoutResponse response = await plugin.checkout(
                              context,
                              method: CheckoutMethod
                                  .card, // Defaults to CheckoutMethod.selectable
                              charge: charge,
                            );

                            if (!response.status) {}
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(double.infinity, 50),
                            primary: const Color.fromARGB(237, 71, 238, 49)),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Purchase',
                            textAlign: TextAlign.center,
                            style: _rechargeScreenStyle['payButton'],
                          ),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
