import 'package:even/consultations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  int selected = 0;

  List<Widget> list = [
    Container(
      child: Text(
        "Home",
        style: TextStyle(color: Colors.black),
      ),
    ),
    Consultations(),
    Container()
  ];
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: list[selected],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffDADFEB),
        elevation: 0,
        onTap: (index) {
          setState(() {
            selected = index;
          });
        },
        currentIndex: selected,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "")
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
