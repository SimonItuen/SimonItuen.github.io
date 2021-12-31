import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/pages/AppDrawer.dart';
import 'package:vaksine_web/pages/child_vaccine_programmes/ChildVaccineProgrammePage.dart';
import 'package:vaksine_web/pages/dashboard/DashboardPage.dart';
import 'package:vaksine_web/pages/diseases/DiseasesPage.dart';
import 'package:vaksine_web/pages/orders/OrdersPage.dart';
import 'package:vaksine_web/pages/pharmacies/PharmaciesPage.dart';
import 'package:vaksine_web/pages/settings/SettingsPage.dart';
import 'package:vaksine_web/pages/users/UsersPage.dart';
import 'package:vaksine_web/pages/vaccines/VaccinesPage.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';
import 'package:vaksine_web/pages/countries/CountriesPage.dart';
import 'package:vaksine_web/pages/home/HomePage.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ParentPage extends StatefulWidget {
  const ParentPage({Key? key}) : super(key: key);

  @override
  _ParentPageState createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  List<Widget> children = [
    DashboardPage(),
    UsersPage(),
    ChildVaccineProgrammePage(),
    DiseasesPage(),
    VaccinesPage(),
    OrdersPage(),
    PharmaciesPage(),
    CountriesPage(),
    SettingsPage()
  ];
  List<String> drawerNames = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*Future.wait([
      HttpService.getVaccines(context),
      HttpService.getCountries(context),
      HttpService.getLanguages(context),
    ]);*/
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    AppLocalizations? locale = AppLocalizations.of(context);
    drawerNames = [
      locale!.dashboard,
      locale.users,
      locale.childVaccineProgrammes,
      locale.diseases,
      locale.vaccines,
      locale.orders,
      locale.pharmacies,
      locale.countries,
      locale.settings,
    ];
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ResponsiveLayout(
            phone: Scaffold(
              drawer: AppDrawer(),
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: Text(drawerNames[appProvider.currentPage],
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
                actions: [
                  InkWell(
                    child: Container(
                      height: 32,
                      width: 32,
                      margin: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, right: 16),
                      decoration: BoxDecoration(
                          color: Color(0xFF1463B8), shape: BoxShape.circle),
                      child: Center(
                          child: Text(
                        appProvider.currentAdmin.givenName
                            .toString()
                            .substring(0, 1),
                        style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12),
                      )),
                    ),
                    onTap: () {},
                  )
                ],
              ),
              body: Container(
                child: children[appProvider.currentPage],
              ),
            ),
            tablet: Row(
              children: [
                AppDrawer(),
                Expanded(
                    child: Column(
                  children: [
                    AppBar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      foregroundColor:
                          Theme.of(context).textTheme.bodyText1!.color,
                      elevation: 0,
                      centerTitle: true,
                      title: Text(drawerNames[appProvider.currentPage],
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16, color: Colors.blueGrey)),
                      actions: [
                        InkWell(
                          child: Container(
                            height: 32,
                            width: 32,
                            margin: const EdgeInsets.only(
                                top: 8.0, bottom: 8.0, right: 16),
                            decoration: BoxDecoration(
                                color: Color(0xFF1463B8),
                                shape: BoxShape.circle),
                            child: Center(
                                child: Text(
                              appProvider.currentAdmin.givenName
                                  .toString()
                                  .substring(0, 1),
                              style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 12),
                            )),
                          ),
                          onTap: () {},
                        )
                      ],
                    ),
                    Expanded(child: Container(child: children[appProvider.currentPage])),
                  ],
                ))
              ],
            ),
            desktop: Container(
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  AppDrawer(),
                  Expanded(
                    child: Column(
                      children: [
                        AppBar(
                          title: Text(drawerNames[appProvider.currentPage],
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 20)),
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          foregroundColor:
                              Theme.of(context).textTheme.bodyText1!.color,
                          elevation: 0,
                          actions: [
                            Center(
                              child: Text(
                                  '${locale.hi} ${appProvider.currentAdmin.givenName.toString()}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16)),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6)),
                            InkWell(
                              child: Container(
                                height: 32,
                                width: 32,
                                margin: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0, right: 16),
                                decoration: BoxDecoration(
                                    color: Color(0xFF1463B8),
                                    shape: BoxShape.circle),
                                child: Center(
                                    child: Text(
                                  appProvider.currentAdmin.givenName
                                      .toString()
                                      .substring(0, 1),
                                  style: TextStyle(
                                      fontFamily: 'Comfortaa',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 12),
                                )),
                              ),
                              onTap: () {},
                            )
                          ],
                        ),
                        Expanded(child: children[appProvider.currentPage]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
