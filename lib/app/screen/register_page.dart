import 'package:fit_tracker_app/app/utilities/textstyles.dart';
import 'package:fit_tracker_app/app/utilities/theme_helper.dart';
import 'package:fit_tracker_app/app/widget/commons.dart';
import 'package:fit_tracker_app/data/model/login_model.dart';
import 'package:fit_tracker_app/data/model/response_model.dart';
import 'package:fit_tracker_app/data/repository/engine_auth_dev.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum BaseGender { male, female }

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _dobController = TextEditingController();

  DateTime dateParam;

  BaseGender _character;

  bool _hasEdited = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: systemAccentColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined, color: systemWhiteColor),
            onPressed: () => _onWillPop(),
          ),
          title: Text('Registration', style: p16.white),
        ),
        body: SingleChildScrollView( child : Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
          ),
          width: double.infinity,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                // divider: ColumnDivider(20),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    style: p14.darkestGrey,
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                      fillColor: systemWhiteColor,
                      hintText: 'Email',
                      hintStyle: p14.grey,
                      labelText: 'Email',
                      labelStyle: p14.accent,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ),
                  SizedBox(height : 16),
                  TextField(
                    style: p14.darkestGrey,
                    controller: _passwordController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      fillColor: systemWhiteColor,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                      hintText: 'Password',
                      hintStyle: p14.grey,
                      labelText: 'Password',
                      labelStyle: p14.accent,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ),
                  SizedBox(height : 16),
                  TextField(
                    style: p14.darkestGrey,
                    controller: _nameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      fillColor: systemWhiteColor,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                      hintText: 'Nama',
                      hintStyle: p14.grey,
                      labelText: 'Nama',
                      labelStyle: p14.accent,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ),
                  SizedBox(height : 16),
                  Text("Gender"),
                  Column(
                    children: <Widget>[
                      ListTile(
                        title: Text('Male'),
                        leading: Radio<BaseGender>(
                          value: BaseGender.male,
                          groupValue: _character,
                          onChanged: (BaseGender value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text('Female'),
                        leading: Radio<BaseGender>(
                          value: BaseGender.female,
                          groupValue: _character,
                          onChanged: (BaseGender value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height : 16),
                  TextField(
                    style: p14.darkestGrey,
                    controller: _heightController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                      fillColor: systemWhiteColor,
                      hintText: 'Height',
                      hintStyle: p14.grey,
                      labelText: 'Height',
                      labelStyle: p14.accent,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ),
                  SizedBox(height : 16),
                  TextField(
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          theme: DatePickerTheme(
                              containerHeight: 210.0,
                              itemStyle: p14.black),
                          onConfirm: (date) {

                            String dateString = DateFormat('dd-MM-yyyy').format(date);
                            _dobController.text  = dateString;

                            setState(() {
                              dateParam = date;
                            });

                          }, currentTime: DateTime.now(), locale: LocaleType.id);
                    },
                    readOnly: true,
                    style: p14.darkestGrey,
                    controller: _dobController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                      fillColor: systemWhiteColor,
                      hintText: 'Dob',
                      hintStyle: p14.grey,
                      labelText: 'Dob',
                      labelStyle: p14.accent,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ),
                  SizedBox(height : 16),
                  _buildSaveButton(context)
                ],
              )
          ),
        )),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return InkWell(
      onTap: () async {

        try {

        final result = await APIRequest.account.createUserAuthentication(
            email: _emailController.text, password: _passwordController.text);



        if (result.user.uid != null ) {

          await APIRequest.account.createUserFirestore(
              _emailController.text, _nameController.text,
              _character.toString() == "BaseGender.male" ? "L" : "P", _heightController.text, dateParam.toString());

          Commons().snackbarInfo(context, 'Registration Success');

          Navigator.pop(context);

        } else {
          Commons().snackbarError(context, 'Registration Failed');
          }
        } catch (error) {
          Commons().snackbarError(context, 'Registration Failed ${error.toString()}');
        }
      },
      radius: 8,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        alignment: Alignment.center,
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(
          color: systemAccentColor,
          border: Border.all(width: 1, color: systemAccentColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Simpan',
          style: p14.semiBold.white,
        ),
      ),
    );
  }

  _onWillPop() {
    Navigator.pop(context, _hasEdited);
  }

}
