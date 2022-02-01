import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/country_model.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';
import 'package:vaksine_web/widget/AppTabIndicator.dart';
import 'package:vaksine_web/widget/ExpiryCountTile.dart';
import 'package:vaksine_web/widget/FemaleQuestionTile.dart';
import 'package:vaksine_web/widget/MaleQuestionTile.dart';

class VaccineUpdatePage extends StatefulWidget {
  const VaccineUpdatePage({Key? key}) : super(key: key);

  @override
  _VaccineUpdatePageState createState() => _VaccineUpdatePageState();
}

class _VaccineUpdatePageState extends State<VaccineUpdatePage> {
  TextEditingController nameEnController = TextEditingController();
  TextEditingController nameBoController = TextEditingController();
  TextEditingController categoryEnController = TextEditingController();
  TextEditingController categoryBoController = TextEditingController();
  TextEditingController vaccineIdController = TextEditingController();
  TextEditingController keyController = TextEditingController();
  ScrollController pageScrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  bool isError = false;
  bool isLoading = false;
  bool isButtonPressed = false;
  bool isEditMode = false;
  bool isDeleteMode = false;
  int groupValue = 0;
  List<Widget> children = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      AppLocalizations? locale = AppLocalizations.of(context);
      nameEnController.text = (Provider.of<AppProvider>(context, listen: false)
              .selectedVaccine
              .nameEn)
          .toString();
      nameBoController.text = (Provider.of<AppProvider>(context, listen: false)
              .selectedVaccine
              .nameBo)
          .toString();
      categoryEnController.text =
          (Provider.of<AppProvider>(context, listen: false)
                  .selectedVaccine
                  .categoryNameEn)
              .toString();
      categoryBoController.text =
          (Provider.of<AppProvider>(context, listen: false)
                  .selectedVaccine
                  .categoryNameBo)
              .toString();

      vaccineIdController.text =
          (Provider.of<AppProvider>(context, listen: false)
                  .selectedVaccine
                  .vaccineId)
              .toString();

