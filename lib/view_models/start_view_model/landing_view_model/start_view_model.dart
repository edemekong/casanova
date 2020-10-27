import 'package:flutter/material.dart';

import '../../base_view_model.dart';

class StartPageViewModel extends BaseViewModel {
  int pageIndex = 0;
  PageController pageController;

  StartPageViewModel() {
    pageController = PageController();
  }

  void onPageChanged(int pageIndex) {
    this.pageIndex = pageIndex;
    notifyListeners();
  }

  void onTapChangePageView(int pageIndeX) {
    pageController.jumpToPage(pageIndeX);
    notifyListeners();
  }
}
