import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/child_vaccine_program_model.dart';
import 'package:vaksine_web/models/disease_model.dart';
import 'package:vaksine_web/pages/diseases/DiseaseUpdatePage.dart';
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
  ScrollController pageScrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      isLoading = await HttpService.getDiseases(context);
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
            phone: appProvider.selectedDisease.id != DiseaseModel().id
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
                        for (DiseaseModel model
                        in appProvider.diseaseList)
                          DiseasesTile(
                            onPress: () {
                              if (Provider.of<AppProvider>(context,
                                  listen: false)
                                  .selectedDisease !=
                                  model) {
                                Provider.of<AppProvider>(context,
                                    listen: false)
                                    .selectedDisease = model;
                              } else {
                                Provider.of<AppProvider>(context,
                                    listen: false)
                                    .selectedDisease =
                                    DiseaseModel();
                              }
                            },
                            isSelected: false,
                            title:
                            '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}',
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
                              for (DiseaseModel model
                              in appProvider.diseaseList)
                                DiseasesTile(
                                  onPress: () {
                                    if (Provider.of<AppProvider>(context,
                                        listen: false)
                                        .selectedDisease !=
                                        model) {
                                      Provider.of<AppProvider>(context,
                                          listen: false)
                                          .selectedDisease = model;
                                    } else {
                                      Provider.of<AppProvider>(context,
                                          listen: false)
                                          .selectedDisease =
                                          DiseaseModel();
                                    }
                                  },
                                  isSelected:
                                  appProvider.selectedDisease ==
                                      model,
                                  title:
                                  '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}',
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: appProvider.selectedDisease.id !=
                        DiseaseModel().id
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
                              for (DiseaseModel model
                              in appProvider.diseaseList)
                                DiseasesTile(
                                  onPress: () {
                                    if (Provider.of<AppProvider>(context,
                                        listen: false)
                                        .selectedDisease !=
                                        model) {
                                      Provider.of<AppProvider>(context,
                                          listen: false)
                                          .selectedDisease =
                                          DiseaseModel();
                                      Provider.of<AppProvider>(context,
                                          listen: false)
                                          .selectedDisease = model;
                                    } else {
                                      Provider.of<AppProvider>(context,
                                          listen: false)
                                          .selectedDisease =
                                          DiseaseModel();
                                    }
                                  },
                                  isSelected:
                                  appProvider.selectedDisease ==
                                      model,
                                  title:
                                  '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}',
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: appProvider.selectedDisease.id !=
                        DiseaseModel().id
                        ? 304
                        : 0,
                    child: sidePanel(locale, appProvider),
                  )
                ],
              ),
            )),
      ),
      floatingActionButton: Visibility(
        visible: !(appProvider.selectedDisease.id != DiseaseModel().id && ResponsiveLayout.isPhone(context)),
        child: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          icon: Icon(Icons.add_rounded),
          onPressed: () {
            Provider.of<AppProvider>(context, listen: false)
                .selectedDisease = DiseaseModel(id: 'new', countRule: [], vaccinationDates: []);
          }, label: Text(locale.add),
        ),
      ),
      floatingActionButtonLocation: appProvider.selectedDisease.id != DiseaseModel().id?FloatingActionButtonLocation.centerFloat:FloatingActionButtonLocation.endFloat,
    );
  }

  Widget sidePanel(AppLocalizations locale, AppProvider appProvider) {
    DiseaseModel disease = appProvider.selectedDisease;
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
                  await HttpService.getDiseases(context);
                });
                setState(() {
                  Provider.of<AppProvider>(context, listen: false)
                      .selectedDisease = DiseaseModel();
                });
              }),
          title: Text(
            appProvider.appLocale.languageCode == 'en'
                ? disease.nameEn
                : disease.nameBo,
            style: TextStyle(color: Colors.blueGrey, fontSize: 16),
          ),
        ),
        body: DiseaseUpdatePage(
          key: UniqueKey(),
        ));
  }
}
