import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/vaccine_model.dart';
import 'package:vaksine_web/pages/AppDrawer.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';
import 'package:vaksine_web/pages/home/AlertCard.dart';
import 'package:vaksine_web/pages/home/ChartCard.dart';
import 'package:vaksine_web/pages/home/ConfigCard.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:web_scraper/web_scraper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool visibility = false;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor:
                    Colors.grey.withOpacity(0.4),
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_alert,
                          color:
                          Theme.of(context).primaryColor)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: 24),
              child: Text(
                'Vaccines:',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w900),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  /*for (VaccineModel vaccine in appProvider.getVaccineList)
                    VaccineTile(
                        isSelected: appProvider.getCurrentVaccine.name==vaccine.name,
                        title: vaccine.name,
                        valid: vaccine.valid,
                        incomplete: vaccine.incomplete,
                        invalid: vaccine.invalid,
                        userSize: '${(int.tryParse(vaccine.valid)??0)+(int.tryParse(vaccine.invalid)??0)+(int.tryParse(vaccine.incomplete)??0)}',
                        onPress: () {setState(() {
                          Provider.of<AppProvider>(context, listen: false).setCurrentVaccine(vaccine);
                        });})*/
                ],
              ),
            ),
            Padding(padding: EdgeInsets.all(8)),
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(flex: 7,child: ChartCard()),
                  Expanded(flex:5,child: Column(
                    children: [
                      ConfigCard(),
                      Expanded(child: AlertCard())
                    ],
                  ))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
