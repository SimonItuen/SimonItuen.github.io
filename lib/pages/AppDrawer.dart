import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/widget/DrawerTile.dart';
import 'package:vaksine_web/extensions/app_extensions.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  List<String> drawerNames = [];
  List<IconData> drawerIcons = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    drawerIcons = [
      Icons.av_timer,
      Icons.supervisor_account_rounded,
      Icons.child_care_rounded,
      Icons.coronavirus_outlined,
      Icons.medication_rounded,
      Icons.shopping_cart_rounded,
      Icons.local_pharmacy_rounded,
      Icons.language_rounded,
      Icons.settings_rounded
    ];
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    drawerNames = [
      AppLocalizations.of(context)!.dashboard,
      AppLocalizations.of(context)!.users,
      AppLocalizations.of(context)!.childVaccineProgrammes,
      AppLocalizations.of(context)!.diseases,
      AppLocalizations.of(context)!.vaccines,
      AppLocalizations.of(context)!.orders,
      AppLocalizations.of(context)!.pharmacies,
      AppLocalizations.of(context)!.countries,
      AppLocalizations.of(context)!.settings,
    ];
    return ResponsiveLayout.isTablet(context)
        ? SizedBox(
            width: 48,
            child: Drawer(
              child: Container(
                color: Theme.of(context).primaryColor,
                child: Scrollbar(
                  interactive: true,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(left: 8, top: 16, right: 8),
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            height: 32,
                            width: 32,
                            child: Image.asset(
                              'assets/images/icon.png',
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 12)),
                        for (int i = 0; i < drawerNames.length; i++)
                          DrawerTile(
                              isSelected: appProvider.currentPage == i,
                              icon: drawerIcons[i],
                              title: drawerNames[i],
                              onPress: () {
                                appProvider.currentPage = i;
                              }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : Drawer(
            elevation: ResponsiveLayout.isMacbook(context) ? 0 : 16,
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Scrollbar(
                interactive: true,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(left: 8, top: 16, right: 8),
                  child: Column(
                    children: [
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 12),
                              height: 32,
                              width: 32,
                              child: Image.asset(
                                'assets/images/icon.png',
                              ),
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: 'Vaks',
                                style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              TextSpan(
                                text: 'i',
                                style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF05A7E7)),
                              ),
                              TextSpan(
                                text: 'ne',
                                style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFF5F5F5)),
                              )
                            ]))
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                      for (int i = 0; i < drawerNames.length; i++)
                        DrawerTile(
                            isSelected: appProvider.currentPage == i,
                            icon: drawerIcons[i],
                            title: drawerNames[i],
                            onPress: () {
                              appProvider.currentPage = i;
                            }),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
