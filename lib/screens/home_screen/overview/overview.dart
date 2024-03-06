/*   This file is part of Picos, a health tracking mobile app
*    Copyright (C) 2022 Healthcare IT Solutions GmbH
*
*    This program is free software: you can redistribute it and/or modify
*    it under the terms of the GNU General Public License as published by
*    the Free Software Foundation, either version 3 of the License, or
*    (at your option) any later version.
*
*    This program is distributed in the hope that it will be useful,
*    but WITHOUT ANY WARRANTY; without even the implied warranty of
*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*    GNU General Public License for more details.
*
*    You should have received a copy of the GNU General Public License
*    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picos/screens/home_screen/overview/widgets/contact_section.dart';
import 'package:picos/screens/home_screen/overview/widgets/graph_section.dart';
import 'package:picos/screens/home_screen/overview/widgets/my_health_section.dart';
import 'package:picos/screens/home_screen/overview/widgets/questionnaire_section.dart';
import '../../../themes/global_theme.dart';

/// Main widget using all subwidgets to build up the "overview"-screen
class Overview extends StatefulWidget {
  /// OverviewScreen constructor
  const Overview({Key? key}) : super(key: key);

  ///
  static bool isScrolled = false;

  @override
  createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  double appBarHeight = 0;
  double statusBarHeight = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appBarHeight = AppBar().preferredSize.height;
    statusBarHeight = MediaQuery.of(context).padding.top;
    _scrollController.addListener(_handleScroll);
    _setSystemNavigationBarColor(context);
  }

  void _handleScroll() {
    Overview.isScrolled =
        _scrollController.offset >= (appBarHeight + statusBarHeight);
    setState(() {
      _isScrolled = Overview.isScrolled;
    });
  }

  void _setSystemNavigationBarColor(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    final Color? statusBarColorValue;
    final Brightness? statusBarIconBrightnessValue;
    if (_isScrolled) {
      statusBarColorValue = theme.darkGreen1;
      statusBarIconBrightnessValue = Brightness.light;
    } else {
      statusBarColorValue = const Color(0xFFfdfbfe);
      statusBarIconBrightnessValue = Brightness.dark;
    }
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColorValue,
        statusBarIconBrightness: statusBarIconBrightnessValue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    _setSystemNavigationBarColor(context);
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 45,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Image>[
              Image.asset(
                'assets/PICOS_Logo_RGB.png',
                height: 75,
              ),
            ],
          ),
          const QuestionaireSection(),
          Container(
            color: theme.white,
            child: const GraphSection(),
          ),
          Container(
            color: theme.blue,
            child: const MyHealthSection(),
          ),
          const ContactSection(),
        ],
      ),
    );
  }
}
