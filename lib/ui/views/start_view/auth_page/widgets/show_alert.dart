import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ShowAlert extends StatefulWidget {
  String warning;
  final viewModel;
  ShowAlert({Key key, this.warning, this.viewModel}) : super(key: key);
  @override
  _ShowAlertState createState() => _ShowAlertState();
}

class _ShowAlertState extends State<ShowAlert> {
  bool _cancelAlert = false;

  @override
  Widget build(BuildContext context) {
    if (widget.warning.isNotEmpty) {
      return widget.viewModel.alertMessage == ''
          ? Container()
          : Dismissible(
              key: ValueKey('1'),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                print('remove');
                setState(() {
                  _cancelAlert = true;
                  widget.viewModel.alertMessage = '';
                });
              },
              child: AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  width: double.infinity,
                  decoration:
                      BoxDecoration(color: Colors.amberAccent, boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.blue[600].withOpacity(.3),
                    ),
                  ]),
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.error_outline),
                    ),
                    Expanded(
                      child: AutoSizeText(
                        widget.warning,
                        maxLines: 3,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _cancelAlert = true;
                            widget.viewModel.alertMessage = '';
                          });
                          print(_cancelAlert);
                        },
                      ),
                    )
                  ])),
            );
    }
    return SizedBox(
      height: 0,
    );
  }
}
