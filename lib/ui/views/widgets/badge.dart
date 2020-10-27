import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  const Badge({
    Key key,
    @required this.child,
    @required this.value,
    this.color,
  }) : super(key: key);

  final Widget child;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        child,
        value == '0'
            ? Container()
            : Positioned(
                right: -2,
                top: -2,
                child: Container(
                  padding: EdgeInsets.all(1.0),
                  // color: Theme.of(context).accentColor,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 3),
                    borderRadius: BorderRadius.circular(40.0),
                    color: color != null ? color : Colors.orange,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 20,
                    minHeight: 12,
                  ),
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
      ],
    );
  }
}
