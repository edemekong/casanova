import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import '../../../images_assets/images_assets.dart';
import '../../../services/auth_api/auth_api.dart';
import '../../../ui/views/cart_view/cart_view.dart';
import '../../../ui/views/drawer_view/drawer_widget.dart';
import '../../../ui/views/home_view/widget/bottom_nav.dart';
import '../../../ui/views/order_view/order_view.dart';
import '../../../ui/views/profile_view/profile_view.dart';
import '../../../ui/views/home_view/widget/home_appbar.dart';
import '../../../ui/views/start_view/auth_page/widgets/custom_curves.dart';
import '../../../view_models/home_view_model/home_view_model.dart';
import 'package:provider/provider.dart';
import './widget/top_home_buttons.dart';
import 'home/home.dart';

class HomeView extends StatefulWidget {
  static String routeName = '/home';
  static GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final authApi = GetIt.I.get<AuthApi>();

  final ScrollController controller = ScrollController();
  ValueNotifier<bool> visible = ValueNotifier<bool>(true);

  @override
  void initState() {
    visible.value = false;
    controller.addListener(
      () {
        if (controller.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (visible.value) {
            visible.value = false;
          }
        }

        if (controller.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!visible.value) {
            visible.value = true;
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final users = authApi.users;
    return Consumer<HomeViewModel>(builder: (context, homeModel, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        drawer: DrawerView(user: users),
        key: HomeView.scaffoldkey,
        body: Container(
          color: Colors.blue[100].withOpacity(.2),
          child: HomeAppBar(
            topHomeButton: TopHomeButtons(imageUrl: users.imageUrl),
            checkMenu: true,
            title: Container(
                width: MediaQuery.of(context).size.width / 2.2,
                child: Image.asset(ImageAssets.nameLogo)),
            child: PageView(
              controller: homeModel.pageController,
              onPageChanged: homeModel.onPageChanged,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Home(users: users, controller: controller),
                Order(isRateNReviewClicked: false),
                OrderCart(),
                Profile(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: ValueListenableBuilder(
            valueListenable: visible,
            builder: (context, bool value, child) {
              print(value);
              return AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: value ? 56.0 : 0.0,
                  child: Wrap(children: <Widget>[
                    HomeBottomNavigatorBar(homeModel: homeModel)
                  ]));
            }),
      );
    });
  }
}
