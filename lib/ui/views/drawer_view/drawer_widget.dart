import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../model/layout_models/drawer_models.dart';
import '../../../model/user/user.dart';
import '../../../ui/views/order_view/order_view.dart';
import '../../../ui/views/profile_view/edit_profile.dart';
import '../../../ui/views/profile_view/profile_view.dart';
import '../../../ui/views/widgets/alert_dialog.dart';
import '../../../ui/views/widgets/drawer_buton.dart';
import '../../../view_models/drawer_view_model/drawer_view_model.dart';
import '../../../view_models/theme_view_model/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'contact_page/contact_view.dart';

class DrawerView extends StatefulWidget {
  final Users user;

  const DrawerView({Key key, this.user}) : super(key: key);
  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeModel>(context, listen: false);
    final drawerModel = Provider.of<DrawerViewModel>(context, listen: false);

    final user = widget.user;

    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width / 1.3,
      child: Drawer(
        child: Container(
          color: Colors.blue[100].withOpacity(.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(16),
                child: SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () => pushToNextPage(context, ProfileView()),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[300],
                          child: CircleAvatar(
                            radius: 29,
                            backgroundImage:
                                CachedNetworkImageProvider(user.imageUrl),
                            backgroundColor: Colors.grey[200],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(height: 10),
                            AutoSizeText(
                                'Good ${drawerModel.greeting()},\n${user.firstName.toUpperCase()}!!',
                                style: TextStyle(
                                    color: primaryButtonColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 2),
                            Container(
                              child: AutoSizeText('${user.email}',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Scrollbar(
                  child: ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 16, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'MY DAILY WASH ACCOUNT',
                              style: TextStyle(fontSize: 12, color: grey600),
                            ),
                          ],
                        ),
                      ),
                      IntrinsicHeight(
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.yellow,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                                children: List.generate(
                              drawerModel.accountButtons.length,
                              (i) => DrawerButton(
                                isLeading: true,
                                iconColor: Colors.white,
                                title:
                                    drawerModel.accountButtons[i].buttonTitle,
                                onTap: () => _navigateToPage(
                                  context,
                                  accountButtons: drawerModel.accountButtons[i],
                                ),
                                icon: drawerModel.accountButtons[i].leadingIcon,
                                // color: buttons[i].buttonColor,
                              ),
                            ))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 16, bottom: 8),
                        child: Text(
                          'MY SETTINGS',
                          style: TextStyle(fontSize: 12, color: grey600),
                        ),
                      ),
                      IntrinsicHeight(
                        child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Column(
                                children: List.generate(
                              drawerModel.settingsButton.length,
                              (i) => DrawerButton(
                                isLeading: false,
                                title:
                                    drawerModel.settingsButton[i].buttonTitle,
                                onTap: () => _settingsNavigateToPage(context,
                                    settingsButton:
                                        drawerModel.settingsButton[i]),
                                icon: drawerModel.settingsButton[i].leadingIcon,
                                // color: buttons[i].buttonColor,
                              ),
                            ))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: InkWell(
                          onTap: () => showDialog(
                              context: context,
                              builder: (ctx) => CustomAlertDialog(
                                    title: 'Log Out?',
                                    content: 'Do you want to log-out?',
                                    onTapYes: () =>
                                        drawerModel.authApi.signOut(context),
                                  )),
                          child: Center(
                            child: Text(
                              'LOGOUT',
                              style: TextStyle(
                                  color: primaryButtonColor, fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToPage(context, {DrawerButtonModels accountButtons}) {
    if (accountButtons.buttonTitle == 'Orders') {
      pushToNextPage(context, OrdersView(isRateNReviewClicked: false));
    } else if (accountButtons.buttonTitle == 'Saved Items') {
      pushToNextPage(context, OrdersView(isRateNReviewClicked: true));
    } else if (accountButtons.buttonTitle == 'Rate And Review') {
      pushToNextPage(context, OrdersView(title: 'Rate And Review'));
    } else if (accountButtons.buttonTitle == 'My Profile') {
      pushToNextPage(context, ProfileView());
    } else if (accountButtons.buttonTitle == 'Contact') {
      pushToNextPage(context, Contact());
    }
  }

  _settingsNavigateToPage(context, {DrawerButtonModels settingsButton}) {
    if (settingsButton.buttonTitle == 'Address book') {
    } else if (settingsButton.buttonTitle == 'Edit Profile') {
      pushToNextPage(context, EditProfile(users: widget.user));
    } else if (settingsButton.buttonTitle == 'Setting') {}
  }

  pushToNextPage(context, classBody) async {
    Navigator.of(context).pop();
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => classBody));
  }
}
