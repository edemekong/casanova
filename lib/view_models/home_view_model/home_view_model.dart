import 'package:casanova/services/auth_api/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeViewModel extends ChangeNotifier {
  final authApi = GetIt.I.get<AuthApi>();

  final ScrollController controller = ScrollController();
  ValueNotifier<bool> visible = ValueNotifier<bool>(true);

  List<IconData> icons = [
    Icons.search,
    Icons.menu,
    Icons.more_vert,
  ];

  Future<void> getCurrentUser(String userID) {
    return authApi.getCurrentUser(userID);
  }

  int pageIndex = 0;
  PageController pageController;

  HomeViewModel() {
    pageController = PageController();
  }

  onPageChanged(int pageIndex) {
    this.pageIndex = pageIndex;
    notifyListeners();
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
    );
    notifyListeners();
  }
}
