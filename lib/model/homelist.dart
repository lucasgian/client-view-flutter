import 'package:client_view_flutter/design_order/home_design_order.dart';
import 'package:flutter/widgets.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'https://assets.stahls.com/stahls/content/images/education/shipping/shipping-group.png',
      navigateScreen: DesignOrderHomeScreen(),
    ),
  ];
}
