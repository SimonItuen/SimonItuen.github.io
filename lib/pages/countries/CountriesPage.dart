import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/child_vaccine_program_model.dart';
import 'package:vaksine_web/models/country_model.dart';
import 'package:vaksine_web/pages/countries/CountryUpdatePage.dart';
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
  ScrollController pageScrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      isLoading = await HttpService.getCountries(context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    AppLocalizations? locale = AppLocalizations.of(context);

    return isLoading
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            body: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ResponsiveLayout(
                  phone: appProvider.selectedCountry.id != CountryModel().id
                      ? sidePanel(locale!, appProvider)
                      : Container(
                          child: Scrollbar(
                            interactive: true,
                            controller: pageScrollController,
                            child: SingleChildScrollView(
                              padding: EdgeInsets.only(bottom: 64),
                              controller: pageScrollController,
                              child: Center(
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  runAlignment: WrapAlignment.start,
                                  children: [
                                    for (CountryModel model
                                        in appProvider.countryList)
                                      CountriesTile(
                                        onPress: () {
                                          if (Provider.of<AppProvider>(context,
                                                      listen: false)
                                                  .selectedCountry !=
                                              model) {
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .selectedCountry = model;
                                          } else {
                                            Provider.of<AppProvider>(context,
                                                        listen: false)
                                                    .selectedCountry =
                                                CountryModel();
                                          }
                                        },
                                        isSelected: false,
                                        name:
                                            '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}',
                                        code: '${model.code}',
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
                          child: Scrollbar(
                            interactive: true,
                            controller: pageScrollController,
                            child: SingleChildScrollView(
                              padding: EdgeInsets.only(bottom: 64),
                              controller: pageScrollController,
                              child: Center(
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  runAlignment: WrapAlignment.start,
                                  children: [
                                    for (CountryModel model
                                        in appProvider.countryList)
                                      CountriesTile(
                                        onPress: () {
                                          if (Provider.of<AppProvider>(context,
                                                      listen: false)
                                                  .selectedCountry !=
                                              model) {
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .selectedCountry = model;
                                          } else {
                                            Provider.of<AppProvider>(context,
                                                        listen: false)
                                                    .selectedCountry =
                                                CountryModel();
                                          }
                                        },
                                        isSelected:
                                            appProvider.selectedCountry ==
                                                model,
                                        name:
                                            '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}',
                                        code: '${model.code}',
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: appProvider.selectedCountry.id !=
                                  CountryModel().id
                              ? 304
                              : 0,
                          child: sidePanel(locale!, appProvider),
                        )
                      ],
                    ),
                  ),
                  desktop: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Scrollbar(
                            interactive: true,
                            controller: pageScrollController,
                            child: SingleChildScrollView(
                              padding: EdgeInsets.only(bottom: 64),
                              controller: pageScrollController,
                              child: Center(
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  runAlignment: WrapAlignment.start,
                                  children: [
                                    for (CountryModel model
                                        in appProvider.countryList)
                                      CountriesTile(
                                        onPress: () {
                                          if (Provider.of<AppProvider>(context,
                                                      listen: false)
                                                  .selectedCountry !=
                                              model) {
                                            Provider.of<AppProvider>(context,
                                                        listen: false)
                                                    .selectedCountry =
                                                CountryModel();
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .selectedCountry = model;
                                          } else {
                                            Provider.of<AppProvider>(context,
                                                        listen: false)
                                                    .selectedCountry =
                                                CountryModel();
                                          }
                                        },
                                        isSelected:
                                            appProvider.selectedCountry ==
                                                model,
                                        name:
                                            '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}',
                                        code: '${model.code}',
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: appProvider.selectedCountry.id !=
                                  CountryModel().id
                              ? 304
                              : 0,
                          child: sidePanel(locale, appProvider),
                        )
                      ],
                    ),
                  )),
            ),
            floatingActionButton: Visibility(
                visible: !(appProvider.selectedCountry.id != CountryModel().id && ResponsiveLayout.isPhone(context)),
              child: FloatingActionButton.extended(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                icon: Icon(Icons.add_rounded),
                onPressed: () {
                  Provider.of<AppProvider>(context, listen: false)
                      .selectedCountry = CountryModel(id: 'new');
                }, label: Text(locale.add),
              ),
            ),
      floatingActionButtonLocation: appProvider.selectedCountry.id != CountryModel().id?FloatingActionButtonLocation.centerFloat:FloatingActionButtonLocation.endFloat,
          );
  }

  Widget sidePanel(AppLocalizations locale, AppProvider appProvider) {
    CountryModel country = appProvider.selectedCountry;
    return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          foregroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.close_rounded),
              onPressed: () {
                Future.delayed(Duration.zero, () async {
                  await HttpService.getCountries(context);
                });
                setState(() {
                  Provider.of<AppProvider>(context, listen: false)
                      .selectedCountry = CountryModel();
                });
              }),
          title: Text(
            appProvider.appLocale.languageCode == 'en'
                ? country.nameEn
                : country.nameBo,
            style: TextStyle(color: Colors.blueGrey, fontSize: 16),
          ),
        ),
        body: CountryUpdatePage(
          key: UniqueKey(),
        ));
  }
}
