import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/vaccine_model.dart';
import 'package:vaksine_web/pages/vaccines/VaccineUpdatePage.dart';
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
  ScrollController pageScrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      isLoading = await HttpService.getVaccines(context);
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
                  phone:  appProvider.selectedVaccine.id != VaccineModel().id
                      ? sidePanel(locale!, appProvider)
                      : Container(
                    child: Scrollbar(
                      interactive: true,
                      controller: pageScrollController,
                      child: SingleChildScrollView(
                        controller: pageScrollController,
                        child: Column(
                          children: [
                            for (VaccineModel model in appProvider.vaccineList)
                              VaccinesTile(
                                  onPress: () {
                                    if (Provider.of<AppProvider>(context,
                                                listen: false)
                                            .selectedVaccine !=
                                        model) {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .selectedVaccine = VaccineModel();
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .selectedVaccine = model;
                                    } else {
                                      Provider.of<AppProvider>(context,
                                              listen: false)
                                          .selectedVaccine = VaccineModel();
                                    }
                                  },
                                  isSelected:
                                      appProvider.selectedVaccine == model,
                                  id: '${model.vaccineId}',
                                  name:
                                      '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}',
                                  category:
                                      '${appProvider.appLocale.languageCode == 'en' ? model.categoryNameEn : model.categoryNameBo}')
                          ],
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
                              controller: pageScrollController,
                              child: Column(
                                children: [
                                  for (VaccineModel model
                                      in appProvider.vaccineList)
                                    VaccinesTile(
                                        onPress: () {
                                          if (Provider.of<AppProvider>(context,
                                                      listen: false)
                                                  .selectedVaccine !=
                                              model) {
                                            Provider.of<AppProvider>(context,
                                                        listen: false)
                                                    .selectedVaccine =
                                                VaccineModel();
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .selectedVaccine = model;
                                          } else {
                                            Provider.of<AppProvider>(context,
                                                        listen: false)
                                                    .selectedVaccine =
                                                VaccineModel();
                                          }
                                        },
                                        isSelected:
                                            appProvider.selectedVaccine ==
                                                model,
                                        id: '${model.vaccineId}',
                                        name:
                                            '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}',
                                        category:
                                            '${appProvider.appLocale.languageCode == 'en' ? model.categoryNameEn : model.categoryNameBo}')
                                ],
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: appProvider.selectedVaccine.id !=
                                  VaccineModel().id
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
                              controller: pageScrollController,
                              child: Column(
                                children: [
                                  for (VaccineModel model
                                      in appProvider.vaccineList)
                                    VaccinesTile(
                                        onPress: () {
                                          if (Provider.of<AppProvider>(context,
                                                      listen: false)
                                                  .selectedVaccine !=
                                              model) {
                                            Provider.of<AppProvider>(context,
                                                        listen: false)
                                                    .selectedVaccine =
                                                VaccineModel();
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .selectedVaccine = model;
                                          } else {
                                            Provider.of<AppProvider>(context,
                                                        listen: false)
                                                    .selectedVaccine =
                                                VaccineModel();
                                          }
                                        },
                                        isSelected:
                                            appProvider.selectedVaccine ==
                                                model,
                                        id: '${model.vaccineId}',
                                        name:
                                            '${appProvider.appLocale.languageCode == 'en' ? model.nameEn : model.nameBo}',
                                        category:
                                            '${appProvider.appLocale.languageCode == 'en' ? model.categoryNameEn : model.categoryNameBo}')
                                ],
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: appProvider.selectedVaccine.id !=
                                  VaccineModel().id
                              ? 304
                              : 0,
                          child: sidePanel(locale, appProvider),
                        )
                      ],
                    ),
                  )),
            ),
            floatingActionButton: Visibility(
              visible: !(appProvider.selectedVaccine.id != VaccineModel().id &&
                  ResponsiveLayout.isPhone(context)),
              child: FloatingActionButton.extended(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                icon: Icon(Icons.add_rounded),
                onPressed: () {
                  Provider.of<AppProvider>(context, listen: false)
                      .selectedVaccine = VaccineModel(id: 'new', vaccineQuestionsMaleBo: [], vaccineQuestionsMaleEn: [], vaccineQuestionsFemaleBo: [],vaccineQuestionsFemaleEn: []);
                },
                label: Text(locale.add),
              ),
            ),
            floatingActionButtonLocation:
                appProvider.selectedVaccine.id != VaccineModel().id
                    ? FloatingActionButtonLocation.centerFloat
                    : FloatingActionButtonLocation.endFloat,
          );
  }

  Widget sidePanel(AppLocalizations locale, AppProvider appProvider) {
    VaccineModel vaccine = appProvider.selectedVaccine;
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
                  await HttpService.getVaccines(context);
                });
                setState(() {
                  Provider.of<AppProvider>(context, listen: false)
                      .selectedVaccine = VaccineModel();
                });
              }),
          title: Text(
            appProvider.appLocale.languageCode == 'en'
                ? vaccine.nameEn
                : vaccine.nameBo,
            style: TextStyle(color: Colors.blueGrey, fontSize: 16),
          ),
        ),
        body: VaccineUpdatePage(
          key: UniqueKey(),
        ));
  }
}
