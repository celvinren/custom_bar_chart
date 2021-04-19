import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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

List<num> listAdd(List<num> a, List<num> b) {
  List<num> c = [];
  if (a.length == b.length) {
    for (int i in List.generate(a.length, (int index) => index)) {
      num aNum = a[i] != null ? a[i] : 0;
      num bNum = b[i] != null ? b[i] : 0;
      num total = aNum + bNum;
      c.add(total);
    }
  }
  return c;
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // ScrollController _controller = ScrollController();
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    List<num> list1 = [
      40.0,
      50.0,
      30.0,
      60.0,
      90.0,
      20.0,
      70.0,
      30.0,
      60.0,
      90.0,
      20.0,
      70.0,
      20.0,
      110.0,
      120.0,
      60.0,
      60.0,
      150.0,
      30.0,
      20.0,
      110.0,
      120.0,
      60.0,
      60.0
    ];
    List<num> list2 = [
      20.0,
      110.0,
      120.0,
      60.0,
      60.0,
      150.0,
      30.0,
      20.0,
      110.0,
      120.0,
      60.0,
      60.0,
      40.0,
      50.0,
      30.0,
      60.0,
      90.0,
      20.0,
      70.0,
      30.0,
      60.0,
      90.0,
      20.0,
      70.0
    ];
    List<num> list2_2 = listAdd(list1, list2);
    num maxNum = list2_2.reduce(max);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 500,
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 40,
                      height: 500 / 4,
                      child: Text((maxNum).toString(), style: TextStyle(color: Colors.white)),
                    ),
                    Container(
                      width: 40,
                      height: 500 / 4,
                      child: Text((maxNum * 3 / 4).toString(), style: TextStyle(color: Colors.white)),
                    ),
                    Container(
                      width: 40,
                      height: 500 / 4,
                      child: Text((maxNum * 2 / 4).toString(), style: TextStyle(color: Colors.white)),
                    ),
                    Container(
                      // decoration: BoxDecoration(
                      //     border: Border(
                      //   top: BorderSide(
                      //     color: Colors.white,
                      //     width: 1,
                      //   ),
                      // )),
                      width: 40,
                      height: 500 / 4,
                      child: Text((maxNum / 4).toString(), style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.white,
                      width: 1,
                    )),
                    child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification is ScrollEndNotification) {
                            print("ScrollEndNotification");

                            Future.delayed(const Duration(milliseconds: 0), () {
                              int newPage = pageController.page.round();
                              print("end at $newPage");
                              pageController.animateToPage(newPage, duration: Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
                            });
                          }
                          return true;
                        },
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          pageSnapping: false,
                          controller: pageController,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 500,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: List.generate(list1.length, (index) {
                                  return Bar(back: list2_2[index], front: list1[index], maxNum: maxNum);
                                }),
                              ),
                            );
                          },
                        )),
                  ),
                ),
              ],
            )

            // Listener(
            //   onPointerDown: (PointerEvent event) {
            //     // _recognizer.addPointer(event);
            //     // GestureBinding.instance.gestureArena.add(event.pointer, _recognizer);
            //     // if (widget.onPointerDown != null) widget.onPointerDown(event);
            //     print("onPointerDown");
            //   },
            //   onPointerMove: (event) {
            //     print("onPointerMove");
            //   },
            //   onPointerUp: (event) {
            //     print("onPointerUp");
            //   },
            //   // others
            //   onPointerCancel: (event) {
            //     print("onPointerCancel");
            //   },
            //   // onPointerEnter: widget.onPointerEnter,
            //   // onPointerExit: widget.onPointerExit,
            //   // onPointerHover: widget.onPointerHover,
            //   onPointerSignal: (event) {
            //     print("onPointerSignal");
            //   },
            //   child: SingleChildScrollView(
            //     controller: _controller,
            //     scrollDirection: Axis.horizontal,
            //     child: Container(
            //       height: 500,
            //       child: Row(
            //         crossAxisAlignment: CrossAxisAlignment.end,
            //         children: List.generate(list1.length, (index) {
            //           return Bar(back: list2_2[index], front: list1[index], maxNum: maxNum);
            //         }),
            //       ),
            //     ),
            //   ),
            // ),

            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final double back;
  final double front;
  final double maxNum;
  Bar({
    Key key,
    this.back,
    this.front,
    this.maxNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Column(children: [
              Container(
                width: (MediaQuery.of(context).size.width - 58) / 24,
                height: (500 - 2) / 4,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                )),
                width: (MediaQuery.of(context).size.width - 58) / 24,
                height: (500 - 2) / 4,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                )),
                width: (MediaQuery.of(context).size.width - 58) / 24,
                height: (500 - 2) / 4,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                )),
                width: (MediaQuery.of(context).size.width - 58) / 24,
                height: (500 - 2) / 4,
              ),
            ]),
            Container(
              color: Color.fromRGBO(254, 87, 18, 1),
              height: back * 500 / maxNum,
              width: 5,
            ),
            Container(
              color: Color.fromRGBO(255, 153, 0, 1),
              height: front * 500 / maxNum,
              width: 5,
            ),
          ],
        ),
      ],
    );
  }
}
