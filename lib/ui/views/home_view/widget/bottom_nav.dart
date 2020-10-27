import 'package:casanova/ui/views/widgets/badge_with_value.dart';
import 'package:casanova/view_models/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeBottomNavigatorBar extends StatefulWidget {
  final HomeViewModel homeModel;
  const HomeBottomNavigatorBar({
    Key key,
    this.homeModel,
  }) : super(key: key);

  @override
  _HomeBottomNavigatorBarState createState() => _HomeBottomNavigatorBarState();
}

class _HomeBottomNavigatorBarState extends State<HomeBottomNavigatorBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.orange,
      elevation: 0.0,
      currentIndex: widget.homeModel.pageIndex,
      onTap: (index) => widget.homeModel.onTap(index),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.view_stream), label: 'Orders'),
        BottomNavigationBarItem(
            icon: BottomBadge(
              fontSize: 25,
              iconData: Icons.shopping_cart,
              color:
                  widget.homeModel.pageIndex == 2 ? Colors.orange : Colors.grey,
            ),
            label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
