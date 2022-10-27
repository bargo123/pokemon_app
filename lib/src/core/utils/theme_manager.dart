import 'package:flutter/material.dart';
import 'package:pokedex/locator.dart';
import 'package:pokedex/src/core/utils/custom_textstyle.dart';

import '../constants/color_constants.dart';
import '../paints/tab_indecator_painter.dart';

class ThemeManager {
  ThemeData appTheme() {
    return ThemeData(
        scaffoldBackgroundColor: ColorConstants.color_0xffE8E8E8,
        tabBarTheme: TabBarTheme(
            indicator: CustomTabIndicator(radius: 10, indicatorHeight: 5, color: ColorConstants.color_0xff3558CD),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: ColorConstants.color_0xff161A33,
            labelStyle: locator<CustomTextStyle>().notoSansFont(fontSize: 16, color: ColorConstants.color_0xff161A33),
            unselectedLabelColor: ColorConstants.color_0xff6B6B6B,
            unselectedLabelStyle: locator<CustomTextStyle>()
                .notoSansFont(fontSize: 16, color: ColorConstants.color_0xff161A33, fontWeight: FontWeight.w400)),
        appBarTheme: const AppBarTheme(
          toolbarHeight: 80,
          backgroundColor: ColorConstants.color_0xffFFFFFF,
        ));
  }
}
