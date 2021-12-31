import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/child_vaccine_program_model.dart';
import 'package:vaksine_web/models/country_model.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';
import 'package:vaksine_web/widget/CountriesTile.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CountriesPage extends StatefulWidget {
  const CountriesPage({Key? key}) : super(key: key);

  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  bool isLoading = true;
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
     isLoading= await HttpService.getCountries(context);
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
              childAspectRatio: 4 /3,
              children: [
                for(CountryModel model in appProvider.countryList)
                  CountriesTile(
                    onPress: () {}, isSelected: model.code.toLowerCase()=='ng', name: '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}', code: '${model.code}',
                  ),
              ],
            ),
          ),
          tablet: Container(
            child: GridView.count(
              crossAxisCount: 5,
              childAspectRatio: 3 / 2,
              children: [
                for(CountryModel model in appProvider.countryList)
                  CountriesTile(
                    onPress: () {}, isSelected: model.code.toLowerCase()=='ng', name: '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}', code: '${model.code}',
                  ),
              ],
            ),
          ),
          desktop: Container(
            child: GridView.count(
              crossAxisCount: 6,
              childAspectRatio: 3 / 2,
              children: [
                for(CountryModel model in appProvider.countryList)
                CountriesTile(
                  onPress: () {}, isSelected: model.code.toLowerCase()=='ng', name: '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}', code: '${model.code}',
                ),
              ],
            ),
          )),
    ));
  }
}
