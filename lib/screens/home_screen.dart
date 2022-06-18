// External
import 'package:flutter/material.dart';

// Internal
import './home_screen_d/recharge_screen.dart';
import './home_screen_d/purchase_history_screen.dart';

import '../helpers/user_backend.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  static const routeName = 'home';
  final UserBackend _userBackend = UserBackend();
  final Map<String, TextStyle> _homeScreenStyle = {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Token Purchase',
          style: _homeScreenStyle['toolbar'],
        ),
        actionsIconTheme: const IconThemeData(
          opacity: 0.8,
          size: 23.0,
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
                      'Logout',
                      style:
                          TextStyle(fontFamily: 'Monteserat', fontSize: 15.0),
                    )),
                const PopupMenuItem(
                    value: 1,
                    child: Text(
                      'About Us',
                      style:
                          TextStyle(fontFamily: 'Monteserat', fontSize: 15.0),
                    ))
              ],
              onSelected: (value) {
                if (value == 0) {
                  _userBackend.logOut();
                } else if (value == 1) {
                  //<TBD> Show About Us Page
                }
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
              Icons.money,
              color: Colors.deepOrange,
            ),
            title: const Text('Recharge Meter'),
            onTap: () {
              Navigator.of(context).pushNamed(RechargeUnitsScreen.routeName);
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
              Navigator.of(context).pushNamed(PurchaseHistoryScreen.routeName);
            },
          ),
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
