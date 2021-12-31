import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    drawerIcons = [
      Icons.av_timer,
      Icons.supervisor_account_outlined,
      Icons.child_care_rounded,
      Icons.coronavirus_outlined,
      Icons.medication_outlined,
      Icons.shopping_cart_outlined,
      Icons.local_pharmacy_outlined,
      Icons.language_rounded,
      Icons.settings_rounded
    ];
    Future.delayed(Duration.zero, () async {
     isLoading= await HttpService.getDashboard(context);
     setState((){});
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
      locale.pharmacies,
      locale.countries,
      locale.settings,
    ];
    return isLoading?Scaffold(body: Center(child: CircularProgressIndicator())):Scaffold(
        body: Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ResponsiveLayout(
          phone: Container(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 5/3,
              children: [
                DashboardTile(
                  title: '${drawerNames[1]}',
                  icon: drawerIcons[1],
                  description: '${appProvider.currentDashboard.userCount}',
                  onPress: () {},
                ),
                DashboardTile(
                  title: '${drawerNames[2]}',
                  icon: drawerIcons[2],
                  description: '${appProvider.currentDashboard.childProgramCount}',
                  onPress: () {},
                ),
                DashboardTile(
                  title: '${drawerNames[3]}',
                  icon: drawerIcons[3],
                  description: '${appProvider.currentDashboard.diseaseCount}',
                  onPress: () {},
                ),
                DashboardTile(
                  title: '${drawerNames[4]}',
                  icon: drawerIcons[4],
                  description: '${appProvider.currentDashboard.vaccineCount}',
                  onPress: () {},
                ),
                DashboardTile(
                  title: '${drawerNames[5]}',
                  icon: drawerIcons[5],
                  description: '${appProvider.currentDashboard.orderCount}',
                  onPress: () {},
                ),
                DashboardTile(
                  title: '${drawerNames[6]}',
                  icon: drawerIcons[6],
                  description: '${appProvider.currentDashboard.pharmacyCount}',
                  onPress: () {},
                ),
                DashboardTile(
                  title: '${drawerNames[7]}',
                  icon: drawerIcons[7],
                  description: '${appProvider.currentDashboard.countryCount}',
                  onPress: () {},
                ),
              ],
            ),
          ),
          tablet: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 3/2,
            children: [
              DashboardTile(
                title: '${drawerNames[1]}',
                icon: drawerIcons[1],
                description: '${appProvider.currentDashboard.userCount}',
                onPress: () {},
              ),
              DashboardTile(
                title: '${drawerNames[2]}',
                icon: drawerIcons[2],
                description: '${appProvider.currentDashboard.childProgramCount}',
                onPress: () {},
              ),
              DashboardTile(
                title: '${drawerNames[3]}',
                icon: drawerIcons[3],
                description: '${appProvider.currentDashboard.diseaseCount}',
                onPress: () {},
              ),
              DashboardTile(
                title: '${drawerNames[4]}',
                icon: drawerIcons[4],
                description: '${appProvider.currentDashboard.vaccineCount}',
                onPress: () {},
              ),
              DashboardTile(
                title: '${drawerNames[5]}',
                icon: drawerIcons[5],
                description: '${appProvider.currentDashboard.orderCount}',
                onPress: () {},
              ),
              DashboardTile(
                title: '${drawerNames[6]}',
                icon: drawerIcons[6],
                description: '${appProvider.currentDashboard.pharmacyCount}',
                onPress: () {},
              ),
              DashboardTile(
                title: '${drawerNames[7]}',
                icon: drawerIcons[7],
                description: '${appProvider.currentDashboard.countryCount}',
                onPress: () {},
              ),
            ],
          ),
          desktop: Container(
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 2 / 1,
              children: [
                DashboardTile(
                  title: '${drawerNames[1]}',
                  icon: drawerIcons[1],
                  description: '${appProvider.currentDashboard.userCount}',
                  onPress: () {},
                ),
                DashboardTile(
                  title: '${drawerNames[2]}',
                  icon: drawerIcons[2],
                  description: '${appProvider.currentDashboard.childProgramCount}',
                  onPress: () {},
                ),
                DashboardTile(
                  title: '${drawerNames[3]}',
                  icon: drawerIcons[3],
                  description: '${appProvider.currentDashboard.diseaseCount}',
                  onPress: () {},
                ),
                DashboardTile(
                  title: '${drawerNames[4]}',
                  icon: drawerIcons[4],
                  description: '${appProvider.currentDashboard.vaccineCount}',
                  onPress: () {},
                ),
                DashboardTile(
                  title: '${drawerNames[5]}',
                  icon: drawerIcons[5],
                  description: '${appProvider.currentDashboard.orderCount}',
                  onPress: () {},
                ),
                DashboardTile(
                  title: '${drawerNames[6]}',
                  icon: drawerIcons[6],
                  description: '${appProvider.currentDashboard.pharmacyCount}',
                  onPress: () {},
                ),
                DashboardTile(
                  title: '${drawerNames[7]}',
                  icon: drawerIcons[7],
                  description: '${appProvider.currentDashboard.countryCount}',
                  onPress: () {},
                ),
              ],
            ),
          )),
    ));
  }
}
