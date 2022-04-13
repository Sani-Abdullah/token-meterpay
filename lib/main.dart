// External
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'meterpay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'payments_page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final plugin = PaystackPlugin();
  final _formKey = GlobalKey<FormBuilderState>();
  final _amountController = TextEditingController();

  // static const String _publicKey =
  //     'pk_test_dd486a7467df7dac8a04fdafcb2be80586247411';
  static const String _publicKey =
      'pk_live_a37f90ebfbe0af588ac898c93f60c0d008006517';

  @override
  void initState() {
    plugin.initialize(publicKey: _publicKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          width: 100,
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FormBuilderTextField(
                  name: 'Amount',
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Enter Amount',
                  ),
                  onSubmitted: (_) {},
                  validator: (value) {
                    if(value == null) {
                      return 'Enter amount below 100';
                    } else if (int.parse(value) > 100) {
                      return 'Amout too high';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {},
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Charge charge = Charge()
                          ..amount = int.parse('${_amountController.text}00')
                          ..reference = '${DateTime.now().microsecondsSinceEpoch}'
                          //  ..email = _auth.currentUser()?.email;
                          ..email = 'heatwavemachine@gmail.com';
        
                        plugin.checkout(
                          context,
                          method: CheckoutMethod
                              .card, // Defaults to CheckoutMethod.selectable
                          charge: charge,
                        );
                      }
                    },
                    child: SizedBox(
                      width: 50,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.payment,
                            size: 25,
                            color: Colors.deepOrangeAccent,
                          ),
                          Text('Pay'),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
