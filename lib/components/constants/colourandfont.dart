import 'package:flutter/material.dart';

import '../customwidget.dart';

const kHeadTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

const kHeadSubtitleTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.black87,
);

TextStyle h1orange() {
  return TextStyle(
      color: orangeColor, fontWeight: FontWeight.w500, fontSize: 16);
}

//main color
Color orangeColor = const Color.fromARGB(255, 213, 159, 15);
Color whitecolor = Colors.white;

//Complementary Colour 1
Color darkColor = const Color.fromARGB(255, 37, 39, 51);
// Complementary Colour 2
Color lessorangeColor = const Color.fromARGB(255, 243, 221, 162);

//header1
TextStyle header1(orangeColor) {
  return TextStyle(
      fontWeight: FontWeight.w600, fontSize: 32, color: orangeColor);
}

//I usally keep all the static values in a place
//in case you like it do tht

class Colorz {
  static const Color primaryColor = Color(0xff5b60ec);
  static const Color timerBlue = Color(0xff1c77dd);

  static const Color backgroundBlue = Color(0xff1b81f1);

  static const Color accountPurple = primaryColor;

  static const Color currenciesPageBackground = Color(0xff0f1e4e);
  static const Color currenciesNameColor = Color(0xff7080b3);
  static const Color currencyPositiveGreen = Color(0xff0eff7e);
  static const Color currencyIndicatorColor = Color(0xff6170f3);

  static const Color sendMoneyBlue = Color(0xff4285f4);

  static const Color googlResultsGrey = Color(0xffeff4f2);

  // static const Color compexDrawerScaffoldColor = Color(0xfe3e9f7);
  static const Color compexDrawerCanvasColor = Color(0xffe3e9f7);
  static const Color complexDrawerBlack = Color(0xff11111d);
  static const Color complexDrawerBlueGrey = Color(0xff1d1b31);

  //interlaced dashboard
  static const Color interlacedBackground = Color(0xfff7f8fa);
  static const Color interlacedAvatarBorderBlue = Color(0xff2554fc);
  static const Color interlacedChatPurple = Color(0xff8532fb);

  //richCalculator
  static const Color richCalculatorCanvas = Color(0xff222433);
  static const Color richCalculatorOutterButtonColor = Color(0xff333549);
  static const Color richCalculatorInnerButtonColor = Color(0xff2c2e41);
  static const Color richCalculatorYellowButtonColor = Color(0xffffba001);

  //buttonExample
  static const Color buttonExampleCanvas = Color(0xfff3f6ff);
  static const Color buttonSampleColor = Color(0xff7c2ae8);

  ///Expandile
  static const Color iphone12Purple = Color(0xffB8AFE6);

  ///DoubleCard
  static const Color doubleCardBlue = Color(0xff045bd8);
}

class TeslaColorz {
  ///Primary Colors
  static const List<Color> backdropColors = [
    Colors.black,
    Color(0xFF003073),
    Color(0xFF003073),
    Color(0xFF1E281E),
    Color(0xFF1E281E),
    Colors.black26,
  ];

  ///Control centre colors
  static const Color iconBlack = Color(0xff101118);
  static const Color disabledGrey = Color(0xff1e1f28);

  static const Color headLightRed = Color(0xfffb1e4d);
  static const Color microphoneRed = Color(0xffff0000);
  static const Color chargingBlue = Color(0xff038efe);

  ///Sorted by darkest color to the lightest color
  static const List<Color> chargingWaveColors = [
    Color(0xff0845d5),
    Color(0xff0558f7),
    Color(0xff0977d4),
    Color(0xff0491fe),
  ];

  static const List<Color> lockerColors = <Color>[
    Color(0xff6b67fa),
    Color(0xff4844f9),
  ];
}

class Txt extends StatefulWidget {
  final FontStyle? style;
  final FontWeight? fontWeight;
  final int? maxLines;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final bool useoverflow;
  final bool upperCaseFirst;
  final bool quoted;
  final bool useFiler;
  final bool underline;
  final bool fullUpperCase;
  final dynamic text;
  final String? family;
  final bool toRupees;
  final bool toTimeAgo;
  final String? prefix;
  final bool strikeThrough;

  const Txt({
    Key? key,
    this.style,
    this.fontWeight,
    this.maxLines,
    this.fontSize,
    this.color,
    this.textAlign,
    this.useoverflow = false,
    this.upperCaseFirst = false,
    this.quoted = false,
    this.useFiler = false,
    this.underline = false,
    this.fullUpperCase = false,
    required this.text,
    this.family,
    this.prefix,
    this.toRupees = false,
    this.toTimeAgo = false,
    this.strikeThrough = false,
  }) : super(key: key);

  @override
  _TxtState createState() => _TxtState();
}

class _TxtState extends State<Txt> {
  String finalText = "";

  /// finalText = strings.english;

  @override
  Widget build(BuildContext context) {
//Any
    finalText = widget.text.toString();
//String
    if (widget.text is String) finalText = widget.text ?? "Error";
//Numbers

    if (widget.upperCaseFirst && finalText.length > 1) {
      finalText =
          "${finalText[0].toUpperCase()}${finalText.substring(1, finalText.length).toLowerCase()}";
    }
    if (widget.fullUpperCase) finalText = finalText.toUpperCase();
    if (widget.useFiler) {
      finalText = finalText
          .replaceAll("*", "")
          .replaceAll("_", "")
          .replaceAll("-", "")
          .replaceAll("#", "")
          .replaceAll("\n", "")
          .replaceAll("!", "")
          .replaceAll('[', '')
          .replaceAll(']', '');
    }
    if (widget.quoted) finalText = "❝$finalText❞";

    return Text((finalText).toString(),
        overflow: widget.useoverflow ? TextOverflow.ellipsis : null,
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        textScaleFactor: 1,
        style: TextStyle(
          decoration: widget.underline
              ? TextDecoration.underline
              : (widget.strikeThrough ? TextDecoration.lineThrough : null),
          color: widget.color,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          fontStyle: widget.style,
          fontFamily: widget.family,
        ));
  }
}

class CrossFade extends StatelessWidget {
  final Widget child;
  final Widget? hiddenChild;
  final bool show;
  final EdgeInsets? padding;
  final bool useCenter;

  const CrossFade({
    Key? key,
    required this.child,
    this.hiddenChild,
    this.show = false,
    this.padding,
    this.useCenter = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        child: AnimatedCrossFade(
          firstChild: hiddenChild ?? Container(),
          secondChild: childX(),
          duration: Duration(milliseconds: 500),
          crossFadeState:
              show ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ));
  }

  Widget childX() {
    if (useCenter) return Center(child: child);
    return child;
  }
}
