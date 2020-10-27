import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import '../../../../model/user/user.dart';
import '../../../../services/auth_api/auth_api.dart';
import '../../../../ui/views/product_view/products/all_products.dart';
import '../../../../view_models/home_view_model/home_view_model.dart';

class Home extends StatefulWidget {
  final ScrollController controller;
  final Users users;

  Home({Key key, this.users, this.controller}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  var authApi = GetIt.I.get<AuthApi>();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context, homeModel, child) {
      return Container(
        child: CasanovaStore(),
      );
    });
  }
}

class CasanovaStore extends StatelessWidget {
  const CasanovaStore({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AllProducts();
  }
}
