import 'package:waf_app/Library/intro_views_flutter-2.4.0/lib/Models/page_view_model.dart';
import 'package:waf_app/Library/intro_views_flutter-2.4.0/lib/intro_views_flutter.dart';
import 'package:waf_app/screen/intro/login.dart';
import 'package:waf_app/screen/setting/themes.dart';
import 'package:flutter/material.dart';
import 'package:waf_app/component/style.dart';

class onBoarding extends StatefulWidget {
  ThemeBloc themeBloc;
  onBoarding({this.themeBloc});
  @override
  _onBoardingState createState() => _onBoardingState(themeBloc);
}

///
/// Page View Model for on boarding
///
final pages = [
  new PageViewModel(
      pageColor: colorStyle.background,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        'Waf App',
        style: txtStyle.headerStyle,
      ),
      body: Container(
        height: 250.0,
        child: Text(
          'Ver estadísticas en cada\nhosting que se protege',
          textAlign: TextAlign.center,
          style: txtStyle.descriptionStyle,
        ),
      ),
      mainImage: Image.asset(
        'assets/ilustration/boarding1.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
  new PageViewModel(
      pageColor: colorStyle.background,
      iconColor: Colors.black,
      bubbleBackgroundColor: Colors.black,
      title: Text(
        'Waf App',
        style: txtStyle.headerStyle,
      ),
      body: Container(
        height: 250.0,
        child: Text(
          'Evaluar tipos de ataques y paises donde\nse realizan mas ataques',
          textAlign: TextAlign.center,
          style: txtStyle.descriptionStyle,
        ),
      ),
      mainImage: Image.asset(
        'assets/ilustration/boarding3.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      )),
];

class _onBoardingState extends State<onBoarding> {
  ThemeBloc _themeBloc;
  _onBoardingState(this._themeBloc);
  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      pages,
      pageButtonsColor: Colors.black45,
      skipText: Text(
        "OMITIR",
        style: txtStyle.descriptionStyle.copyWith(
            color: Color(0xFF45C2DA),
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      doneText: Text(
        "CONTINUAR",
        style: txtStyle.descriptionStyle.copyWith(
            color: Color(0xFF45C2DA),
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0),
      ),
      onTapDoneButton: () {
        Navigator.of(context).pushReplacement(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new login(themeBloc: _themeBloc)));
      },
    );
  }
}