      isEditMode =
          Provider.of<AppProvider>(context, listen: false).selectedVaccine.id ==
              'new';

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    AppLocalizations? locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: (!isEditMode && !isDeleteMode)
          ? AppBar(
              backgroundColor: Theme.of(context).cardColor,
              foregroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              leadingWidth: 80,
              toolbarHeight: 48,
              leading: TextButton(
                onPressed: () {
                  setState(() {
                    isDeleteMode = true;
                  });
                },
                child: Text(
                  locale!.delete,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              automaticallyImplyLeading: false,
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isEditMode = true;
                    });
                  },
                  child: Text(locale.edit),
                )
              ],
            )
          : null,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Scrollbar(
                  interactive: true,
                  controller: pageScrollController,
                  child: SingleChildScrollView(
                    controller: pageScrollController,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '${locale!.name}:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            keyboardType: TextInputType.text,
                            controller: nameBoController,
                            maxLines: 1,
                            onChanged: (val) {
                              isButtonPressed = false;
                              if (isError) {
                                formKey.currentState!.validate();
                              }
                            },
                            validator: (val) {
                              if (!isButtonPressed) {
                                return null;
                              }
                              isError = true;
                              if (val!.isEmpty) {
                                return '${locale.name} ${locale.cannotBeEmpty}';
                              } else {
                                isError = false;
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Bokmål',
                              labelText: 'Bokmål',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey, width: 2)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            controller: nameEnController,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            onChanged: (val) {
                              isButtonPressed = false;
                              if (isError) {
                                formKey.currentState!.validate();
                              }
                            },
                            validator: (val) {
                              if (!isButtonPressed) {
                                return null;
                              }
                              isError = true;
                              if (val!.isEmpty) {
                                return '${locale.name} ${locale.cannotBeEmpty}';
                              } else {
                                isError = false;
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'English',
                              labelText: 'English',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey, width: 2)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '${locale.vaccineId}:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            keyboardType: TextInputType.text,
                            controller: vaccineIdController,
                            maxLines: 1,
                            onChanged: (val) {
                              isButtonPressed = false;
                              if (isError) {
                                formKey.currentState!.validate();
                              }
                            },
                            validator: (val) {
                              if (!isButtonPressed) {
                                return null;
                              }
                              isError = true;
                              if (val!.isEmpty) {
                                return '${locale.vaccineId} ${locale.cannotBeEmpty}';
                              } else {
                                isError = false;
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: '${locale.vaccineId}',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey, width: 2)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '${locale.category}:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            keyboardType: TextInputType.text,
                            controller: categoryBoController,
                            maxLines: 1,
                            onChanged: (val) {
                              isButtonPressed = false;
                              if (isError) {
                                formKey.currentState!.validate();
                              }
                            },
                            validator: (val) {
                              if (!isButtonPressed) {
                                return null;
                              }
                              isError = true;
                              if (val!.isEmpty) {
                                return '${locale.category} ${locale.cannotBeEmpty}';
                              } else {
                                isError = false;
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Bokmål',
                              labelText: 'Bokmål',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey, width: 2)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            controller: categoryEnController,
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            onChanged: (val) {
                              isButtonPressed = false;
                              if (isError) {
                                formKey.currentState!.validate();
                              }
                            },
                            validator: (val) {
                              if (!isButtonPressed) {
                                return null;
                              }
                              isError = true;
                              if (val!.isEmpty) {
                                return '${locale.category} ${locale.cannotBeEmpty}';
                              } else {
                                isError = false;
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'English',
                              labelText: 'English',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey, width: 2)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          Row(
                            children: [
                              Text(
                                '${locale.questionnaire}:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              Spacer(),
                              OutlinedButton(
                                  onPressed: groupValue==0?() {
                                    Provider.of<AppProvider>(context,
                                            listen: false)
                                        .selectedVaccine
                                        .vaccineQuestionsMaleEn
                                        .add(' ');
                                    Provider.of<AppProvider>(context,
                                            listen: false)
                                        .selectedVaccine
                                        .vaccineQuestionsMaleBo
                                        .add(' ');

                                    setState(() {});
                                  }:() {
                                    Provider.of<AppProvider>(context,
                                            listen: false)
                                        .selectedVaccine
                                        .vaccineQuestionsFemaleEn
                                        .add(' ');
                                    Provider.of<AppProvider>(context,
                                            listen: false)
                                        .selectedVaccine
                                        .vaccineQuestionsFemaleBo
                                        .add(' ');

                                    setState(() {});
                                  },
                                  child: Text('${locale.add}'))
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int m = 0; m < 2; m++)
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        groupValue = m;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(4),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 6),
                                      child: Text(
                                        m == 0
                                            ? '${locale.male}'
                                            : '${locale.female}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: m == groupValue
                                                ? Colors.white
                                                : Colors.blueGrey),
                                      ),
                                      decoration: BoxDecoration(
                                          color: m == groupValue
                                              ? Color(0xFF05A7E7)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if(groupValue==0)for (int k = 0;
                              k <
                                  appProvider.selectedVaccine
                                      .vaccineQuestionsMaleEn.length;
                              k++)
                            MaleQuestionTile(
                                index: k,
                                formKey: formKey,
                                onDeletePress: () {
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .selectedVaccine
                                      .vaccineQuestionsMaleEn
                                      .removeAt(k);
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .selectedVaccine
                                      .vaccineQuestionsMaleBo
                                      .removeAt(k);
                                  setState(() {});
                                }),
                          if(groupValue==1)for (int k = 0;
                              k <
                                  appProvider.selectedVaccine
                                      .vaccineQuestionsFemaleEn.length;
                              k++)
                            FemaleQuestionTile(
                                index: k,
                                formKey: formKey,
                                onDeletePress: () {
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .selectedVaccine
                                      .vaccineQuestionsFemaleEn
                                      .removeAt(k);
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .selectedVaccine
                                      .vaccineQuestionsFemaleBo
                                      .removeAt(k);
                                  setState(() {});
                                }),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                          ),
                          if (isEditMode)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 32.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  isButtonPressed = true;
                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                      isEditMode = false;
                                    });

                                    if (appProvider.selectedVaccine.id ==
                                        'new') {
                                      isLoading = await HttpService
                                          .createVaccine(context,
                                              nameBo: nameBoController.text,
                                              nameEn: nameEnController.text,
                                              categoryBo:
                                                  categoryBoController.text,
                                              categoryEn:
                                                  categoryEnController.text,
                                              vaccineId:
                                                  vaccineIdController.text,
                                              vaccineQuestionsMaleEn:
                                                  appProvider.selectedVaccine
                                                      .vaccineQuestionsMaleEn,
                                              vaccineQuestionsMaleBo:
                                                  appProvider.selectedVaccine
                                                      .vaccineQuestionsMaleBo,
                                              vaccineQuestionsFemaleEn:
                                                  appProvider.selectedVaccine
                                                      .vaccineQuestionsFemaleEn,
                                              vaccineQuestionsFemaleBo:
                                                  appProvider.selectedVaccine
                                                      .vaccineQuestionsFemaleBo);
                                    } else {
                                      isLoading =
                                          await HttpService.updateVaccine(
                                        context,
                                        appProvider.selectedVaccine.id,
                                        nameBo: nameBoController.text,
                                        nameEn: nameEnController.text,
                                        categoryBo: categoryBoController.text,
                                        categoryEn: categoryEnController.text,
                                        vaccineId: vaccineIdController.text,
                                        vaccineQuestionsMaleEn: appProvider
                                            .selectedVaccine
                                            .vaccineQuestionsMaleEn,
                                        vaccineQuestionsMaleBo: appProvider
                                            .selectedVaccine
                                            .vaccineQuestionsMaleBo,
                                        vaccineQuestionsFemaleEn: appProvider
                                            .selectedVaccine
                                            .vaccineQuestionsFemaleEn,
                                        vaccineQuestionsFemaleBo: appProvider
                                            .selectedVaccine
                                            .vaccineQuestionsFemaleBo,
                                      );
                                    }
                                    setState(() {});
                                  }
                                },
                                child: Text(locale.save),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                    visible: !isEditMode,
                    child: Positioned.fill(
                        child:
                            Container(color: Colors.white.withOpacity(0.7)))),
                Visibility(
                    visible: isDeleteMode,
                    child: Positioned.fill(
                        child: Container(
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 8),
                              child: Text(
                                '${locale.deleteAlert} ${appProvider.appLocale.languageCode == 'en' ? appProvider.selectedVaccine.nameEn : appProvider.selectedVaccine.nameBo}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.red),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white)),
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = true;
                                        isEditMode = false;
                                      });

                                      isLoading =
                                          await HttpService.deleteVaccine(
                                              context,
                                              appProvider.selectedVaccine.id);
                                      setState(() {});
                                    },
                                    child: Text(
                                      locale.delete,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isDeleteMode = false;
                                      });
                                    },
                                    child: Text(
                                      locale.no,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ))),
                Visibility(
                    visible: isLoading,
                    child: Positioned.fill(
                        child: Container(
                      color: Colors.white.withOpacity(0.7),
                      child: Center(child: CircularProgressIndicator()),
                    )))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
