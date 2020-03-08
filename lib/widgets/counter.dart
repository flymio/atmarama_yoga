// counter_page.dart
import 'package:flutter/material.dart';

class Count extends StatelessWidget {
  final int count;
  final String text;
  final VoidCallback onCountSelected;

  final Function(int) onCountChange;

  Count({
    @required this.count,
    @required this.text,
    @required this.onCountChange,
    this.onCountSelected,
  });

  @override
  Widget build(BuildContext context) {
      return Column(
          children: <Widget>[
            new Text(
              '$text',
              style: new TextStyle(fontSize: 24.0),              
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 30.0,
                  width: 30.0,
                  child: FittedBox(
                    child: new FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        onCountChange(1);
                      },
                      child: new Icon(Icons.add, color: Colors.black,),
                      backgroundColor: Colors.white),
                  ),
                ),
                new Text('$count',
                    style: new TextStyle(fontSize: 20.0),
                ),
                Container(
                  height: 30.0,
                  width: 30.0,
                  child: FittedBox(
                    child: new FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        onCountChange(-1);
                      },
                      child: new Icon(
                      const IconData(0xe15b, fontFamily: 'MaterialIcons')),
                      backgroundColor: Colors.white),
                      ),
                )
              ],
            )
          ]
        );
  }
}
        // IconButton(
        //   icon: Icon(Icons.add),
          // onPressed: () {
          //   onCountChange(1);
          // },
        // ),
        // FlatButton(
        //   child: Text("$count"),
        //   onPressed: () => onCountSelected(),
        // ),
        // IconButton(
        //   icon: Icon(Icons.remove),
        //   onPressed: () {
        //     onCountChange(-1);
        //   },
