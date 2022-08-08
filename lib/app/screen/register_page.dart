import 'package:fit_tracker_app/app/utilities/textstyles.dart';
import 'package:fit_tracker_app/app/utilities/theme_helper.dart';
import 'package:fit_tracker_app/data/model/login_model.dart';
import 'package:fit_tracker_app/data/model/response_model.dart';
import 'package:fit_tracker_app/data/repository/engine_auth_dev.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _NameController = TextEditingController();
  TextEditingController _EmailController = TextEditingController();
  TextEditingController _GenderController = TextEditingController();
  TextEditingController _HeightController = TextEditingController();
  TextEditingController _DobController = TextEditingController();

  bool _hasEdited = false;


  @override
  void initState() {
    _getMerchantInfo();
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
          title: Text('Atur Informasi Toko', style: p16.white),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  // divider: ColumnDivider(20),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      style: p14.darkestGrey,
                      controller: _NameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        fillColor: systemWhiteColor,
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                        hintText: 'Name',
                        hintStyle: p14.grey,
                        labelText: 'Name *',
                        labelStyle: p14.accent,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                    ),
                    TextField(
                      style: p14.darkestGrey,
                      controller: _EmailController,
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                        fillColor: systemLightGreyColor,
                        filled: true,
                        hintText: 'Email',
                        hintStyle: p14.grey,
                        labelText: 'Email *',
                        labelStyle: p14.accent,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                    ),
                    TextField(
                      style: p14.darkestGrey,
                      controller: _HeightController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                        fillColor: systemLightGreyColor,
                        filled: true,
                        hintText: 'Height',
                        hintStyle: p14.grey,
                        labelText: 'Height *',
                        labelStyle: p14.accent,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: InkWell(
                onTap: () async {
                  ResponseModel result = await APIRequest.account.createUser(
                      email: _EmailController.text, password: _HeightController.text);

                  if (result.success) {
                    // Go to Profile Page
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('sukses'),
                          content: Text(result.toString()),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            )
                          ],
                        ));
                  } else {
                    // Show Dialog
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Error'),
                          content: Text("${result.messages}"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            )
                          ],
                        ));
                  }
                },
                radius: 8,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  alignment: Alignment.center,
                  height: 44,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: systemLightGreyColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Daftar',
                    style: p14.semiBold.darkestGrey,
                  ),
                ),
              )
            )
          ],
      ),
    );
  }

  // method
  _getMerchantInfo() {
    // context.read<GetMerchantInfoCubit>().getMerchantInfo();
  }

  _onWillPop() {
    Navigator.pop(context, _hasEdited);
  }

}
