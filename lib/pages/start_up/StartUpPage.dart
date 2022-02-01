import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/admin_model.dart';
import 'package:vaksine_web/pages/login/LoginPage.dart';
import 'package:vaksine_web/pages/parent/ParentPage.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/util/session_manager_util.dart';
import 'dart:convert' as convert;

class StartUpPage extends StatefulWidget {
  StartUpPage({Key? key}) : super(key: key);

  @override
  _StartUpPageState createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      _checkToken();
    });

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  AdminModel currentAdmin = AdminModel();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        body: Container(
          child: Center(child: CircularProgressIndicator()),
        ));
  }

  _checkToken() async {
    await SessionManagerUtil.getInstance();
    if (SessionManagerUtil.getString('currentAdmin') == null ||
        SessionManagerUtil.getString('currentAdmin').trim().isEmpty) {
      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
    } else {
      currentAdmin = AdminModel.fromJson(
          convert.jsonDecode(SessionManagerUtil.getString('currentAdmin')));
      if (currentAdmin.accessToken == null ||
          currentAdmin.accessToken.trim().isEmpty) {
        Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
      } else {
        receiverProcessesJwt(currentAdmin.accessToken);
      }
    }
  }

  void receiverProcessesJwt(String accessToken) {
    if (JwtDecoder.isExpired(accessToken)) {
      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
    } else {
      Provider.of<AppProvider>(context, listen: false).currentAdmin =
          currentAdmin;
      Navigator.of(context).pushReplacementNamed(ParentPage.routeName);
    }
  }
}
