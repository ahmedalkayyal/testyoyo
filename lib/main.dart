import 'package:flutter/material.dart';
import 'package:testyoyo/view/home/home_screen.dart';

void main() async {
  runApp(
  //   DevicePreview(
  //   enabled: true,
  //   tools:  [
  //     ...DevicePreview.defaultTools,
  //   ],
  //   builder: (context) => const MyApp(),
  // ),
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'IP Tv Launcher',
        theme: ThemeData(primarySwatch: Colors.grey),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Tv List',style: TextStyle(color: Colors.white,fontSize: 28 ),),
      ),
      body:
      //VideoPlayerExample(),
      HomeScreen(),
    );
  }
}