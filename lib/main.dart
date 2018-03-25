import 'package:flutter/material.dart';
import 'package:async/async.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _money = 0;
  void _incrementCounter() {
    setState(() {
      _money++;
    });
  }
  void _gainCoin(value) {
    setState((){
      _money += value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Text(
              'Money',
            ),
            new Text(
              '$_money',
              style: Theme.of(context).textTheme.display1,
            ),
            new ActivityButton(
                name : "I am buttons, yes",
                onPressed: _incrementCounter,
                color : Colors.green,
                textColor : Colors.white,
            ),
            new ActivityButton(
              name: "Building 1",
              onPressed: (){
                new Building(value:5,state:this);
              },
            )
          ],
        ),
      ),
    );
  }
}

class ActivityButton extends StatelessWidget {
  final String name;
  final onPressed;
  final Color color;
  final Color textColor;
  ActivityButton({Key key, this.name, this.onPressed, this.color, this.textColor}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return new MaterialButton(
        onPressed: this.onPressed,
        textColor: this.textColor,
        color: this.color,
        child: new Text(name));
  }
}

class Building {
  final int value;
  final _MyHomePageState state;
  var _timer;

  void _coinProc(){
    this.state._gainCoin(value);
    _timer.reset();
  }
  Building({Key key, this.state, this.value}){
    _timer = new RestartableTimer(new Duration(seconds: 1), _coinProc);
  }
}