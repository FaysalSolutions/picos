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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:picos/api/backend_relatives_api.dart';
import 'package:picos/widgets/picos_add_button_bar.dart';

import '../../models/relative.dart';
import '../../state/objects_list_bloc.dart';
import '../../widgets/picos_body.dart';
import '../../widgets/picos_label.dart';
import '../../widgets/picos_screen_frame.dart';
import '../../widgets/picos_select.dart';
import '../../widgets/picos_text_field.dart';

/// This is the screen in which a user can add/edit
/// information about his family members
class AddFamilyMemberScreen extends StatefulWidget {
  /// FamilyMembersAdd constructor
  const AddFamilyMemberScreen({Key? key}) : super(key: key);

  @override
  State<AddFamilyMemberScreen> createState() => _AddFamilyMemberScreenState();
}

class _AddFamilyMemberScreenState extends State<AddFamilyMemberScreen> {
  static final Map<String, String> _selection = <String, String>{};
  static String? _typeOfRelation;
  static String? _firstName;
  static String? _familyName;
  static String? _email;
  static String? _phoneNumber;
  static String? _address;
  static String? _streetAndHouseNo;
  static String? _zipCode;
  static String? _city;
  static String? _addFamilyMember;
  static String? _editFamilyMember;

  //State
  String? _selectedType;
  String? _selectedFirstName;
  String? _selectedFamilyName;
  String? _selectedEmail;
  String? _selectedPhoneNumber;
  String? _selectedAddress;
  String? _selectedCity;
  Relative? _relativeEdit;
  String? _title;
  bool _disabledSave = true;

  void _checkInputs() {
    if (_selectedType == null ||
        _selectedFirstName == null ||
        _selectedFamilyName == null ||
        _selectedEmail == null ||
        _selectedPhoneNumber == null ||
        _selectedAddress == null ||
        _selectedCity == null ||
        _selectedType!.isEmpty ||
        _selectedFirstName!.isEmpty ||
        _selectedFamilyName!.isEmpty ||
        _selectedEmail!.isEmpty ||
        _selectedPhoneNumber!.isEmpty ||
        _selectedAddress!.isEmpty ||
        _selectedCity!.isEmpty) {
      setState(() {
        _disabledSave = true;
      });
      return;
    }

    setState(() {
      _disabledSave = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selection.isEmpty) {
      _selection.addAll(<String, String>{
        RelativeType.spouse.name: RelativeType.spouse.getLocalization(context),
        RelativeType.siblings.name:
            RelativeType.siblings.getLocalization(context),
        RelativeType.roommates.name:
            RelativeType.roommates.getLocalization(context),
        RelativeType.mother.name: RelativeType.mother.getLocalization(context),
        RelativeType.father.name: RelativeType.father.getLocalization(context),
        RelativeType.otherRelatives.name:
            RelativeType.otherRelatives.getLocalization(context),
      });

      _typeOfRelation = AppLocalizations.of(context)!.typeOfRelation;
      _firstName = AppLocalizations.of(context)!.firstName;
      _familyName = AppLocalizations.of(context)!.familyName;
      _email = AppLocalizations.of(context)!.email;
      _phoneNumber = AppLocalizations.of(context)!.phoneNumber;
      _address = AppLocalizations.of(context)!.address;
      _streetAndHouseNo = AppLocalizations.of(context)!.streetAndHouseNo;
      _zipCode = AppLocalizations.of(context)!.zipCode;
      _city = AppLocalizations.of(context)!.city;
      _addFamilyMember = AppLocalizations.of(context)!.addFamilyMember;
      _editFamilyMember = AppLocalizations.of(context)!.editFamilyMember;
    }

    _title = _addFamilyMember;
    Object? relativeEdit = ModalRoute.of(context)!.settings.arguments;

    if (_relativeEdit == null && relativeEdit != null) {
      _title = _editFamilyMember;
      _relativeEdit = relativeEdit as Relative;

      _selectedType = _relativeEdit!.type;
      _selectedFirstName = _relativeEdit!.firstName;
      _selectedFamilyName = _relativeEdit!.lastName;
      _selectedEmail = _relativeEdit!.mail;
      _selectedPhoneNumber = _relativeEdit!.phone;
      _selectedAddress = _relativeEdit!.address;
      _selectedCity = _relativeEdit!.city;
    }

    return BlocBuilder<ObjectsListBloc<BackendRelativesApi>, ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        const double columnPadding = 10;

        return PicosScreenFrame(
          title: _title,
          body: PicosBody(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: columnPadding),
                PicosSelect(
                  selection: _selection,
                  callBackFunction: (String value) {
                    _selectedType = value;
                    _checkInputs();
                  },
                  initialValue: _selectedType,
                  hint: _typeOfRelation,
                ),
                const SizedBox(height: columnPadding),
                PicosLabel(_firstName!),
                PicosTextField(
                  hint: _firstName!,
                  keyboardType: TextInputType.name,
                  initialValue: _selectedFirstName,
                  onChanged: (String value) {
                    _selectedFirstName = value;
                    _checkInputs();
                  },
                ),
                const SizedBox(height: columnPadding),
                PicosLabel(
                  _familyName!,
                ),
                PicosTextField(
                  hint: _familyName!,
                  keyboardType: TextInputType.name,
                  initialValue: _selectedFamilyName,
                  onChanged: (String value) {
                    _selectedFamilyName = value;
                    _checkInputs();
                  },
                ),
                const SizedBox(height: columnPadding),
                PicosLabel(_email!),
                PicosTextField(
                  hint: _email!,
                  keyboardType: TextInputType.emailAddress,
                  initialValue: _selectedEmail,
                  onChanged: (String value) {
                    _selectedEmail = value;
                    _checkInputs();
                  },
                ),
                const SizedBox(height: columnPadding),
                PicosLabel(_phoneNumber!),
                PicosTextField(
                  hint: _phoneNumber!,
                  keyboardType: TextInputType.phone,
                  initialValue: _selectedPhoneNumber,
                  onChanged: (String value) {
                    _selectedPhoneNumber = value;
                    _checkInputs();
                  },
                ),
                const SizedBox(height: columnPadding),
                PicosLabel(_address!),
                PicosTextField(
                  hint: _streetAndHouseNo!,
                  keyboardType: TextInputType.streetAddress,
                  initialValue: _selectedAddress,
                  onChanged: (String value) {
                    _selectedAddress = value;
                    _checkInputs();
                  },
                ),
                const SizedBox(height: columnPadding),
                PicosLabel(_city!),
                PicosTextField(
                  hint: '${_city!}, ${_zipCode!}',
                  keyboardType: TextInputType.streetAddress,
                  initialValue: _selectedCity,
                  onChanged: (String value) {
                    _selectedCity = value;
                    _checkInputs();
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: PicosAddButtonBar(
            disabled: _disabledSave,
            onTap: () {
              Relative relative = _relativeEdit != null
                  ? _relativeEdit!.copyWith(
                      type: _selectedType!,
                      address: _selectedAddress!,
                      city: _selectedCity!,
                      lastName: _selectedFamilyName!,
                      mail: _selectedEmail!,
                      phone: _selectedPhoneNumber!,
                      firstName: _selectedFirstName!,
                    )
                  : Relative(
                      type: _selectedType!,
                      address: _selectedAddress!,
                      city: _selectedCity!,
                      lastName: _selectedFamilyName!,
                      mail: _selectedEmail!,
                      phone: _selectedPhoneNumber!,
                      firstName: _selectedFirstName!,
                    );

              context
                  .read<ObjectsListBloc<BackendRelativesApi>>()
                  .add(SaveObject(relative));
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}
