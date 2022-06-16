// External
import 'package:flutter/material.dart';

// Internal
import './home_screen_d/buy_units.dart';
import './home_screen_d/purchase_history.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ore mi'),
      ),
      body: SingleChildScrollView(
        child: Row(children: [
          Image.network(
            'https://www.fillmurray.com/640/360',
            height: 100.0,
            width: 200.0,
          ),
          const SizedBox(height: 50.00),
          ListTile(
            // selected: true,
            leading: const Icon(
              Icons.mic,
              color: Colors.deepOrange,
            ),
            title: const Text('Buy Units'),
            onTap: () {
              Navigator.of(context).pushNamed(BuyUnits.routeName);
            },
          ),
          ListTile(
            // selected: true,
            leading: const Icon(
              Icons.check,
              color: Color(0xff2A6041),
            ),
            title: const Text('Purchase History'),
            onTap: () {
              Navigator.of(context).pushNamed(PurchaseHistory.routeName);
            },
          ),
          const Divider(),
          ListTile(
            // selected: true,
            leading: const Icon(
              Icons.check,
              color: Color(0xff2A6041),
            ),
            title: const Text('Contact Us'),
            onTap: () {},
          ),
        ]),
      ),
    );
  }
}
