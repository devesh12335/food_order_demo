import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#F4770F");
  static Color darkGrey = HexColor.fromHex("#393D3f");
  static Color grey = HexColor.fromHex("#737477");

  static Color primaryOpacity70 = HexColor.fromHex("#F9A825");
  static Color promo1BgColor = HexColor.fromHex("#4D4472").withOpacity(1);

  static Color selectedPackageBorderColor =
      HexColor.fromHex("#E8E2FF").withOpacity(1);

  static Color loginPrivacyColor1 = HexColor.fromHex("#6E777C");
  static Color loginPrivacyColor2 = HexColor.fromHex("#3D4951");

  //text color
  static Color textColor = HexColor.fromHex("#3D4951");
  static Color myProfileTextColor = HexColor.fromHex("#A5D4ED");
  static Color myProfileContainerColor = HexColor.fromHex("E8F4F1");
  static Color logOutButtonBackgroundColor = HexColor.fromHex("#FFF6F6");
  static Color logoutButtonTextColor = HexColor.fromHex("#F85353");

  static Color otpTextColor = HexColor.fromHex("#9EA4A8");
  static Color homeTextColor1 = HexColor.fromHex("#6E777C");
  static Color homeTextColor2 = HexColor.fromHex("#0D1C25");
  static Color homeTextColor3 = HexColor.fromHex("#1BB71B");
  static Color dialogBoxTextColor = HexColor.fromHex("#3D4951");
  static Color customCardWidgetTextColor = HexColor.fromHex("#0D1C25");
  static Color myProfileblueCardTextColor = HexColor.fromHex("#A5D4ED");
  static Color editLanguageTextColor = HexColor.fromHex("#3D4951");
  static Color editLanguageBorderColor = HexColor.fromHex("#E7E8E9");
  static Color senderMessageTanColorinChat = HexColor.fromHex("#1E93D1");
  static Color receiverMessageTabColorinChat = HexColor.fromHex("#78BEE3");
  static Color dateTabColorTextinChat = HexColor.fromHex("#9EA4A8");

  static Color containerColor = HexColor.fromHex("#E8F4FA");
  static Color containerBorder = HexColor.fromHex("#D2E9F6");

  //New Colors
  static Color cancelButtonTextColor = HexColor.fromHex("#CFD2D3");
  static Color black = HexColor.fromHex('#000000');
  static Color darkPrimary = HexColor.fromHex("#d17d11");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color tabColor = HexColor.fromHex("#1E93D1");
  static Color tabBarColor = HexColor.fromHex("#D2E9F6");
  static Color elevatedButtonColor = HexColor.fromHex("#1E93D1");
  static Color logOutButtonColor = HexColor.fromHex("#F85353");
  static Color textFieldColor = HexColor.fromHex("#E8F4FA");
  static Color textFieldBorderColor = HexColor.fromHex("#1E93D1");
  static Color tabBarBorder = HexColor.fromHex('#D2E9F6');
  static Color quizOptionsBackgroundColor = HexColor.fromHex('#E8F4FA');
  static Color transparent = HexColor.fromHex('#F5F5F8');
  static Color starColor = HexColor.fromHex('#FFC700');
  static Color errorColor = HexColor.fromHex('#FE3737');
  static Color shadowColor = HexColor.fromHex('#000000');
  static Color background = HexColor.fromHex('#F5F5F8');
  static Color success = HexColor.fromHex('#00ff00');
  static Color svgIconColor = HexColor.fromHex("#F4770F");
  static Color pageBgColor = HexColor.fromHex("#fafafa");
  static Color inactiveToggleButtonColor = HexColor.fromHex("#969AA4");
  static Color keyboardArrowDown = HexColor.fromHex("#FF5963");
  static Color deliveredTextColor = HexColor.fromHex("#34A853");
  static Color deliveredBgColor = HexColor.fromHex("#eafff0");
  static Color bgColor = HexColor.fromHex("#f2f2f2");
  static Color unselectedLabelColor = HexColor.fromHex("#9A9A9D");

  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xff0ed0cf), Color(0xff01d0b3)],
    stops: [0.25, 0.75],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString =
          "FF$hexColorString"; //Appending characters for opacity of 100% at start of HexCode
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
