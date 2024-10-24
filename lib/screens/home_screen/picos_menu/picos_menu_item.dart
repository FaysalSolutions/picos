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

import '../../../themes/global_theme.dart';
import '../../../widgets/picos_svg_icon.dart';

/// An menu item for the picos menu.
class PicosMenuItem extends StatelessWidget {
  /// Creates a PicosMenuItem.
  const PicosMenuItem({
    Key? key,
    this.iconPath,
    this.title,
    this.onTap,
    this.iconSize = 27,
  }) : super(key: key);

  /// A path to the icon to display before the title.
  final String? iconPath;

  /// The title, where the menu item leads.
  final String? title;

  /// Called when the user taps this list tile.
  final void Function()? onTap;

  /// The size of the icon.
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final GlobalTheme theme = Theme.of(context).extension<GlobalTheme>()!;
    Widget? leadingIcon;
    const double padding = 15;

    if (iconPath != null) {
      leadingIcon = PicosSvgIcon(
        assetName: iconPath!,
        height: iconSize,
        width: iconSize,
      );
    }

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: <Widget>[
            const SizedBox(
              width: padding,
            ),
            SizedBox(width: 50, child: leadingIcon),
            const SizedBox(
              width: padding,
            ),
            Expanded(
              child: Text(
                title ?? '',
                style: const TextStyle(fontSize: 17),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 50,
              color: theme.darkGreen2,
            ),
            const SizedBox(
              width: padding,
            )
          ],
        ),
      ),
    );
  }
}
