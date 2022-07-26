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
import 'package:picos/screens/family_members_add_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/picos_list_card.dart';

/// builds 'Column' as a parent widget for the given cards
class MyCard extends StatelessWidget {
  /// MyCard constructor
  const MyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Declaration of the List-variable 'cards' for building
    /// the main components of the UI of this screen
    List<CustomCard> cards;

    /// A fixed list of Strings denoting the type of family members
    List<String> familyMemberType = <String>[
      AppLocalizations.of(context)!.father,
      AppLocalizations.of(context)!.mother,
      AppLocalizations.of(context)!.brother,
      AppLocalizations.of(context)!.sister,
    ];

    /// generates a list of CustomCard-Widgets
    cards = List<CustomCard>.generate(
      familyMemberType.length,
      (int index) => CustomCard(
        memberType: familyMemberType.elementAt(index),
      ),
    );

    return Column(
      children: cards,
    );
  }
}

/// This class serves for customizing the card properties showing information
/// about the corresponding family member
class CustomCard extends StatelessWidget {
  /// CustomCard constructor
  const CustomCard({
    required this.memberType,
    Key? key,
  }) : super(key: key);

  /// initialized memberType-variable which is used to
  /// show the family member type
  final String memberType;

  @override
  Widget build(BuildContext context) {
    return PicosListCard(
      title: memberType,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${AppLocalizations.of(context)!.mr} Max Mustermann',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('Musterstraße 1'),
            const Text('00000 Musterstadt'),
            const Text('Tel. +49 000 12 34 56'),
            const Text('name@webmail.de'),
          ],
        ),
      ),
    );


  }
}

/// This is the screen in which a user will see a list of his family members
class FamilyMembers extends StatelessWidget {
  /// FamilyMembers constructor
  const FamilyMembers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.familyMembers),
        backgroundColor: const Color.fromRGBO(
          25,
          102,
          117,
          1.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromRGBO(
            232,
            241,
            243,
            1,
          ),
          child: const MyCard(),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color.fromRGBO(
                          149,
                          193,
                          31,
                          1,
                        ),
                        Color.fromRGBO(
                          110,
                          171,
                          39,
                          1,
                        ),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext context) =>
                            const FamilyMembersAdd(),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.add,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}