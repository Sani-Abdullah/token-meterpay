// External
import 'package:flutter/material.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  PurchaseHistoryScreen({Key? key}) : super(key: key);
  static const routeName = 'home:purchase-history';

  final Map<String, dynamic> _purchaseHistoryScreenStyle = {
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
            'Records',
            style: _purchaseHistoryScreenStyle['toolbar'],
          ),
        ),
        body: ListView.builder(
          //<TBD>: bringing from user records
          padding: const EdgeInsets.only(top: 4.0),
          physics: const BouncingScrollPhysics(),
          itemCount: 15,
          itemBuilder: (context, n) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              children: [
                GestureDetector(
                  //<TBD>
                  onTap: () {},
                  child: Container(
                    height: 70.0,
                    padding: const EdgeInsets.only(left: 10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.1),
                      // gradient: const LinearGradient(
                      //     begin: Alignment.centerRight,
                      //     end: Alignment.centerLeft,
                      //     colors: [
                      //       Color.fromARGB(50, 117, 112, 112),
                      //       Colors.white,
                      //     ]),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '5555-4444-3333-2222',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: 'PTSans',
                              color: Colors.green),
                        ),
                        Text('222222222222222222222222222222222222'),
                        Text('helloaojodjaodjfa'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5.0)
              ],
            ),
          ),
        ));
  }
}
