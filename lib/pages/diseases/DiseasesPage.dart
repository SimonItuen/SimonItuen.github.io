import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/child_vaccine_program_model.dart';
import 'package:vaksine_web/models/disease_model.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';
import 'package:vaksine_web/widget/DiseasesTile.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiseasesPage extends StatefulWidget {
  const DiseasesPage({Key? key}) : super(key: key);

  @override
  _DiseasesPageState createState() => _DiseasesPageState();
}

class _DiseasesPageState extends State<DiseasesPage> {
  bool isLoading = true;
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
     isLoading= await HttpService.getDiseases(context);
     setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    AppLocalizations? locale = AppLocalizations.of(context);
    return isLoading?Scaffold(body: Center(child: CircularProgressIndicator())):Scaffold(
        body: Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ResponsiveLayout(
          phone: Container(
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 3 / 2,
              children: [
                for(DiseaseModel model in appProvider.diseaseList)
                  DiseasesTile(
                    onPress: () {}, title: '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}', isSelected: false,
                  ),
              ],
            ),
          ),
          tablet: Container(
            child: GridView.count(
              crossAxisCount: 4,
              childAspectRatio: 2 / 1,
              children: [
                for(DiseaseModel model in appProvider.diseaseList)
                  DiseasesTile(
                    onPress: () {}, title: '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}', isSelected: false,
                  ),
              ],
            ),
          ),
          desktop: Container(
            child: GridView.count(
              crossAxisCount: 5,
              childAspectRatio: 2 / 1,
              children: [
                for(DiseaseModel model in appProvider.diseaseList)
                DiseasesTile(
                  onPress: () {}, title: '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}', isSelected: false,
                ),
              ],
            ),
          )),
    ));
  }
}
