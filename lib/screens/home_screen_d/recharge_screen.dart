// Core
import 'dart:convert';
import 'dart:math';

// External
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart';

// Internal
import './../../helpers/auth.dart';
import '../../helpers/user_backend.dart' as user_B;
import '../../secret.dart' as secret;
import '../../models/transaction_record.dart';

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
  final GlobalKey<FormBuilderState> _addMeterFormKey =
      GlobalKey<FormBuilderState>();

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
    'modelMeterIndex': const TextStyle(
      fontFamily: 'Abel',
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    'modelMeterName': const TextStyle(
      fontFamily: 'Armata',
      fontSize: 17,
    ),
    'modelMeterNumber': const TextStyle(
      fontFamily: 'ComicNeue',
      fontSize: 20,
    ),
    'meterEditInfo': const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 13,
      color: Colors.black54,
    ),
    'addRemove': const TextStyle(
      fontFamily: 'Abel',
      fontSize: 15,
      // color: Colors.black54,
      // fontWeight: FontWeight.bold,
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

  final TextEditingController _amountTextController = TextEditingController();
  final TextEditingController _meterNameController = TextEditingController();
  final TextEditingController _meterNumberController = TextEditingController();

  final FocusNode _meterNumberFocusNode = FocusNode();

  void dispose() {
    _meterNumberFocusNode.dispose();
    super.dispose();
  }

  Widget addRemoveInfo(String info) {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, bottom: 10.0),
        child: Row(
          children: [
            const Icon(
              Icons.info_outline,
              color: Colors.amber,
              size: 22.0,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              info,
              style: _rechargeScreenStyle['meterEditInfo'],
            )
          ],
        ));
  }

  // TransactionRecord makeTransactionRecord (String units, ) {
  @override
  Widget build(BuildContext context) {
    final user_B.UserBackend _userBackend = user_B.UserBackend();
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
                        label: Text(
                          'Add/Remove Meter',
                          style: _rechargeScreenStyle['editmeterlabel'],
                        ),
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.black45)),
                        onPressed: () {
                          //<TBD: show modal>
                          showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                            ),
                            context: context,
                            builder: (context) => SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      // Bottom sheet height control
                                      height: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom <
                                              100
                                          ? 240.0 +
                                              42.0 // 40.0 compasentating for error text and button height
                                          : MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: Column(
                                          // Add Column
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0),
                                              child: Text(
                                                'Add',
                                                style: _rechargeScreenStyle[
                                                    'addRemove'],
                                              ),
                                            ),
                                            const Divider(
                                              color: Colors.grey,
                                              thickness: 1.2,
                                            ),
                                            addRemoveInfo(
                                                'Submit form to add meter'),
                                            FormBuilder(
                                                key: _addMeterFormKey,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0,
                                                          right: 15.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      FormBuilderTextField(
                                                        name: 'Meter Name',
                                                        controller:
                                                            _meterNameController,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        decoration:
                                                            const InputDecoration(
                                                          isDense: true,
                                                          labelText:
                                                              'Meter Name',
                                                        ),
                                                        onSubmitted: (_) {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  _meterNumberFocusNode);
                                                        },
                                                        validator: (value) {
                                                          final RegExp regExp =
                                                              RegExp(
                                                                  r"^[A-Za-z-_]*$");
                                                          if (value == null) {
                                                            return 'Enter Meter Name';
                                                          } else if (!regExp
                                                              .hasMatch(
                                                                  value)) {
                                                            return 'Only letter and dashes allowed';
                                                          } else if (value
                                                                  .length >
                                                              15) {
                                                            return 'Use 15 characters or less';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        onSaved: (value) {},
                                                      ),
                                                      FormBuilderTextField(
                                                        name: 'Meter Number',
                                                        controller:
                                                            _meterNumberController,
                                                        focusNode:
                                                            _meterNumberFocusNode,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            const InputDecoration(
                                                          isDense: true,
                                                          labelText:
                                                              'Meter Number',
                                                        ),
                                                        onSubmitted: (_) {},
                                                        validator: (value) {
                                                          final RegExp regExp =
                                                              RegExp(
                                                                  r"^[0-9]*$");
                                                          if (value == null) {
                                                            return 'Enter Meter Name';
                                                          } else if (!regExp
                                                              .hasMatch(
                                                                  value)) {
                                                            return 'Only numbers allowed';
                                                          } else if (value
                                                                  .length >
                                                              30) {
                                                            return 'Number longer than 30';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        onSaved: (value) {},
                                                      ),
                                                      const SizedBox(
                                                        height: 15.0,
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: ElevatedButton(
                                                            onPressed: () {
                                                              if (_addMeterFormKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                // <TBD: adding meter
                                                                _userBackend.addMeter(
                                                                    _meterNumberController
                                                                        .text,
                                                                    _meterNameController
                                                                        .text);

                                                                _meterNameController
                                                                    .clear();
                                                                _meterNumberController
                                                                    .clear();

                                                              }
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                                fixedSize:
                                                                    const Size(
                                                                        120.0,
                                                                        25.0),
                                                                primary: const Color
                                                                        .fromARGB(
                                                                    237,
                                                                    71,
                                                                    238,
                                                                    49)),
                                                            child: SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child: Text(
                                                                'Add Meter',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                softWrap: false,
                                                                style: _rechargeScreenStyle[
                                                                        'payButton']!
                                                                    .copyWith(
                                                                  fontSize:
                                                                      17.0,
                                                                ),
                                                              ),
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    FutureBuilder<dynamic>(
                                        future: _userBackend.getMeters(),
                                        builder:
                                            (context, snapshotAddRemoveModal) {
                                          if (snapshotAddRemoveModal
                                                      .connectionState ==
                                                  ConnectionState.waiting ||
                                              !snapshotAddRemoveModal.hasData) {
                                            return Column(
                                              children: const [
                                                LinearProgressIndicator()
                                              ],
                                            );
                                          } else {
                                            final dataAddRemove =
                                                snapshotAddRemoveModal.data;
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0),
                                                  child: Text(
                                                    'Remove',
                                                    style: _rechargeScreenStyle[
                                                        'addRemove'],
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Colors.grey,
                                                  thickness: 1.2,
                                                ),
                                                addRemoveInfo(
                                                    'Slide right to delete meter'),
                                                SizedBox(
                                                  height: 160.0,
                                                  child: SingleChildScrollView(
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    child: Column(
                                                      children: List.generate(
                                                          dataAddRemove.length,
                                                          (index) =>
                                                              Dismissible(
                                                                  direction:
                                                                      DismissDirection
                                                                          .startToEnd,
                                                                  key: ValueKey(
                                                                      index),
                                                                  background:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    color: Colors
                                                                        .red,
                                                                    child: const Icon(
                                                                        Icons
                                                                            .delete),
                                                                  ),
                                                                  onDismissed:
                                                                      (_) {
                                                                    setState(
                                                                        () {
                                                                      _userBackend
                                                                          .removeMeter(
                                                                              dataAddRemove[index]);
                                                                    });
                                                                  },
                                                                  child:
                                                                      SizedBox(
                                                                    height:
                                                                        50.0,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Divider(
                                                                          height:
                                                                              0.0,
                                                                          indent:
                                                                              20.0,
                                                                          endIndent:
                                                                              15.0,
                                                                          thickness:
                                                                              0.8,
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 20.0),
                                                                                child: Text(
                                                                                  dataAddRemove[index]['meterName'] + ': ',
                                                                                  style: _rechargeScreenStyle['modelMeterName'],
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                                                                child: Text(
                                                                                  dataAddRemove[index]['meterNumber'],
                                                                                  style: _rechargeScreenStyle['modelMeterNumber'],
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                          ),
                                                                        ),
                                                                        const Divider(
                                                                          height:
                                                                              0.0,
                                                                          indent:
                                                                              20.0,
                                                                          endIndent:
                                                                              15.0,
                                                                          thickness:
                                                                              0.8,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ))),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        })
                                  ]),
                            ),
                          );
                        },
                      ),
                    ),
                    FutureBuilder<dynamic>(
                        future: _userBackend.getMeters(),
                        builder: (_, snapshotDropDown) {
                          if (snapshotDropDown.connectionState ==
                                  ConnectionState.waiting ||
                              !snapshotDropDown.hasData) {
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
                                  dataDropDown.length,
                                  (index) => DropdownMenuItem(
                                        value: index,
                                        child: Row(children: [
                                          Text(
                                            dataDropDown[index]['meterName'] +
                                                ': ',
                                            style: _rechargeScreenStyle[
                                                'meterName'],
                                          ),
                                          Text(
                                            dataDropDown[index]['meterNumber'],
                                            style: _rechargeScreenStyle[
                                                'meterNumber'],
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
                          return 'Enter Amount';
                        } else if (int.parse(value) > 10000) {
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
                            final transactionReference = referencer();
                            Charge charge = Charge()
                              ..amount = int.parse('${_amountTextController.text}00')
                              ..reference = transactionReference
                                  
                               ..email = _auth.currentUser()?.email;
                              // ..email = 'heatwavemachine@gmail.com';

                            CheckoutResponse response = await plugin.checkout(
                              context,
                              method: CheckoutMethod
                                  .card, // Defaults to CheckoutMethod.selectable
                              charge: charge,
                            );

                            _amountTextController.clear();


                            if (!response.status) {
                              // <TBD: if transactions fails>


                            // _userBackend.addTransaction(
                            //   TransactionRecord(
                            //   txnReference: transactionReference,
                            //   token: 'token',

                            // ));

                            }
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
