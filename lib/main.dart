import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController tb;
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stopped = true;
  String timeToDisplay = "";
  int timeForTimer;
  final dur = const Duration(seconds: 1);
  bool cancelTimer = false;
  

  @override
  void initState() {
    super.initState();
    tb = TabController(
      length: 2,
      vsync: this,
    );
  }

  void start() {
    setState(() {
      started = false;
      stopped = false;
    });
    timeForTimer = ((hour * 3600) + (min * 60) + sec);
    Timer.periodic(dur, (Timer t) {
      setState(() {
        if (timeForTimer < 1 || cancelTimer == true) {
          t.cancel();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(),
              ));
        } else if (timeForTimer < 60) {
          timeToDisplay = timeForTimer.toString();
          timeForTimer = timeForTimer - 1;
        } else if (timeForTimer < 3600) {
          int m = timeForTimer ~/ 60;
          int s = timeForTimer - (60 * m);
          timeToDisplay = m.toString() + ":" + s.toString();
          timeForTimer = timeForTimer - 1;
        } else {
          int h = timeForTimer ~/ 3600;
          int t = timeForTimer - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          timeToDisplay =
              h.toString() + ":" + m.toString() + ":" + s.toString();
          timeForTimer = timeForTimer - 1;
        }
      });
    });
  }

  void stop() {
    setState(() {
      started = false;
      stopped = false;
      cancelTimer = true;
      timeToDisplay = "";
    });
  }

  Widget timer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,              
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text(
                        'HH',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: hour,
                      minValue: 0,
                      maxValue: 23,
                      listViewWidth: 80.0,
                      onChanged: (val) {
                        setState(() {
                          hour = val;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text(
                        'MM',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: min,
                      minValue: 0,
                      maxValue: 23,
                      listViewWidth: 80.0,
                      onChanged: (val) {
                        setState(() {
                          min = val;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text(
                        'SS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: sec,
                      minValue: 0,
                      maxValue: 23,
                      listViewWidth: 80.0,
                      onChanged: (val) {
                        setState(() {
                          sec = val;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0 ),
            child: Expanded(
              flex: 2,
              child: Text(
                '$timeToDisplay',
                style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 80.0,
                  fontWeight: FontWeight.w900,                
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: started ? start : null,
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(
                      horizontal: 162.0,
                      vertical: 15.0,
                    ),
                    child: Text(
                      'Start',
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: stopped ? null : stop,
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 162.0,
                      vertical: 15.0,
                    ),
                    child: Text(
                      'Stop',
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


  bool startIsPressed = true;
  bool stopIsPressed = true;
  bool resetIsPressed = true;
  String stopTimeToDisplay = "00:00:00";
  var sWatch = Stopwatch();
  final durone = const Duration(seconds: 1);

  void startTimer(){
    Timer(durone , keepRunning);
  }

  void keepRunning(){
    if(sWatch.isRunning){
      startTimer();
    }
    setState((){
      stopTimeToDisplay = sWatch.elapsed.inHours.toString().padLeft(2,"0") + ":" + (sWatch.elapsed.inMinutes%60).toString().padLeft(2,"0") + ":" + (sWatch.elapsed.inSeconds%60).toString().padLeft(2,"0") ;


    });


  }

  void startStopWatch(){
    setState((){
      stopIsPressed = false;
      startIsPressed = false;
    });
    sWatch.start();
    startTimer();

  }

  void stopStopWatch(){
    setState((){
      stopIsPressed = true;
      resetIsPressed = false;
    });
    sWatch.stop();


  }

  void restartStopWatch(){
    setState((){
      startIsPressed = true;
      resetIsPressed = true;
    });
    sWatch.reset();
    stopTimeToDisplay = '00:00:00';

  }

  Widget stopwatch() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                stopTimeToDisplay,
                style: TextStyle(
                  fontSize: 80.0,
                  fontFamily: 'Times New Roman',
                  fontWeight: FontWeight.w900,

                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                      child: RaisedButton(
                        color: Colors.green,
                        onPressed: startIsPressed ? startStopWatch : null,
                        child: Text(
                          'Start',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Times New Roman',
                              fontSize: 18.0,
                              color: Colors.white),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 162.0,
                          vertical: 5.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 10.0, 5.0, 0.0),
                              child: RaisedButton(
                                color: Colors.red,
                                onPressed: stopIsPressed ? null : stopStopWatch ,
                                child: Text(
                                  'Stop',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Times New Roman',
                                      fontSize: 18.0,
                                      color: Colors.white),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 35.0,
                                  vertical: 15.0,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  5.0, 10.0, 10.0, 0.0),
                              child: RaisedButton(
                                color: Colors.black,
                                onPressed: resetIsPressed ? null : restartStopWatch,
                                child: Text(
                                  'Reset',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Times New Roman',
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 35.0,
                                  vertical: 15.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Watch',
          style: TextStyle(
            fontSize: 25.0,
            fontFamily: 'Times New Roman',
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          tabs: <Widget>[
            Text(
              'Timer',
            ),
            Text(
              'Stopwatch',
            ),
          ],
          labelStyle: TextStyle(
            fontSize: 18.0,
            fontFamily: 'TImes New Roman',
            fontWeight: FontWeight.bold,
          ),
          labelPadding: EdgeInsets.only(
            bottom: 10.0,
          ),
          unselectedLabelColor: Colors.white,
          controller: tb,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          timer(),
          stopwatch(),
        ],
        controller: tb,
      ),
    );
  }
}
