import 'package:flutter/cupertino.dart';
import '../base_view_model.dart';

class AdsViewModel extends BaseViewModel {
  int pageIndex = 0;
  PageController pageController;

  AdsViewModel() {
    pageController = PageController(viewportFraction: 0.8);
  }

  void onPageChanged(int pageIndex) {
    this.pageIndex = pageIndex;
    notifyListeners();
  }

  void onTapChangePageView(int pageIndeX) {
    pageController.animateToPage(
      pageIndeX,
      duration: Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
    );
    notifyListeners();
  }

  loop(context) {}
}
