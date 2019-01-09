import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  int tapAmount = 3;

  // tap counter
  void _incrementCounter() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    
    setState(() {
      tapAmount++;
    });
    // set value
    prefs.setInt('counter', tapAmount);
  }

  // receive counter from phone
  _getCounter() async {

    final prefs = await SharedPreferences.getInstance();

    // Try reading data from the counter key. If it does not exist, return 0.
    setState(() {
      tapAmount = prefs.getInt('counter') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    _getCounter();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Poke me',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromRGBO(26, 26, 26, 0.5),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                    onTap: _incrementCounter,
                    child: Image(
                      image: AssetImage('assets/eu.jpeg'),
                      width: 300,
                    )),
                Container(padding: const EdgeInsets.all(32.0)),
                Text('Poked ' + tapAmount.toString() + ' times',
                    style: TextStyle(fontSize: 36))
              ]),
        ),
      ),
    );
  }
}
