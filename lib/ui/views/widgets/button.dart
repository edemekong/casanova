import 'package:casanova/view_models/theme_view_model/theme_model.dart';
import 'package:flutter/material.dart';

enum ButtonState { Initial, Loading, Done }

InkWell iconButtonWid(
    {IconData icon, double size, Function() onTap, Color color, bool disable}) {
  return InkWell(
    onTap: disable ? null : onTap,
    child: Container(
        height: size ?? null,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: disable ? Colors.grey[300] : color,
            )),
        child: Icon(
          icon,
          size: size ?? 20,
          color: disable ? Colors.grey[300] : color,
        )),
  );
}

IconButton iconButton({IconData icon, VoidCallback onTap}) {
  return IconButton(icon: Icon(icon), onPressed: onTap);
}

ButtonTheme raisedButtonAcrossApp(BuildContext context,
    {String title, Color textColor, Function() onTap, Color color}) {
  return ButtonTheme(
    height: 45,
    buttonColor: primaryButtonColor,
    child: RaisedButton(
      elevation: 0,
      onPressed: onTap,
      color: color,
      textColor: white,
      child: Text(title),
      shape: StadiumBorder(),
    ),
  );
}

flatButtonWithIcon(BuildContext context,
    {Function onPressed,
    IconData icon,
    String title,
    Color color,
    Color textColor}) {
  return FlatButton.icon(
      onPressed: onPressed,
      shape: StadiumBorder(),
      color: color == null ? primaryButtonColor : color,
      textColor: textColor ?? Colors.grey[800],
      icon: Icon(icon),
      label: Text(title));
}

flatButtonWithIconWid(
    {Function() onTap,
    Color color,
    String title,
    IconData icon,
    Color textColors}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          Text(
            title,
            style: TextStyle(color: textColors),
          ),
        ],
      ),
    ),
  );
}

Widget circleButton({IconData icon, Function onPressed, text}) {
  return Column(
    children: [
      MaterialButton(
        elevation: 3,
        onPressed: onPressed,
        color: Colors.orange,
        textColor: Colors.white,
        child: Icon(icon, size: 20),
        padding: EdgeInsets.all(10),
        shape: CircleBorder(),
      ),
      Text(text),
    ],
  );
}

class GradiantButton extends StatefulWidget {
  final Function onPressed;
  final String title;

  // final Widget titleWid;
  final ButtonState buttonState;

  final Color textColor;
  final double width;
  final bool isOutline;

  const GradiantButton({
    Key key,
    @required this.onPressed,
    this.title,
    this.textColor,
    // this.titleWid,

    this.width,
    this.buttonState,
    @required this.isOutline,
  }) : super(key: key);

  @override
  _GradiantButtonState createState() => _GradiantButtonState();
}

class _GradiantButtonState extends State<GradiantButton> {
  @override
  Widget build(BuildContext context) {
    print(widget.buttonState);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: widget.onPressed,
        child: Material(
          shape: StadiumBorder(),
          child: AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 400),
            width: widget.width == null
                ? (widget.buttonState == ButtonState.Loading
                    ? 50
                    : MediaQuery.of(context).size.width / 1.2)
                : widget.width,
            height: 45,
            decoration: BoxDecoration(
              color: widget.isOutline
                  ? Theme.of(context).scaffoldBackgroundColor
                  : null,
              border: widget.isOutline
                  ? Border.all(color: primaryButtonColor, width: 1.5)
                  : null,
              borderRadius: BorderRadius.circular(
                  widget.buttonState == ButtonState.Loading ? 50 : 30),
              gradient: widget.isOutline
                  ? null
                  : LinearGradient(colors: [
                      Colors.orange[300],
                      Colors.orange[500],
                      Colors.orange[400],
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Center(
              child: widget.buttonState == ButtonState.Loading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          widget.isOutline ? Colors.orange : Colors.white),
                    )
                  : Text(
                      widget.title,
                      style: TextStyle(
                          color:
                              widget.isOutline ? Colors.orange : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
