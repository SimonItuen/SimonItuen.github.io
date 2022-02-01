import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/country_model.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';
import 'package:vaksine_web/widget/AppTabIndicator.dart';

class CountryUpdatePage extends StatefulWidget {
  const CountryUpdatePage({Key? key}) : super(key: key);

  @override
  _CountryUpdatePageState createState() => _CountryUpdatePageState();
}

class _CountryUpdatePageState extends State<CountryUpdatePage> {
  TextEditingController nameEnController = TextEditingController();
  TextEditingController nameBoController = TextEditingController();
  TextEditingController malariaEnController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController malariaBoController = TextEditingController();
  TextEditingController shortTripController = TextEditingController();
  TextEditingController longTripController = TextEditingController();
  ScrollController pageScrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  bool isError = false;
  bool isLoading = false;
  bool isButtonPressed = false;
  bool isEditMode = false;
  bool isDeleteMode = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      nameEnController.text = (Provider.of<AppProvider>(context, listen: false)
              .selectedCountry
              .nameEn)
          .toString();
      nameBoController.text = (Provider.of<AppProvider>(context, listen: false)
              .selectedCountry
              .nameBo)
          .toString();
      malariaEnController.text =
          (Provider.of<AppProvider>(context, listen: false)
                  .selectedCountry
                  .malPrevEn)
              .toString();
      malariaBoController.text =
          (Provider.of<AppProvider>(context, listen: false)
                  .selectedCountry
                  .malPrevBo)
              .toString();
      codeController.text = (Provider.of<AppProvider>(context, listen: false)
              .selectedCountry
              .code)
          .toString();
      shortTripController.text =
          (Provider.of<AppProvider>(context, listen: false)
                  .selectedCountry
                  .shortTrip)
              .toString();
      longTripController.text =
          (Provider.of<AppProvider>(context, listen: false)
                  .selectedCountry
                  .shortTrip)
              .toString();
      isEditMode = Provider.of<AppProvider>(context, listen: false)
          .selectedCountry.id =='new';

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
                            /*
                            controller: nameEnController,*/
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
                                '${locale.code}:',
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
                            controller: codeController,
                            maxLines: 1,
                            maxLength: 2,
                            maxLengthEnforcement: MaxLengthEnforcement
                                .truncateAfterCompositionEnds,
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
                                return '${locale.code} ${locale.cannotBeEmpty}';
                              } else {
                                isError = false;
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: '${locale.code}',
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
                                '${locale.group1}:',
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
                            controller: shortTripController,
                            maxLines: 3,
                            maxLengthEnforcement: MaxLengthEnforcement
                                .truncateAfterCompositionEnds,
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
                                return '${locale.group1} ${locale.cannotBeEmpty}';
                              } else {
                                isError = false;
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: '${locale.group1}',
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
                                '${locale.group2}:',
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
                            controller: longTripController,
                            maxLines: 5,
                            maxLengthEnforcement: MaxLengthEnforcement
                                .truncateAfterCompositionEnds,
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
                                return '${locale.group2} ${locale.cannotBeEmpty}';
                              } else {
                                isError = false;
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: '${locale.group2}',
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
                                '${locale.malariaPrevention}:',
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
                            controller: malariaBoController,
                            maxLines: 6,
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
                                return '${locale.malariaPrevention} ${locale.cannotBeEmpty}';
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
                            maxLines: 6,
                            keyboardType: TextInputType.text,
                            controller: malariaEnController,
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
                                return '${locale.malariaPrevention} ${locale.cannotBeEmpty}';
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

                                    if (appProvider.selectedCountry.id ==
                                        'new') {
                                      isLoading =
                                          await HttpService.createCountry(
                                              context,
                                              nameBo: nameBoController.text,
                                              nameEn: nameEnController.text,
                                              malPrevBo:
                                                  malariaBoController.text,
                                              malPrevEn:
                                                  malariaEnController.text,
                                              shortTrip:
                                                  shortTripController.text,
                                              longTrip: longTripController.text,
                                              code: codeController.text);
                                    } else {
                                      isLoading =
                                          await HttpService.updateCountry(
                                              context,
                                              appProvider.selectedCountry.id,
                                              nameBo: nameBoController.text,
                                              nameEn: nameEnController.text,
                                              malPrevBo:
                                                  malariaBoController.text,
                                              malPrevEn:
                                                  malariaEnController.text,
                                              shortTrip:
                                                  shortTripController.text,
                                              longTrip: longTripController.text,
                                              code: codeController.text);
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
                                '${locale.deleteAlert} ${appProvider.appLocale.languageCode == 'en' ? appProvider.selectedCountry.nameEn : appProvider.selectedCountry.nameBo}',
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
                                          await HttpService.deleteCountry(
                                              context,
                                              appProvider.selectedCountry.id);
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
