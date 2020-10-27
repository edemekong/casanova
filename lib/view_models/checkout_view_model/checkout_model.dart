import 'package:flutter/material.dart';

import '../base_view_model.dart';

class CheckoutModel extends BaseViewModel {
  int pageIndex = 0;
  PageController pageController;

  CheckoutModel() {
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
