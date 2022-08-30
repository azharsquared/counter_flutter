import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Dua Counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _limit = 1;
  bool _infinity = true;
  bool _press33 = false;
  bool _press3 = false;
  bool _press100 = false;
  bool _pressInfinity = true;
  bool _limtReached = false;
  List<Widget> _history =[Text(
    "0",

    style: TextStyle(
      color: Color(int.parse("0xff808080")),
      //  height: 5.0,
      //fontSize: 100.0,
    ),
  ),];

  void _incrementCounter() {
    print(_counter);
    print(_infinity || (_counter < _limit - 1));
    print((_counter == _limit ));
    setState(() {
      if (_infinity || (_counter < _limit - 1)) {
        _counter++;
        HapticFeedback.lightImpact();
      } else if(_counter == _limit -1 ) {
        _counter++;
        _limtReached = true;
        HapticFeedback.heavyImpact();
        sleep(
          const Duration(milliseconds: 50),
        );
        HapticFeedback.heavyImpact();
        sleep(
          const Duration(milliseconds: 50),
        );
        HapticFeedback.heavyImpact();
        sleep(
          const Duration(milliseconds: 50),
        );
        SystemSound.play(SystemSoundType.click);
      }else{
        history();
        _resetCounter();
      }
    });
  }

  void history() {
    if(_history.length > 0) {
      _history.removeAt(0);
    }
    _history.add(Text(
        (_counter).toString(),

      style: TextStyle(
          color: Color(int.parse("0xff808080")),
        //  height: 5.0,
        fontSize: 100.0,
        ),
    ),

    );
  }

  void _setLimit(int limit) {

    setState(() {
      history();
      HapticFeedback.heavyImpact();
      _limtReached = false;
      _limit = limit;
      _counter = 0;
      _infinity = false;
      if (_limit == 33) {
        _press33 = true;
        _press100 = false;
        _press3 = false;
        _pressInfinity = false;
      } else if (_limit == 3) {
        _press3 = true;
        _press33 = false;
        _press100 = false;
        _pressInfinity = false;
      }
      else if (_limit == 100) {
        _press3 = false;
        _press33 = false;
        _press100 = true;
        _pressInfinity = false;
      }

    });
  }

  void _setInfinity() {
    setState(() {
      history();
      HapticFeedback.heavyImpact();
      _limtReached = false;
      _limit = 0;
      _counter = 0;
      _infinity = true;
      _pressInfinity = true;
      _press33 = false;
      _press3 = false;
      _press100 = false;
    });
  }

  void _resetCounter() {
    setState(() {
      HapticFeedback.heavyImpact();
      _limtReached = false;
      _counter = 0;
    });
  }

  void _decrementCounter() {
    setState(() {
      if ((_counter > 0)) {
        _counter--;
        HapticFeedback.lightImpact();
      } else {
        HapticFeedback.vibrate();
      }
    });
  }

  List<int> _counts = [3,33,100,0];

  void _leftRotateCount(){
    int index = _counts.indexOf(_limit);
    if(index >= _counts.length - 1){
      index = -1;
    }
    print("left");
    print(index + 1);
    int element = _counts.elementAt(index+1);
    if(element == 0) {
      _setInfinity();
    }else{
      _setLimit(element);
    }

  }

  void _rightRotateCount(){
    int index = _counts.indexOf(_limit);
    if(index <=0){
      index = _counts.length ;
    }
    print("right");
    print(index - 1);
    int element = _counts.elementAt(index-1);
    if(element == 0) {
      _setInfinity();
    }else{
      _setLimit(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Padding(
          //   padding: EdgeInsets.only(right: 10),
          //   child: GestureDetector(
          //     onTap: _resetCounter,
          //     child: Icon(
          //       Icons.refresh,
          //     ),
          //   ),
          // ),
        ],
        title: const Center(
          child: Text("Dua Counter"),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
           // mainAxisSize: MainAxisSize.max,
            //mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: OutlinedButton(
                        onPressed: () => _setLimit(3),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: _press3
                              ? Color(int.parse("0xff2C5F2D"))
                              : Colors.white,
                        ),
                        child: Text(
                          "3",
                          style: TextStyle(
                            color: _press3
                                ? Colors.white
                                : Color(int.parse("0xff2C5F2D")),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: OutlinedButton(
                        onPressed: () => _setLimit(33),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: _press33
                              ? Color(int.parse("0xff2C5F2D"))
                              : Colors.white,
                        ),
                        child: Text(
                          "33",
                          style: TextStyle(
                            color: _press33
                                ? Colors.white
                                : Color(int.parse("0xff2C5F2D")),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: OutlinedButton(
                        onPressed: () => _setLimit(100),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: _press100
                              ? Color(int.parse("0xff2C5F2D"))
                              : Colors.white,
                        ),
                        child: Text(
                          "100",
                          style: TextStyle(
                            color: _press100
                                ? Colors.white
                                : Color(int.parse("0xff2C5F2D")),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: OutlinedButton(
                        onPressed: () => _setInfinity(),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: _pressInfinity
                              ? Color(int.parse("0xff2C5F2D"))
                              : Colors.white,
                        ),
                        child: Text(
                          "∞",
                          style: TextStyle(
                            color: _pressInfinity
                                ? Colors.white
                                : Color(int.parse("0xff2C5F2D")),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: OutlinedButton(
                        onPressed: () => _resetCounter(),
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                          // backgroundColor: _pressInfinity
                          //     ? Color(int.parse("0xff2C5F2D"))
                          //     : Colors.white,
                        ),
                        child:  Icon(
                          Icons.refresh,
                        ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center ,
                //mainAxisSize: MainAxisSize.values[1],
                children: [
                  SizedBox(
                    width: 30,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: _history.isEmpty ? Text("0") : _history.first,
                    ),

                  ),
                  Flexible(
                    flex: 10,
                    child: GestureDetector(
                      onLongPressEnd: (x) => _resetCounter(),
                      onTap: _incrementCounter,
                      onHorizontalDragEnd: (DragEndDetails details) {
                        if (details.primaryVelocity! > 0) {
                          _leftRotateCount();
                        } else if (details.primaryVelocity! < 0) {
                          _rightRotateCount();
                        }
                      },
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          '$_counter',
                          style: TextStyle(
                              height: 1,
                              fontSize: 250,
                              color: _limtReached
                                  ? Colors.redAccent
                                  : Color(int.parse("0xff2C5F2D"))),
                        ),
                      ),
                    ),
                  ),
                  //Spacer(),
                  //Spacer(),
                ]
              ),
              const SizedBox(height: 0),
              Column(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 8, bottom: 1, right: 2, left: 2),
                    child: ElevatedButton(
                      onPressed: _incrementCounter,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.white,
                        shadowColor: Colors.greenAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        minimumSize: Size(double.infinity, 30),
                      ),
                      child: ConstrainedBox(
                        constraints:
                        const BoxConstraints.tightFor(width: 150, height: 150),
                        child: const Center(
                          child: Text(
                            "+",
                            style: TextStyle(height: 1, fontSize: 100),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 1, bottom: 1, right: 2, left: 2),
                    child: ElevatedButton(
                      onPressed: _decrementCounter,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.white,
                        shadowColor: Colors.greenAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0)),
                        minimumSize: const Size(double.infinity, 40), //////// HERE
                      ),
                      child: ConstrainedBox(
                        constraints:
                        BoxConstraints.tightFor(width: 150, height: 10),
                        child: const Center(
                          child: Text(
                            "-",
                            style: TextStyle(
                                height: .5,
                                fontSize: 80,
                                overflow: TextOverflow.visible),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
