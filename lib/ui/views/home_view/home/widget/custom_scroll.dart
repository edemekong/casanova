import 'package:flutter/material.dart';

class CustomScroll extends StatelessWidget {
  final Widget widget;

  const CustomScroll({
    Key key,
    @required this.body,
    @required this.pageStorageKey,
    this.widget,
  }) : super(key: key);

  final List<Widget> body;
  final String pageStorageKey;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return CustomScrollView(
        physics: BouncingScrollPhysics(),
        key: PageStorageKey<String>(pageStorageKey),
        slivers: <Widget>[
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverList(
            delegate: SliverChildListDelegate(body??[]),
          ),

         widget??SliverToBoxAdapter(child: Container(),),



        ],
      );
    });
  }
}
