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
import 'package:picos/api/backend_patients_list_api.dart';
import 'package:picos/models/patient_data.dart';
import 'package:picos/models/patient_profile.dart';
import 'package:picos/models/patients_list_element.dart';
import 'package:picos/state/objects_list_bloc.dart';
import 'package:picos/widgets/picos_add_button_bar.dart';
import 'package:picos/widgets/picos_body.dart';
import 'package:picos/widgets/picos_label.dart';
import 'package:picos/widgets/picos_screen_frame.dart';
import 'package:picos/widgets/picos_select.dart';
import 'package:picos/widgets/picos_switch.dart';
import 'package:picos/widgets/picos_text_field.dart';

/// A screen for adding new patient.
class EditPatientScreen extends StatefulWidget {
  /// Creates the AddPatientScreen.
  const EditPatientScreen({Key? key}) : super(key: key);

  @override
  State<EditPatientScreen> createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  /// Local variable for weight and BMI.
  bool _weightBMI = false;

  /// Local variable for heart frequency.
  bool _heartFrequency = false;

  /// Local variable for blood pressure.
  bool _bloodPressure = false;

  /// Local variable for blood sugar levels.
  bool _bloodSugarLevels = false;

  /// Local variable for walk distance.
  bool _walkDistance = false;

  /// Local variable for sleep duration.
  bool _sleepDuration = false;

  /// Local variable for sleep quality.
  bool _sleepQuality = false;

  /// Local variable for pain.
  bool _pain = false;

  /// Local variable for blood PHQ4.
  bool _phq4 = false;

  /// Local variable for medication.
  bool _medication = false;

  /// Local variable for therapy.
  bool _therapy = false;

  /// Local variable for doctor visits.
  bool _doctorsVisit = false;

  /// Local variable for case number.
  String _caseNumber = '';

  /// Local variable for Patient ID.
  String _patientID = '';

  /// Local vcariable for institute key.
  String _instituteKey = '';

  /// Local variable for body height.
  double _bodyHeight = 0.0;

  /// Determines if you are able to add the patient.
  bool _addDisabled = true;

  String? _title;

  PatientsListElement? _patientsListElement;

