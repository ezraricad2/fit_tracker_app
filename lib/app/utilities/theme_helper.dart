import 'package:flutter/material.dart';

class CompanyColors {
  const CompanyColors._();

  const CompanyColors(); // this basically makes it so you can instantiate this class

  static const int _accentPrimaryValue = 0xff7646ff;
  static const Map<int, Color> accentColorList = const <int, Color>{
    0: const Color(0x997646ff),
    50: const Color(0xffE8E0FF),
    100: const Color(0xffD1C1FF),
    200: const Color(0xffBBA3FF),
    300: const Color(0xffA484FF),
    400: const Color(0xff8D65FF),
    500: const Color(_accentPrimaryValue),
    600: const Color(0xff683ED9),
    700: const Color(0xff5A36BD),
    800: const Color(0xff4D2EA1),
    900: const Color(0xff3F2685)
  };

  static const int _primaryPrimaryValue = 0xff54a6fc;
  static const Map<int, Color> primaryColorList = const <int, Color>{
    50: const Color(0xffE3F0FF),
    100: const Color(0xffC6E1FE),
    200: const Color(0xffAAD3FE),
    300: const Color(0xff8DC4FD),
    400: const Color(0xff71B5FD),
    500: const Color(_primaryPrimaryValue),
    600: const Color(0xff4A93DF),
    700: const Color(0xff4180C2),
    800: const Color(0xff376DA6),
    900: const Color(0xff2E5A89)
  };

  static const MaterialColor accent = MaterialColor(
    _accentPrimaryValue,
    accentColorList,
  );

  static const MaterialColor primary = MaterialColor(
    _primaryPrimaryValue,
    primaryColorList,
  );
}

//Colors
Color systemPrimaryColor = CompanyColors.primary[500];
Color systemPrimary50Color = CompanyColors.primary[50];
Color systemPrimary100Color = CompanyColors.primary[100];
Color systemPrimary200Color = CompanyColors.primary[200];
Color systemPrimary300Color = CompanyColors.primary[300];
Color systemPrimary400Color = CompanyColors.primary[400];
Color systemPrimary500Color = CompanyColors.primary[500];
Color systemPrimary600Color = CompanyColors.primary[600];
Color systemPrimary700Color = CompanyColors.primary[700];
Color systemPrimary800Color = CompanyColors.primary[800];
Color systemPrimary900Color = CompanyColors.primary[900];
Color systemAccentColor = CompanyColors.accent[500];
Color systemAccentTransparentColor = CompanyColors.accent[0];
Color systemAccent50Color = CompanyColors.accent[50];
Color systemAccent100Color = CompanyColors.accent[100];
Color systemAccent200Color = CompanyColors.accent[200];
Color systemAccent300Color = CompanyColors.accent[300];
Color systemAccent400Color = CompanyColors.accent[400];
Color systemAccent500Color = CompanyColors.accent[500];
Color systemAccent600Color = CompanyColors.accent[600];
Color systemAccent700Color = CompanyColors.accent[700];
Color systemAccent800Color = CompanyColors.accent[800];
Color systemAccent900Color = CompanyColors.accent[900];
Color systemAccentAlternativeColor = Color(0xff00555e);

const Color systemPrimaryColorConts = Color(0xff1f00b0);
const Color systemAccentColorConts = Color(0xff008299);
const Color systemRedColor = Color(0xffd81920);
const Color systemDarkerRedColor = Color(0xffc00811);
const Color systemLightSilverColor = Color(0xffF8F9F9);
const Color systemLightGreyColor = Color(0xffe5e5e5);
const Color systemGreyColor = Color(0xffb5b5b5);
const Color systemDarkerGreyColor = Color(0xff8f8f8f);
const Color systemDarkestGreyColor = Color(0xff666666);
const Color systemDeepGreyColor = Color(0xff555867);
const Color systemLightGreenColor = Color(0xffE7FEDF);
const Color systemGreenColor = Color(0xff24D366);
const Color systemDarkGreenColor = Color(0xff088124);
const Color systemMintGreenColor = Color.fromARGB(255, 1, 230, 117);
const Color systemBlueColor = Color(0xFF00B0FF);
const Color systemYellowColor = Color.fromARGB(255, 255, 197, 0);
const Color systemLightBlueColor = Color(0xffDFEEFE);
const Color systemWhiteColor = Color(0xffFFFFFF);
const Color systemTransparentColor = Color(0x00FFFFFF);
Color systemBlackGreyColor = Color.lerp(Colors.white, Colors.black, 0.67);
const Color systemGoldColor = Color(0xffffd700);
const Color statusOrder1Color = Color(0XFFFC8F00);
const Color statusOrder2Color = Color(0XFF7346F3);
const Color statusOrder3Color = Color(0XFF008EFC);
const Color statusOrder4Color = Color(0XFF00B07B);

const Color scaffoldColor = Color.fromARGB(255, 247, 248, 249);
const Color textFieldBorderColor = Color.fromARGB(255, 238, 238, 238);
const Color kHintColor = Color(0xFFAAAAAA);

const Color systemWhatsApColor = Color(0xff25D366);
const Color systemFacebookColor = Color(0xff0078FF);
const Color systemTelegramColor = Color(0xff0088cc);
const Color systemLineColor = Color(0xff00c300);

const Color systemNonActiveButtonColor = Color(0xffD3D4D3); //DAE9F5
const Color systemEnableColor = Color(0xff343DA4);
const Color systemDisableColor = Color(0xffF2F2F2);
const Color systemAppBackgroundColor = Color(0xffEFF0F4);

const Color systemScaffoldColor = Color.fromARGB(255, 247, 248, 249);

const Map<String, Color> promotionStatusColor = {
  "scheduled": Color(0xff7646ff),
  "ongoing": Color(0xff38cf4e),
  "expired": Color(0xffff4646),
};

const Map<String, Color> customerStatusColor = {
  "regular": Color(0xff38cf4e),
  "member": Color(0xff54a6fc),
  "reseller": Color(0xff7646ff),
  "dropship": Color(0xffe87605),
  "blocked": Color(0xffff4646)
};

const Map<String, Color> orderStatusColor = {
  "new": Color(0xff01E675),
  "new_receipt": Color(0xff17D26D),
  "paid": Color(0xff4A97E8),
  "printed": Color(0xff4671C7),
  "sent": Color(0xff434CA6),
  "finished": Color(0xff3F2685),
  "payment_denied": Color(0xffD81920),
  "refund": Color(0xffA81E29),
  "return": Color(0xff782333),
  "expired": Color(0xff47283C),
  "canceled": Color(0xff172D45),
};

//const Map<String, Color> orderStatusColor = {
//"new" : Color(0xff01E675)),
//"new_receipt" : Color(0xff17D26D)),
//"paid" : Color(0xff2CBD64)),
//"printed" : Color(0xff42A95C)),
//"sent" : Color(0xff579453)),
//"finished" : Color(0xff6D804B)),
//"payment_denied" : Color(0xff826B42)),
//"refund" : Color(0xff98573A)),
//"return" : Color(0xffAD4231)),
//"expired" : Color(0xffC32E29)),
//"canceled" : Color(0xffD81920)),
//};
