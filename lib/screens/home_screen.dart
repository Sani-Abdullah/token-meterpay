// External
import 'package:flutter/material.dart';

// Internal
import './home_screen_d/buy_units.dart';
import './home_screen_d/purchase_history.dart';

import '../helpers/user_backend.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    final _userBackend = UserBackend();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Token Purchase'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
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
                      'Logout',
                      style:
                          TextStyle(fontFamily: 'Monteserat', fontSize: 15.0),
                    ))
              ],
              onSelected: (_) {
                _userBackend.logOut();
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                // 'https://unsplash.it/600/400?image=501',
                'https://media.istockphoto.com/photos/electric-meters-in-a-row-standing-on-the-wall-picture-id931173784?b=1&k=20&m=931173784&s=170667a&w=0&h=ZySqA3cBupwlhyEYqg6IgD67OlT5vCenVNAFpYDD_xA=',
                height: 200.0,
                width: 450.0,
                fit: BoxFit.fill,
              ),
            ),
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