  @override
  Widget build(BuildContext context) {
    if (_patientsListElement == null) {
      PatientsListElement? patientsListElement =
          ModalRoute.of(context)!.settings.arguments as PatientsListElement;

      _patientsListElement = patientsListElement;

      _title = '${_patientsListElement!.patient.firstName} '
          '${_patientsListElement!.patient.familyName}';

      _weightBMI = _patientsListElement!.patientProfile.weightBMIEnabled;
      _heartFrequency =
          _patientsListElement!.patientProfile.heartFrequencyEnabled;
      _bloodPressure =
          _patientsListElement!.patientProfile.bloodPressureEnabled;
      _bloodSugarLevels =
          _patientsListElement!.patientProfile.bloodSugarLevelsEnabled;
      _walkDistance = _patientsListElement!.patientProfile.walkDistanceEnabled;
      _sleepDuration =
          _patientsListElement!.patientProfile.sleepDurationEnabled;
      _sleepQuality = _patientsListElement!.patientProfile.sleepQualityEnabled;
      _pain = _patientsListElement!.patientProfile.painEnabled;
      _phq4 = _patientsListElement!.patientProfile.phq4Enabled;
      _medication = _patientsListElement!.patientProfile.medicationEnabled;
      _therapy = _patientsListElement!.patientProfile.therapyEnabled;
      _doctorsVisit = _patientsListElement!.patientProfile.doctorsVisitEnabled;

      _bodyHeight = _patientsListElement!.patientData.bodyHeight;
      _patientID = _patientsListElement!.patientData.patientID;
      _caseNumber = _patientsListElement!.patientData.caseNumber;
      _instituteKey = _patientsListElement!.patientData.instKey;
    }

    return BlocBuilder<ObjectsListBloc<BackendPatientsListApi>,
        ObjectsListState>(
      builder: (BuildContext context, ObjectsListState state) {
        if (state.status == ObjectsListStatus.initial ||
            state.status == ObjectsListStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == ObjectsListStatus.failure) {
          return const Center(
            child: Text('Error'),
          );
        }

        return PicosScreenFrame(
          body: PicosBody(
            child: Column(
              children: <Widget>[
                PicosLabel(AppLocalizations.of(context)!.vitalValues),
                PicosSwitch(
                  initialValue: _weightBMI,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _weightBMI = value;
                    });
                  },
                  title: AppLocalizations.of(context)!.weightBMI,
                  shape: const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosSwitch(
                  initialValue: _heartFrequency,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _heartFrequency = value;
                    });
                  },
                  title: AppLocalizations.of(context)!.heartFrequency,
                  shape: const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosSwitch(
                  initialValue: _bloodPressure,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _bloodPressure = value;
                    });
                  },
                  title: AppLocalizations.of(context)!.bloodPressure,
                  shape: const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosSwitch(
                  initialValue: _bloodSugarLevels,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _bloodSugarLevels = value;
                    });
                  },
                  title: AppLocalizations.of(context)!.bloodSugar,
                  shape: const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosLabel(AppLocalizations.of(context)!.activityAndRest),
                const SizedBox(
                  height: 10,
                ),
                PicosSwitch(
                  initialValue: _walkDistance,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _walkDistance = value;
                    });
                  },
                  title: AppLocalizations.of(context)!.walkDistance,
                  shape: const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosSwitch(
                  initialValue: _sleepDuration,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _sleepDuration = value;
                    });
                  },
                  title: AppLocalizations.of(context)!.sleepDuration,
                  shape: const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosSwitch(
                  initialValue: _sleepQuality,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _sleepQuality = value;
                    });
                  },
                  title: AppLocalizations.of(context)!.sleepQuality,
                  shape: const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosLabel(AppLocalizations.of(context)!.bodyAndMind),
                const SizedBox(
                  height: 10,
                ),
                PicosSwitch(
                  initialValue: _pain,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _pain = value;
                    });
                  },
                  title: AppLocalizations.of(context)!.pain,
                  shape: const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosSwitch(
                  initialValue: _phq4,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _phq4 = value;
                    });
                  },
                  title: 'PHQ-4',
                  shape: const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosLabel(
                  AppLocalizations.of(context)!.medicationAndTherapy,
                ),
                const SizedBox(
                  height: 10,
                ),
                PicosSwitch(
                  initialValue: _medication,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _medication = value;
                    });
                  },
                  title: AppLocalizations.of(context)!.medication,
                  shape: const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosSwitch(
                  initialValue: _therapy,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _therapy = value;
                    });
                  },
                  title: AppLocalizations.of(context)!.therapy,
                  shape: const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosSwitch(
                  initialValue: _doctorsVisit,
                  onChanged: (bool value) {
                    setState(() {
                      _addDisabled = false;
                      _doctorsVisit = value;
                    });
                  },
                  title: AppLocalizations.of(context)!.doctorsVisit,
                  shape: const Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                PicosLabel(AppLocalizations.of(context)!.caseNumber),
                PicosTextField(
                  hint: _caseNumber,
                  onChanged: (String? value) {
                    setState(() {
                      _addDisabled = false;
                    });

                    _caseNumber = value!;
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.enterCaseNumber;
                    }
                    return null;
                  },
                ),
                PicosLabel(AppLocalizations.of(context)!.patientID),
                PicosTextField(
                  hint: _patientID,
                  onChanged: (String? value) {
                    setState(() {
                      _addDisabled = false;
                    });

                    _patientID = value!;
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.enterPatientID;
                    }
                    return null;
                  },
                ),
                PicosLabel(AppLocalizations.of(context)!.instituteKey),
                PicosSelect(
                  selection: const <String, String>{
                    '100': '100',
                    '101': '101',
                    '102': '102',
                    '103': '103',
                    '104': '104',
                    '105': '105',
                    '201': '201',
                    '300': '300',
                    '400': '400',
                    '501': '501',
                    '502': '502'
                  },
                  callBackFunction: (String? value) {
                    setState(() {
                      _addDisabled = false;
                    });

                    _instituteKey = value!;
                  },
                  hint: _instituteKey,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '''     ${AppLocalizations.of(context)!.enterInstituteKey}''';
                    }
                    return null;
                  },
                ),
                PicosLabel(AppLocalizations.of(context)!.height),
                PicosTextField(
                  hint: _bodyHeight.toString(),
                  onChanged: (String? value) {
                    setState(() {
                      _addDisabled = false;
                    });

                    _bodyHeight = double.parse(value!);
                  },
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value == null) {
                      return AppLocalizations.of(context)!.enterHeight;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          title: _title,
          bottomNavigationBar: PicosAddButtonBar(
            disabled: _addDisabled,
            onTap: () {
              if (_patientsListElement != null) {
                PatientData newPatientData;

                newPatientData = _patientsListElement!.patientData.copyWith(
                  bodyHeight: _bodyHeight,
                  patientID: _patientID,
                  caseNumber: _caseNumber,
                  instKey: _instituteKey,
                );

                PatientProfile newPatientProfile;
                newPatientProfile =
                    _patientsListElement!.patientProfile.copyWith(
                  weightBMIEnabled: _weightBMI,
                  heartFrequencyEnabled: _heartFrequency,
                  bloodPressureEnabled: _bloodPressure,
                  bloodSugarLevelsEnabled: _bloodSugarLevels,
                  walkDistanceEnabled: _walkDistance,
                  sleepDurationEnabled: _sleepDuration,
                  sleepQualityEnabled: _sleepQuality,
                  painEnabled: _pain,
                  phq4Enabled: _phq4,
                  medicationEnabled: _medication,
                  therapyEnabled: _therapy,
                  doctorsVisitEnabled: _doctorsVisit,
                );

                PatientsListElement newPatientListElement;

                newPatientListElement = _patientsListElement!.copyWith(
                  patient: _patientsListElement!.patient,
                  patientData: newPatientData,
                  patientProfile: newPatientProfile,
                );

                context
                    .read<ObjectsListBloc<BackendPatientsListApi>>()
                    .add(SaveObject(newPatientListElement));
                Navigator.of(context).pop();
              }
            },
          ),
        );
      },
    );
  }
}
