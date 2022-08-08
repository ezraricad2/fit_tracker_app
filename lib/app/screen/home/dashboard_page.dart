
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_tracker_app/app/utilities/account_helper.dart';
import 'package:fit_tracker_app/app/utilities/textstyles.dart';
import 'package:fit_tracker_app/app/utilities/theme_helper.dart';
import 'package:fit_tracker_app/data/repository/engine_auth_dev.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {

  final String emailParam;

  DashboardPage({this.emailParam});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  TextEditingController _weightController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime dateParam;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: systemAccentColor,
        title: Text('Activity', style: p16.white),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              _createOrUpdate();
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: APIRequest.activity.getActivityStream(widget.emailParam),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.separated(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data.docs[index];

                return _showActivity(documentSnapshot);
              },
              separatorBuilder: (context, index) => SizedBox(height: 12),
              itemCount: streamSnapshot.data.docs.length,
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }

  Widget _showActivity(DocumentSnapshot documentSnapshot) {

    DateTime dateTime = documentSnapshot['Date'].toDate();
    String date = DateFormat('dd-MM-yyyy').format(dateTime);

    return GestureDetector(
        onTap: () async {
          setState(() {
            dateParam = dateTime;
          });
          _createOrUpdate(documentSnapshot);
    },
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: systemWhiteColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: systemAccentColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text('${documentSnapshot['Weight'].toString()} Kg', style: p14.white),
            ),
          ),
          SizedBox(width: 8),
          Text('${date}', style: p14.grey.semiBold)
        ],
      ),
    ));
  }

  Future<void> _createOrUpdate([DocumentSnapshot documentSnapshot]) async {

    String action = 'create';

    if (documentSnapshot != null) {
      action = 'update';
      DateTime dateTime = documentSnapshot['Date'].toDate();
      String date = DateFormat('dd-MM-yyyy').format(dateTime);

      _weightController.text = documentSnapshot['Weight'].toString();
      _dateController.text = date;
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
                bottom: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  style: p14.black,
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                    fillColor: systemWhiteColor,
                    hintText: 'Weight (Kg)',
                    hintStyle: p14.grey,
                    labelText: 'Weight (Kg)',
                    labelStyle: p14.accent,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        theme: DatePickerTheme(
                            containerHeight: 210.0,
                            itemStyle: p14.black),
                            onConfirm: (date) {

                            String dateString = DateFormat('dd-MM-yyyy').format(date);
                            _dateController.text  = dateString;

                            setState(() {
                              dateParam = date;
                            });

                        }, currentTime: DateTime.now(), locale: LocaleType.id);
                  },
                  readOnly: true,
                  controller: _dateController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                    fillColor: systemWhiteColor,
                    hintText: 'Date',
                    hintStyle: p14.grey,
                    labelText: 'Date',
                    labelStyle: p14.accent,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: () async {

                    if (action == 'create') {
                      APIRequest.activity.addActivity(dateParam, _weightController.text);
                    } else if (action == 'update') {
                      APIRequest.activity.updateActivity(documentSnapshot.id, dateParam, _weightController.text);
                    }

                    _weightController.text = '';
                    _dateController.text = '';

                    Navigator.of(context).pop();
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
                      action == 'create' ? 'Save' : 'Update',
                      style: p14.semiBold.white,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

