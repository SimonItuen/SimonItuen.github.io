import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/country_model.dart';
import 'package:vaksine_web/models/user_model.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';
import 'package:vaksine_web/widget/AppTabIndicator.dart';
import 'package:vaksine_web/widget/ExpiryCountTile.dart';
import 'package:vaksine_web/widget/FemaleQuestionTile.dart';
import 'package:vaksine_web/widget/MaleQuestionTile.dart';

class UserMessagePage extends StatefulWidget {
  const UserMessagePage({Key? key}) : super(key: key);

  @override
  _UserMessagePageState createState() => _UserMessagePageState();
}

class _UserMessagePageState extends State<UserMessagePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
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
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    UserModel model = appProvider.selectedUser;
    AppLocalizations? locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      /*appBar: (!isEditMode && !isDeleteMode)
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
          : null,*/
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Scrollbar(
                  interactive: true,
                  controller: pageScrollController,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '${locale!.notify} ${model.givenName} ${model.surname}:',
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
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                            keyboardType: TextInputType.text,
                            controller: titleController,
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
                                return '${locale.title} ${locale.cannotBeEmpty}';
                              } else {
                                isError = false;
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: '${locale.title} (${model.language == 'en'
                                  ? "English"
                                  : "Bokmål"})',
                              labelText: '${locale.title} (${model.language == 'en'
                                  ? "English"
                                  : "Bokmål"})',
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
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                            controller: descriptionController,
                            maxLines: 5,
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
                                return '${locale.messageBody} ${locale.cannotBeEmpty}';
                              } else {
                                isError = false;
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: '${locale.messageBody} (${model.language == 'en'
                                  ? "English"
                                  : "Bokmål"})',
                              labelText: '${locale.messageBody} (${model.language ==
                                  'en' ? "English" : "Bokmål"})',
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
                            padding:
                            const EdgeInsets.symmetric(vertical: 32.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                isButtonPressed = true;
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });


                                  isLoading =
                                  await HttpService.sendUserMessage(
                                      context,
                                      model.id,
                                      title: titleController.text,
                                      body: descriptionController.text
                                  );

                                  setState(() {});
                                }
                              },
                              child: Text(locale.send),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                /*Visibility(
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
                                          await HttpService.deleteUser(
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
                    ))),*/
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
