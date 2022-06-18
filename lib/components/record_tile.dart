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
      child: Stack(
        // fit: StackFit.expand,
        children: [
          DetailsView(recordTileStyle: _recordTileStyle),
          const OptionsView(),
        ],
      ),
    );
  }
}

class OptionsView extends StatelessWidget {
  const OptionsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 0.1),
        color: Colors.black.withOpacity(0.7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.picture_as_pdf_outlined),
            label: const Text('Save PDF'),
            style: ButtonStyle(
                side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.black87)),
                alignment: Alignment.center,
                foregroundColor: MaterialStateProperty.all(Colors.white.withOpacity(.80)),
                backgroundColor: MaterialStateProperty.all(const Color.fromARGB(52, 255, 153, 0)),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                )),
          ),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.image_outlined),
            label: const Text('Save Image'),
            style: ButtonStyle(
                side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.black87)),
                alignment: Alignment.center,
                foregroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.8)),
                backgroundColor: MaterialStateProperty.all(Colors.black.withOpacity(.55)),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class DetailsView extends StatelessWidget {
  const DetailsView({
    Key? key,
    required Map<String, TextStyle> recordTileStyle,
  })  : _recordTileStyle = recordTileStyle,
        super(key: key);

  final Map<String, TextStyle> _recordTileStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Ink(
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
                    Flexible(
                      flex: 2,
                      child: Chip(
                        label: const FittedBox(child: Text('N45,000')),
                        backgroundColor: Colors.amber,
                        labelStyle: _recordTileStyle['price'],
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    Flexible(
                      flex: 8,
                      child: FittedBox(
                        child: Text(
                          '5555-4444-3333-2222-1111',
                          softWrap: false,
                          style: _recordTileStyle['token'],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: FittedBox(
                          child: Text(
                            DateFormat('yyyy-MM-dd - kk:mm')
                                .format(DateTime.now()),
                            style: _recordTileStyle['date'],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                'Transaction Ref  :  helloaojodjaodjfa',
                                style: _recordTileStyle['reference'],
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                'Receipt Ref         :  helloaojodjaodjfa',
                                style: _recordTileStyle['reference'],
                              ),
                            ),
                          ],
                        ),
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
    );
  }
}
