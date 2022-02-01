import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/child_vaccine_program_model.dart';
import 'package:vaksine_web/pages/child_vaccine_programmes/ChildVaccineProgrammeUpdatePage.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';
import 'package:vaksine_web/widget/ChildVaccineProgrammeTile.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChildVaccineProgrammePage extends StatefulWidget {
  const ChildVaccineProgrammePage({Key? key}) : super(key: key);

  @override
  _ChildVaccineProgrammePageState createState() =>
      _ChildVaccineProgrammePageState();
}

class _ChildVaccineProgrammePageState extends State<ChildVaccineProgrammePage> {
  bool isLoading = true;
  ScrollController pageScrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      isLoading = await HttpService.getChildVaccineProgram(context);
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
                  phone: appProvider.selectedChildProgram.id !=
                          ChildVaccineProgramModel().id
                      ? sidePanel(locale!, appProvider)
                      : Container(
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
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        runAlignment: WrapAlignment.start,
                                        children: [
                                          for (ChildVaccineProgramModel model
                                              in appProvider
                                                  .childVaccineProgramList)
                                            ChildVaccineProgrammeTile(
                                              onPress: () {
                                                if (Provider.of<AppProvider>(
                                                            context,
                                                            listen: false)
                                                        .selectedChildProgram !=
                                                    model) {
                                                  Provider.of<AppProvider>(
                                                              context,
                                                              listen: false)
                                                          .selectedChildProgram =
                                                      ChildVaccineProgramModel();
                                                  Provider.of<AppProvider>(
                                                              context,
                                                              listen: false)
                                                          .selectedChildProgram =
                                                      model;
                                                } else {
                                                  Provider.of<AppProvider>(
                                                              context,
                                                              listen: false)
                                                          .selectedChildProgram =
                                                      ChildVaccineProgramModel();
                                                }
                                              },
                                              year: '${model.year}',
                                              isSelected: appProvider
                                                      .selectedChildProgram ==
                                                  model,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: appProvider.selectedChildProgram.id !=
                                        ChildVaccineProgramModel().id
                                    ? 304
                                    : 0,
                                child: sidePanel(locale!, appProvider),
                              )
                            ],
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
                                    for (ChildVaccineProgramModel model
                                        in appProvider.childVaccineProgramList)
                                      ChildVaccineProgrammeTile(
                                        onPress: () {
                                          if (Provider.of<AppProvider>(context,
                                                      listen: false)
                                                  .selectedChildProgram !=
                                              model) {
                                            Provider.of<AppProvider>(context,
                                                        listen: false)
                                                    .selectedChildProgram =
                                                ChildVaccineProgramModel();
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .selectedChildProgram = model;
                                          } else {
                                            Provider.of<AppProvider>(context,
                                                        listen: false)
                                                    .selectedChildProgram =
                                                ChildVaccineProgramModel();
                                          }
                                        },
                                        year: '${model.year}',
                                        isSelected:
                                            appProvider.selectedChildProgram ==
                                                model,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: appProvider.selectedChildProgram.id !=
                                  ChildVaccineProgramModel().id
                              ? 304
                              : 0,
                          child: sidePanel(locale, appProvider),
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
                                    for (ChildVaccineProgramModel model
                                        in appProvider.childVaccineProgramList)
                                      ChildVaccineProgrammeTile(
                                        onPress: () {
                                          if (Provider.of<AppProvider>(context,
                                                      listen: false)
                                                  .selectedChildProgram !=
                                              model) {
                                            Provider.of<AppProvider>(context,
                                                        listen: false)
                                                    .selectedChildProgram =
                                                ChildVaccineProgramModel();
                                            Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .selectedChildProgram = model;
                                          } else {
                                            Provider.of<AppProvider>(context,
                                                        listen: false)
                                                    .selectedChildProgram =
                                                ChildVaccineProgramModel();
                                          }
                                        },
                                        year: '${model.year}',
                                        isSelected:
                                            appProvider.selectedChildProgram ==
                                                model,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: appProvider.selectedChildProgram.id !=
                                  ChildVaccineProgramModel().id
                              ? 304
                              : 0,
                          child: sidePanel(locale, appProvider),
                        )
                      ],
                    ),
                  )),
            ),
            floatingActionButton: Visibility(
              visible: !(appProvider.selectedChildProgram.id != ChildVaccineProgramModel().id && ResponsiveLayout.isPhone(context)),
              child: FloatingActionButton.extended(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                icon: Icon(Icons.add_rounded),
                onPressed: () {
                  Provider.of<AppProvider>(context, listen: false)
                          .selectedChildProgram =
                      ChildVaccineProgramModel(id: 'new');
                },
                label: Text(locale.add),
              ),
            ),
            floatingActionButtonLocation:
                appProvider.selectedChildProgram.id != ChildVaccineProgramModel().id
                    ? FloatingActionButtonLocation.centerFloat
                    : FloatingActionButtonLocation.endFloat,
          );
  }

  Widget sidePanel(AppLocalizations locale, AppProvider appProvider) {
    ChildVaccineProgramModel programme = appProvider.selectedChildProgram;
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
                  Provider.of<AppProvider>(context, listen: false)
                      .selectedChildProgram = ChildVaccineProgramModel();
                });
              }),
          title: Text(
            appProvider.selectedChildProgram.year,
            style: TextStyle(color: Colors.blueGrey, fontSize: 16),
          ),
        ),
        body: ChildVaccineProgrammeUpdatePage(
          key: UniqueKey(),
        ));
  }
}
