import 'package:fit_tracker_app/app/utilities/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Commons {
  // snackbar error
  void snackbarError(
    BuildContext context,
    String message,
  ) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: Duration(milliseconds: 2500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // snackbar info
  void snackbarInfo(
    BuildContext context,
    String message,
  ) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: systemAccentColor,
      duration: Duration(milliseconds: 2500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // snackbar info notification
  void snackbarNotification(BuildContext context, String message, int duration) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: systemAccentColor,
      duration: Duration(milliseconds: duration == null ? 1000 : duration),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // dialog custom child
  void dialogCustomChild(
    BuildContext context,
    Widget child,
  ) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        content: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  child,
                ],
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                child: Icon(Icons.close),
                onTap: () => Navigator.pop(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  void dialogNotificationWillPopScope(Function onWillPop, BuildContext context, Widget child) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () => onWillPop(),
        child: new AlertDialog(
          contentPadding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: child,
        ),
      ),
    );
  }
}
