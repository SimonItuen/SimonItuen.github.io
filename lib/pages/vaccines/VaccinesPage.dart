import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/vaccine_model.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';
import 'package:vaksine_web/widget/VaccinesTile.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VaccinesPage extends StatefulWidget {
  const VaccinesPage({Key? key}) : super(key: key);

  @override
  _VaccinesPageState createState() => _VaccinesPageState();
}

class _VaccinesPageState extends State<VaccinesPage> {
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
     isLoading= await HttpService.getVaccines(context);
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
          phone:Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for(VaccineModel model in appProvider.vaccineList)
                    VaccinesTile(onPress: (){}, id: '${model.vaccineId}',name: '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}',category: '${appProvider.appLocale.languageCode == 'en' ? model.categoryNameEn : model.categoryNameBo}')

                ],
              ),
            ),
          ),
          tablet: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for(VaccineModel model in appProvider.vaccineList)
                    VaccinesTile(onPress: (){}, id: '${model.vaccineId}',name: '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}',category: '${appProvider.appLocale.languageCode == 'en' ? model.categoryNameEn : model.categoryNameBo}')

                ],
              ),
            ),
          ),
          desktop: Container(
            child: SingleChildScrollView(
              child: Column(
              children: [
                for(VaccineModel model in appProvider.vaccineList)
                  VaccinesTile(onPress: (){}, id: '${model.vaccineId}',name: '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}',category: '${appProvider.appLocale.languageCode == 'en' ? model.categoryNameEn : model.categoryNameBo}')

              ],
              ),
            ),
          )),
    ));
  }
}
