import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';
import 'package:vaksine_web/widget/AppTabIndicator.dart';

class ChildVaccineProgrammeUpdatePage extends StatefulWidget {
  const ChildVaccineProgrammeUpdatePage({Key? key}) : super(key: key);

  @override
  _ChildVaccineProgrammeUpdatePageState createState() =>
      _ChildVaccineProgrammeUpdatePageState();
}

class _ChildVaccineProgrammeUpdatePageState
    extends State<ChildVaccineProgrammeUpdatePage> {
  TextEditingController childProgramEnController = TextEditingController();
  TextEditingController childProgramBoController = TextEditingController();
  TextEditingController yearController = TextEditingController();
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
      childProgramEnController.text =
          (Provider.of<AppProvider>(context, listen: false)
                  .selectedChildProgram
                  .programEn)
              .toString();
      childProgramBoController.text =
          (Provider.of<AppProvider>(context, listen: false)
                  .selectedChildProgram
                  .programBo)
              .toString();

      yearController.text = (Provider.of<AppProvider>(context, listen: false)
              .selectedChildProgram
              .year)
          .toString();
      isEditMode = Provider.of<AppProvider>(context, listen: false)
              .selectedChildProgram
              .id ==
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
      appBar: !isEditMode
          ? AppBar(
              backgroundColor: Theme.of(context).cardColor,
              foregroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              toolbarHeight: 48,
          leadingWidth: 80,
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
                                '${locale!.year}:',
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
                            keyboardType: TextInputType.number,
                            controller: yearController,
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
                                return '${locale.year} ${locale.cannotBeEmpty}';
                              } else if (int.tryParse(val) == null) {
                                return '${locale.year} ${locale.cannotBeEmpty}';
                              } else {
                                isError = false;
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: '${locale.year}',
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
                                '${locale.childVaccineProgramme}:',
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
                            controller: childProgramBoController,
                            maxLines: 8,
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
                                return '${locale.childVaccineProgramme} ${locale.cannotBeEmpty}';
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
                            controller: childProgramEnController,
                            maxLines: 8,
                            keyboardType: TextInputType.text,
                            /*
                            controller: childProgramEnController,*/
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
                                return '${locale.childVaccineProgramme} ${locale.cannotBeEmpty}';
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

                                    if (appProvider.selectedChildProgram.id ==
                                        'new') {
                                      isLoading = await HttpService
                                          .createChildVaccineProgramme(
                                          context,
                                          programBo:
                                          childProgramBoController.text,
                                          programEn:
                                          childProgramEnController.text,
                                          year: yearController.text);
                                    }else {
                                      isLoading = await HttpService
                                          .updateChildVaccineProgramme(
                                              context,
                                              appProvider
                                                  .selectedChildProgram.id,
                                              programBo:
                                                  childProgramBoController.text,
                                              programEn:
                                                  childProgramEnController.text,
                                              year: yearController.text);
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
                                '${locale.deleteAlert} ${appProvider.selectedChildProgram.year}',
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

                                      isLoading = await HttpService
                                          .deleteChildVaccineProgram(
                                              context,
                                              appProvider
                                                  .selectedChildProgram.id);
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
