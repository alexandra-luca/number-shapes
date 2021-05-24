import 'package:flutter/material.dart';

void main() {
  runApp(NumberShapesApp());
}

class NumberShapesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Shapes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NumberShapesPage(title: "Number Shapes"),
    );
  }
}

class NumberShapesPage extends StatefulWidget {
  NumberShapesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NumberShapesPageState createState() => _NumberShapesPageState();
}

class _NumberShapesPageState extends State<NumberShapesPage> {
  TextEditingController _numberShapeController = new TextEditingController();
  final _form = GlobalKey<FormState>();
  int _n;

  void _checkNumberShape() {
    setState(() {
      if (!_form.currentState.validate()) {
        return;
      }

      _n = int.parse(_numberShapeController.text);

      bool _isSquare = false;
      for (int i = 1; i * i <= _n; i++) {
        if (i * i == _n) {
          _isSquare = true;
        }
      }

      bool _isCube = false;
      for (int i = 1; i * i * i <= _n; i++) {
        if (i * i * i == _n) {
          _isCube = true;
        }
      }

      if (_isSquare && _isCube) {
        _showAlert(context, "Number $_n is both SQUARE and CUBE.");
      } else if (_isSquare) {
        _showAlert(context, "Number $_n is SQUARE.");
      } else if (_isCube) {
        _showAlert(context, "Number $_n is CUBE.");
      } else {
        _showAlert(context, "Number $_n is neither SQUARE nor CUBE.");
      }
    });
  }

  void _showAlert(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      title: Text("$_n"),
      content: Text(message),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Form(
        key: _form,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                child: Text(
                  "Please input a number to see if it is square or cube.",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _numberShapeController,
                  validator: (text) {
                    if (text.isEmpty || double.tryParse(text) == null) {
                      return "Please enter a number!";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30.0),
                child: IconButton(
                    icon: Icon(Icons.check_circle),
                    onPressed: _checkNumberShape,
                    color: Colors.purpleAccent,
                    iconSize: 50.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
