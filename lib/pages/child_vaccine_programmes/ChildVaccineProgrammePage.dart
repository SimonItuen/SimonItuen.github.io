import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/child_vaccine_program_model.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';
import 'package:vaksine_web/widget/ChildVaccineProgrammeTile.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChildVaccineProgrammePage extends StatefulWidget {
  const ChildVaccineProgrammePage({Key? key}) : super(key: key);

  @override
  _ChildVaccineProgrammePageState createState() => _ChildVaccineProgrammePageState();
}

class _ChildVaccineProgrammePageState extends State<ChildVaccineProgrammePage> {
  bool isLoading = true;
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
     isLoading= await HttpService.getChildVaccineProgram(context);
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
          phone:GridView.count(
            crossAxisCount: 6,
            childAspectRatio: 2 / 1,
            children: [
              for(ChildVaccineProgramModel model in appProvider.childVaccineProgramList)
                ChildVaccineProgrammeTile(
                  onPress: () {}, year: '${model.year}', isSelected: model.year=='2000',
                ),
            ],
          ),
          tablet:  Container(
            child: GridView.count(
              crossAxisCount: 6,
              childAspectRatio: 2 / 1.2,
              children: [
                for(ChildVaccineProgramModel model in appProvider.childVaccineProgramList)
                  ChildVaccineProgrammeTile(
                    onPress: () {}, year: '${model.year}', isSelected: model.year=='2000',
                  ),
              ],
            ),
          ),
          desktop: Container(
            child: GridView.count(
              crossAxisCount: 7,
              childAspectRatio: 2 / 1,
              children: [
                for(ChildVaccineProgramModel model in appProvider.childVaccineProgramList)
                ChildVaccineProgrammeTile(
                  onPress: () {}, year: '${model.year}', isSelected: model.year=='2000',
                ),
              ],
            ),
          )),
    ));
  }
}
