import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/pages/dashboard/AboutUsUpdatePage.dart';
import 'package:vaksine_web/pages/dashboard/ConsultationFeeUpdatePage.dart';
import 'package:vaksine_web/pages/dashboard/ContactUsUpdatePage.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';
import 'package:vaksine_web/widget/DashboardTile.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isLoading = true;
  List<String> drawerNames = [];
  List<IconData> drawerIcons = [];
  bool multiPane = false;
  bool priceTileSelected = false;
  bool aboutUsTileSelected = false;
  bool contactUsTileSelected = false;
  ScrollController pageScrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    drawerIcons = [
      Icons.analytics_outlined,
      Icons.supervisor_account_outlined,
      Icons.child_care_outlined,
      Icons.coronavirus_outlined,
      Icons.medication_outlined,
      Icons.shopping_cart_outlined,
      Icons.language_outlined,
      Icons.price_change_outlined,
      Icons.info_outline_rounded,
      Icons.phone_outlined,
    ];
    Future.delayed(Duration.zero, () async {
      isLoading = await HttpService.getDashboard(context);
      setState(() {});
    });
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
      locale.countries,
      locale.consultationFee,
      locale.aboutUs,
      locale.contactUs,
    ];
    return isLoading
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            body: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ResponsiveLayout(
                phone: (priceTileSelected ||
                    aboutUsTileSelected ||
                    contactUsTileSelected)?sidePanel(locale):SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                  child: Container(
                    child:  Scrollbar(
                      interactive:true,
                      controller: pageScrollController,
                      child: SingleChildScrollView(
                        controller: pageScrollController,
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          runAlignment: WrapAlignment.start,
                          children: [
                            DashboardTile(
                              title: '${drawerNames[1]}',
                              icon: drawerIcons[1],
                              description:
                                  '${appProvider.currentDashboard.userCount}',
                              onPress: () {
                                Provider.of<AppProvider>(context, listen: false)
                                    .currentPage = 1;
                              },
                            ),
                            DashboardTile(
                              title: '${drawerNames[2]}',
                              icon: drawerIcons[2],
                              description:
                                  '${appProvider.currentDashboard.childProgramCount}',
                              onPress: () {
                                Provider.of<AppProvider>(context, listen: false)
                                    .currentPage = 2;
                              },
                            ),
                            DashboardTile(
                              title: '${drawerNames[3]}',
                              icon: drawerIcons[3],
                              description:
                                  '${appProvider.currentDashboard.diseaseCount}',
                              onPress: () {
                                Provider.of<AppProvider>(context, listen: false)
                                    .currentPage = 3;
                              },
                            ),
                            DashboardTile(
                              title: '${drawerNames[4]}',
                              icon: drawerIcons[4],
                              description:
                                  '${appProvider.currentDashboard.vaccineCount}',
                              onPress: () {
                                Provider.of<AppProvider>(context, listen: false)
                                    .currentPage = 4;
                              },
                            ),
                            DashboardTile(
                              title: '${drawerNames[5]}',
                              icon: drawerIcons[5],
                              description:
                                  '${appProvider.currentDashboard.orderCount}',
                              onPress: () {
                                Provider.of<AppProvider>(context, listen: false)
                                    .currentPage = 5;
                              },
                            ),
                            DashboardTile(
                              title: '${drawerNames[6]}',
                              icon: drawerIcons[6],
                              description:
                                  '${appProvider.currentDashboard.countryCount}',
                              onPress: () {
                                Provider.of<AppProvider>(context, listen: false)
                                    .currentPage = 6;
                              },
                            ),
                            DashboardTile(
                              isSelected: priceTileSelected,
                              title: '${drawerNames[7]}',
                              icon: drawerIcons[7],
                              description:
                                  '${appProvider.currentDashboard.consultationFee.amount} kr',
                              onPress: () {
                                setState(() {
                                  priceTileSelected = !priceTileSelected;
                                  aboutUsTileSelected = false;
                                  contactUsTileSelected = false;
                                });
                              },
                            ),
                            DashboardTile(
                              isSelected: aboutUsTileSelected,
                              title: '${drawerNames[8]}',
                              icon: drawerIcons[8],
                              description: '',
                              onPress: () {
                                setState(() {
                                  priceTileSelected = false;
                                  aboutUsTileSelected = !aboutUsTileSelected;
                                  contactUsTileSelected = false;
                                });
                              },
                            ),
                            DashboardTile(
                              isSelected: contactUsTileSelected,
                              title: '${drawerNames[9]}',
                              icon: drawerIcons[9],
                              description: '',
                              onPress: () {
                                setState(() {
                                  priceTileSelected = false;
                                  aboutUsTileSelected = false;
                                  contactUsTileSelected = !contactUsTileSelected;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                tablet: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child:  Scrollbar(
                          interactive:true,
                          controller: pageScrollController,
                          child: SingleChildScrollView(
                            controller: pageScrollController,
                            child: Center(
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                runAlignment: WrapAlignment.start,
                                children: [
                                  DashboardTile(
                                    title: '${drawerNames[1]}',
                                    icon: drawerIcons[1],
                                    description:
                                        '${appProvider.currentDashboard.userCount}',
                                    onPress: () {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .currentPage = 1;
                                    },
                                  ),
                                  DashboardTile(
                                    title: '${drawerNames[2]}',
                                    icon: drawerIcons[2],
                                    description:
                                        '${appProvider.currentDashboard.childProgramCount}',
                                    onPress: () {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .currentPage = 2;
                                    },
                                  ),
                                  DashboardTile(
                                    title: '${drawerNames[3]}',
                                    icon: drawerIcons[3],
                                    description:
                                        '${appProvider.currentDashboard.diseaseCount}',
                                    onPress: () {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .currentPage = 3;
                                    },
                                  ),
                                  DashboardTile(
                                    title: '${drawerNames[4]}',
                                    icon: drawerIcons[4],
                                    description:
                                        '${appProvider.currentDashboard.vaccineCount}',
                                    onPress: () {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .currentPage = 4;
                                    },
                                  ),
                                  DashboardTile(
                                    title: '${drawerNames[5]}',
                                    icon: drawerIcons[5],
                                    description:
                                        '${appProvider.currentDashboard.orderCount}',
                                    onPress: () {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .currentPage = 5;
                                    },
                                  ),
                                  DashboardTile(
                                    title: '${drawerNames[6]}',
                                    icon: drawerIcons[6],
                                    description:
                                        '${appProvider.currentDashboard.countryCount}',
                                    onPress: () {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .currentPage = 6;
                                    },
                                  ),
                                  DashboardTile(
                                    isSelected: priceTileSelected,
                                    title: '${drawerNames[7]}',
                                    icon: drawerIcons[7],
                                    description:
                                        '${appProvider.currentDashboard.consultationFee.amount} kr',
                                    onPress: () {
                                      setState(() {
                                        priceTileSelected = !priceTileSelected;
                                        aboutUsTileSelected = false;
                                        contactUsTileSelected = false;
                                      });
                                    },
                                  ),
                                  DashboardTile(
                                    isSelected: aboutUsTileSelected,
                                    title: '${drawerNames[8]}',
                                    icon: drawerIcons[8],
                                    description: '',
                                    onPress: () {
                                      setState(() {
                                        priceTileSelected = false;
                                        aboutUsTileSelected =
                                            !aboutUsTileSelected;
                                        contactUsTileSelected = false;
                                      });
                                    },
                                  ),
                                  DashboardTile(
                                    isSelected: contactUsTileSelected,
                                    title: '${drawerNames[9]}',
                                    icon: drawerIcons[9],
                                    description: '',
                                    onPress: () {
                                      setState(() {
                                        priceTileSelected = false;
                                        aboutUsTileSelected = false;
                                        contactUsTileSelected =
                                            !contactUsTileSelected;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: (priceTileSelected ||
                                aboutUsTileSelected ||
                                contactUsTileSelected)
                            ? 304
                            : 0,
                        child: sidePanel(locale),
                      )
                    ],
                  ),
                ),
                desktop: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child:  Scrollbar(
                          interactive:true,
                          controller: pageScrollController,
                          child: SingleChildScrollView(
                            controller: pageScrollController,
                            child: Center(
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                runAlignment: WrapAlignment.start,
                                children: [
                                  DashboardTile(
                                    title: '${drawerNames[1]}',
                                    icon: drawerIcons[1],
                                    description:
                                        '${appProvider.currentDashboard.userCount}',
                                    onPress: () {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .currentPage = 1;
                                    },
                                  ),
                                  DashboardTile(
                                    title: '${drawerNames[2]}',
                                    icon: drawerIcons[2],
                                    description:
                                        '${appProvider.currentDashboard.childProgramCount}',
                                    onPress: () {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .currentPage = 2;
                                    },
                                  ),
                                  DashboardTile(
                                    title: '${drawerNames[3]}',
                                    icon: drawerIcons[3],
                                    description:
                                        '${appProvider.currentDashboard.diseaseCount}',
                                    onPress: () {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .currentPage = 3;
                                    },
                                  ),
                                  DashboardTile(
                                    title: '${drawerNames[4]}',
                                    icon: drawerIcons[4],
                                    description:
                                        '${appProvider.currentDashboard.vaccineCount}',
                                    onPress: () {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .currentPage = 4;
                                    },
                                  ),
                                  DashboardTile(
                                    title: '${drawerNames[5]}',
                                    icon: drawerIcons[5],
                                    description:
                                        '${appProvider.currentDashboard.orderCount}',
                                    onPress: () {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .currentPage = 5;
                                    },
                                  ),
                                  DashboardTile(
                                    title: '${drawerNames[6]}',
                                    icon: drawerIcons[6],
                                    description:
                                        '${appProvider.currentDashboard.countryCount}',
                                    onPress: () {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .currentPage = 6;
                                    },
                                  ),
                                  DashboardTile(
                                    isSelected: priceTileSelected,
                                    title: '${drawerNames[7]}',
                                    icon: drawerIcons[7],
                                    description:
                                        '${appProvider.currentDashboard.consultationFee.amount} kr',
                                    onPress: () {
                                      setState(() {
                                        priceTileSelected = !priceTileSelected;
                                        aboutUsTileSelected = false;
                                        contactUsTileSelected = false;
                                      });
                                    },
                                  ),
                                  DashboardTile(
                                    isSelected: aboutUsTileSelected,
                                    title: '${drawerNames[8]}',
                                    icon: drawerIcons[8],
                                    description: '',
                                    onPress: () {
                                      setState(() {
                                        priceTileSelected = false;
                                        aboutUsTileSelected =
                                            !aboutUsTileSelected;
                                        contactUsTileSelected = false;
                                      });
                                    },
                                  ),
                                  DashboardTile(
                                    isSelected: contactUsTileSelected,
                                    title: '${drawerNames[9]}',
                                    icon: drawerIcons[9],
                                    description: '',
                                    onPress: () {
                                      setState(() {
                                        priceTileSelected = false;
                                        aboutUsTileSelected =false;
                                        contactUsTileSelected = !contactUsTileSelected;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: (priceTileSelected ||
                                aboutUsTileSelected ||
                                contactUsTileSelected)
                            ? 304
                            : 0,
                        child: sidePanel(locale),
                      )
                    ],
                  ),
                )),
          ));
  }

  Widget sidePanel(AppLocalizations locale){
    return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          foregroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.close_rounded),
              onPressed: () {
                setState(() {
                  priceTileSelected = false;
                  aboutUsTileSelected = false;
                  contactUsTileSelected = false;
                });
              }),
          title: Text(
            priceTileSelected
                ? locale.consultationFee
                : aboutUsTileSelected
                ? locale.aboutUs
                : locale.contactUs,
            style: TextStyle(
                color: Colors.blueGrey, fontSize: 16),
          ),
        ),
        body: priceTileSelected
            ? ConsultationFeeUpdatePage()
            :aboutUsTileSelected
            ? AboutUsUpdatePage()
            : ContactUsUpdatePage());
  }
}
