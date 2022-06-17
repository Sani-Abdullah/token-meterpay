// External
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordTile extends StatelessWidget {
  final Map<String, TextStyle> _recordTileStyle = {
    'token': const TextStyle(
      fontFamily: 'PTSans',
      fontSize: 22,
    ),
    'reference': const TextStyle(
      fontFamily: 'Abel',
      fontSize: 15,
    ),
    'date': const TextStyle(
      fontFamily: 'Abel',
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ),
    'price': const TextStyle(
      fontFamily: 'PTSans',
      fontSize: 15,
    ),
  };

  RecordTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          GestureDetector(
            //<TBD>
            onTap: () {},
            child: Container(
              height: 80.0,
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: const Text('N4,500'),
                        backgroundColor: Colors.amber,
                        labelStyle: _recordTileStyle['price'],
                        visualDensity: VisualDensity.compact,
                      ),
                      Text(
                        '5555-4444-3333-2222-1111',
                        style: _recordTileStyle['token'],
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('yyyy-MM-dd - kk:mm')
                              .format(DateTime.now()),
                          style: _recordTileStyle['date'],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transaction Ref  :  helloaojodjaodjfa',
                              style: _recordTileStyle[
                                  'reference'],
                            ),
                            Text(
                              'Receipt Ref         :  helloaojodjaodjfa',
                              style: _recordTileStyle[
                                  'reference'],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5.0)
        ],
      ),
    );
  }
}
