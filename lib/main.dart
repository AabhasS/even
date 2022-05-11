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
        primarySwatch: Colors.blueGrey,
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
  int selected = 0;

  List<Widget> list = [
    Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
      ),
    ),
    Consultations(),
    Container()
  ];
  @override
  Widget build(BuildContext context) {
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
