import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                scannerMode();
              },
              child: Icon(Icons.scanner),
              tooltip: "Scan QR Code",
            ),
            SizedBox(width: 100,height: 100,),
            FloatingActionButton(
              onPressed: () {
                _displayQRCode("Flutter");
              },
              tooltip: 'QR Code',
              child: Icon(Icons.keyboard_backspace),
            ),
          ],
        ),
      ),
    );
  }

  Future _displayQRCode(String data) {
    return showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
                title: Text('Your QR COde : '),
                content: Container(
                  height: 300,
                  width: 300,
                  child: QrImage(
                    data: data,
                    version: QrVersions.auto,
                    gapless: false,
                    size: 200,
                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]),
          );
        });
  }

  Future scannerMode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
        "#009742", "cancel", true, ScanMode.BARCODE);
  }
}