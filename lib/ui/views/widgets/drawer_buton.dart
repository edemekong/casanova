import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  final String title;
  final onTap;
  final IconData icon;
  final Color iconColor;
  final Color color;
  final isLeading;

  const DrawerButton(
      {Key key,
      this.title,
      this.onTap,
      this.icon,
      this.color,
      this.isLeading,
      this.iconColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[600]),
        textAlign: TextAlign.start,
      ),
      onTap: onTap,
      selected: true,
      trailing:
          Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 10),
      leading: isLeading ? Icon(icon, color: iconColor, size: 20) : null,
    );
  }
}
