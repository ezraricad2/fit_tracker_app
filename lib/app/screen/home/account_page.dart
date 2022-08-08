import 'package:fit_tracker_app/app/screen/login/login_page.dart';
import 'package:fit_tracker_app/app/utilities/account_helper.dart';
import 'package:fit_tracker_app/app/utilities/assets.dart';
import 'package:fit_tracker_app/app/utilities/routing.dart';
import 'package:fit_tracker_app/app/utilities/textstyles.dart';
import 'package:fit_tracker_app/app/utilities/theme_helper.dart';
import 'package:fit_tracker_app/data/model/login_model.dart';
import 'package:fit_tracker_app/data/repository/engine_auth_dev.dart';
import 'package:flutter/material.dart';
class AccountPage extends StatefulWidget {

  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final double circleRadius = 90.0;

  LoginModel loginData = new LoginModel();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _dobController = TextEditingController();

  _loadUser() async {
    loginData = await APIRequest.profile.getUser();
    setState(() {
      _emailController.text = "${loginData.email.toString()}";
      _nameController.text = "${loginData.name.toString()}";
      _genderController.text = "${loginData.gender.toString()}";
      _heightController.text = "${loginData.height.toString()}";
      _dobController.text = "${loginData.dob.toString()}";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: systemAccentColor,
        title: Text('Profile', style: p16.semiBold.white),
      ),
      body: Container(
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
                TextField(
                  style: p14.darkestGrey,
                  controller: _genderController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                    fillColor: systemWhiteColor,
                    hintText: 'Gender',
                    hintStyle: p14.grey,
                    labelText: 'Gender',
                    labelStyle: p14.accent,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
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
                _buildLogout(context)
              ],
            )
        ),
      )
    );
  }


  Widget _buildLogout(BuildContext context) {
    return InkWell(
      onTap: () async {
        AccountHelper.removeUserInfo();
        Routing.pushAndRemoveUntil(context, null, LoginPage(), (route) => false);
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
          'Logout',
          style: p14.semiBold.white,
        ),
      ),
    );
  }
}

