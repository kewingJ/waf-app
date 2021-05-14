import 'dart:convert';
import 'dart:async';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waf_app/screen/Bottom_Nav_Bar/bottom_nav_bar.dart';
import 'package:waf_app/screen/setting/themes.dart';
import 'package:flutter/material.dart';
import 'package:waf_app/component/style.dart';
import 'package:http/http.dart' as http;

String linkServerMaster = "";
String emailMaster = "";
String passwordMaster = "";
bool checkMaster = true;

class login extends StatefulWidget {
  ThemeBloc themeBloc;
  login({this.themeBloc});
  @override
  _loginState createState() => _loginState(themeBloc);
}

class _loginState extends State<login> {
  ThemeBloc _themeBloc;
  _loginState(this._themeBloc);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController linkServerController = TextEditingController();
  bool checkboxController = true;

  
  Future dataLogin() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      checkMaster = await prefs.getBool("checkMaster");
      checkboxController = checkMaster == null ? true : checkMaster;

      //print(checkboxController);
      linkServerMaster = await prefs.getString("linkServerMaster");
      linkServerController.text = linkServerMaster;

      if(checkboxController) {
        emailMaster = await prefs.getString("emailMaster");
        emailController.text = emailMaster;
        
        passwordMaster = await prefs.getString("passwordMaster");
        passwordController.text = passwordMaster;
      }
  }
  
  void initState() {
    super.initState();
    dataLogin();
  }

  // For CircularProgressIndicator.
  bool _isInAsyncCall = false;

  String _email, _pass, _linkServer;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future userLogin() async {
    try {
      // Getting value from Controller
      String email = emailController.text;
      String password = passwordController.text;
      String linkServer = linkServerController.text;
      bool checkbox = checkboxController;

      //link
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("linkServerMaster", linkServer);
      //email
      await prefs.setString("emailMaster", email);
      //password
      await prefs.setString("passwordMaster", password);
      //check
      await prefs.setBool("checkMaster", checkbox);

      //print(checkbox);

      // Showing CircularProgressIndicator.
      setState(() {
        _isInAsyncCall = true;
      });
      
      // SERVER LOGIN API URL
      var url = linkServerController.text+'/api/v1/login.php';

      // Store all data with Param Name.
      var data = {'email': email, 'password': password};

      // Starting Web API Call.
      final response = await http.post(url, body: json.encode(data));

      // Getting Server response into variable.
      var message = jsonDecode(response.body.toString());

      // If the Response Message is Matched.
      if (message != 'Invalid Email or Password Please Try Again') {
        var parsedJson = json.decode(response.body);
        String id_usuario = parsedJson["id_usuario"];
        String tipo_usuario = parsedJson["tipo_usuario"];

        await prefs.setString("id_usuario", id_usuario);
        await prefs.setString("tipo_usuario", tipo_usuario);

        new Future.delayed(new Duration(seconds: 2), () {
          setState(() {
            _isInAsyncCall = false;
          });
        });

        // Navigate to Profile Screen & Sending Email to Next Screen.
        Navigator.of(context).pushReplacement(PageRouteBuilder(
            pageBuilder: (_, __, ___) => bottomNavBar(themeBloc: _themeBloc)));
      } else {
        // If Email or Password did not Matched.
        // Hiding the CircularProgressIndicator.
        new Future.delayed(new Duration(seconds: 2), () {
          setState(() {
            _isInAsyncCall = false;
          });
        });

        // Showing Alert Dialog with Response JSON Message.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(message),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _isInAsyncCall = false;
                    });
                  },
                ),
              ],
            );
          },
        );
      }
    } on Exception catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Error de conexión, verifique que los datos brindados esten correctos!"),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _isInAsyncCall = false;
                    });
                  },
                ),
              ],
            );
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // display modal progress HUD (heads-up display, or indicator)
      // when in async call
      body: ModalProgressHUD(
        child: buildLoginForm(context),
        inAsyncCall: _isInAsyncCall,
        // demo of some additional parameters
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildLoginForm(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,

          /// Set Background image in splash screen layout (Click to open code)
          decoration: BoxDecoration(color: colorStyle.background),
          child: Stack(
            children: <Widget>[
              ///
              /// Set image in top
              ///
              Container(
                height: 219.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/image/loginHeader.png"),
                        fit: BoxFit.cover)),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: mediaQuery.padding.top + 220.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("assets/image/logo.png", height: 35.0),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 17.0, top: 7.0),
                              child: Text(
                                "WAF",
                                style: TextStyle(
                                    fontFamily: "Sans",
                                    color: Colors.white,
                                    fontSize: 27.0,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 3.5),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 40.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 53.5,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(
                                  color: colorStyle.primaryColor,
                                  width: 0.15,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12.0, top: 10.0),
                                child: Theme(
                                  data:
                                      ThemeData(hintColor: Colors.transparent),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: TextFormField(
                                      validator: (input) {
                                        if (input.isEmpty) {
                                          return 'Campo vacio';
                                        }
                                      },
                                      onSaved: (input) => _linkServer = input,
                                      style: new TextStyle(color: Colors.white),
                                      textAlign: TextAlign.start,
                                      controller: linkServerController,
                                      keyboardType: TextInputType.url,
                                      autocorrect: false,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          icon: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Icon(
                                              Icons.cloud,
                                              color: colorStyle.primaryColor,
                                              size: 20,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(0.0),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          labelText: 'Link server',
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          labelStyle: TextStyle(
                                            color: Colors.white70,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 40.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 53.5,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(
                                  color: colorStyle.primaryColor,
                                  width: 0.15,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12.0, top: 10.0),
                                child: Theme(
                                  data:
                                      ThemeData(hintColor: Colors.transparent),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: TextFormField(
                                      validator: (input) {
                                        if (input.isEmpty) {
                                          return 'Campo vacio';
                                        }
                                      },
                                      onSaved: (input) => _email = input,
                                      style: new TextStyle(color: Colors.white),
                                      textAlign: TextAlign.start,
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      autocorrect: false,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          icon: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Icon(
                                              Icons.email,
                                              color: colorStyle.primaryColor,
                                              size: 20,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(0.0),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          labelText: 'Email',
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          labelStyle: TextStyle(
                                            color: Colors.white70,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 53.5,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                //              color: Color(0xFF282E41),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(
                                  color: colorStyle.primaryColor,
                                  width: 0.15,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12.0, top: 10.0),
                                child: Theme(
                                  data:
                                      ThemeData(hintColor: Colors.transparent),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: TextFormField(
                                      validator: (input) {
                                        if (input.isEmpty) {
                                          return 'Campo vacio';
                                        }
                                      },
                                      onSaved: (input) => _pass = input,
                                      style: new TextStyle(color: Colors.white),
                                      textAlign: TextAlign.start,
                                      controller: passwordController,
                                      keyboardType: TextInputType.emailAddress,
                                      autocorrect: false,
                                      obscureText: true,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          icon: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Icon(
                                              Icons.vpn_key,
                                              size: 20,
                                              color: colorStyle.primaryColor,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(0.0),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          labelText: 'Contraseña',
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          labelStyle: TextStyle(
                                            color: Colors.white70,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
                        child: CheckboxListTile(
                          title: Text("Recordar mis datos"),
                          controlAffinity: ListTileControlAffinity.platform,
                          value: checkboxController,
                          onChanged: (bool value){
                            setState(() {
                              checkboxController = value;
                            });
                          },
                          activeColor: Colors.white,
                          checkColor: Colors.black,
                        ),
                      ),

                      ///
                      /// forgot password
                      ///
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 23.0, top: 9.0),
                      //   child: InkWell(
                      //       onTap: () {
                      //         Navigator.of(context).pushReplacement(
                      //             PageRouteBuilder(
                      //                 pageBuilder: (_, __, ___) =>
                      //                     forgetPassword(
                      //                       themeBloc: _themeBloc,
                      //                     )));
                      //       },
                      //       child: Align(
                      //           alignment: Alignment.centerRight,
                      //           child: Text(
                      //             "¿Olvidaste la contraseña?",
                      //             style: TextStyle(
                      //               color: Colors.white70,
                      //               fontSize: 12.0,
                      //             ),
                      //           ))),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 40.0),
                        child: GestureDetector(
                          onTap: () {
                            final formState = _formKey.currentState;
                            if (formState.validate()) {
                              formState.save();
                              userLogin();
                              // Navigator.of(context).pushReplacement(
                              //     PageRouteBuilder(
                              //         pageBuilder: (_, __, ___) =>
                              //             bottomNavBar(themeBloc: _themeBloc)));
                            }
                          },
                          child: Container(
                            height: 50.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0.0)),
                              color: colorStyle.primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                "Entrar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.0,
                                    letterSpacing: 1.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
//                  Padding(
//                    padding: const EdgeInsets.only(left:20.0,right: 20.0,bottom: 15.0),
//                    child: Container(width: double.infinity,height: 0.15,color: colorStyle.primaryColor,),
//                  ),
//                  Text("Register",style: TextStyle(color: colorStyle.primaryColor,fontSize: 17.0,fontWeight: FontWeight.w800),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFeild({
    String hint,
    TextEditingController controller,
    TextInputType keyboardType,
    bool obscure,
    String icon,
    TextAlign textAlign,
    Widget widgetIcon,
  }) {
    return Column(
      children: <Widget>[
        Container(
          height: 53.5,
          decoration: BoxDecoration(
            color: Colors.black26,
//              color: Color(0xFF282E41),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(
              color: colorStyle.primaryColor,
              width: 0.15,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  style: new TextStyle(color: Colors.white),
                  textAlign: textAlign,
                  obscureText: obscure,
                  controller: controller,
                  keyboardType: keyboardType,
                  autocorrect: false,
                  autofocus: false,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: widgetIcon,
                      ),
                      contentPadding: EdgeInsets.all(0.0),
                      filled: true,
                      fillColor: Colors.transparent,
                      labelText: hint,
                      hintStyle: TextStyle(color: Colors.white),
                      labelStyle: TextStyle(
                        color: Colors.white70,
                      )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
