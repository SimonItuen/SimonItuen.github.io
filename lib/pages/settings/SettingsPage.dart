import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/user_model.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';
import 'package:vaksine_web/widget/RadioButtonTile.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int groupValue = -1;
  bool isChangePassword = false;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  ScrollController pageScrollController = ScrollController();
  bool isLoading = false;
  bool isError = false;
  bool isObscureOldPassword = false;
  bool isObscureNewPassword = false;
  bool isObscureConfirmPassword = false;
  bool isButtonPressed = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      if (Provider
          .of<AppProvider>(context, listen: false)
          .appLocale
          .languageCode ==
          'en') {
        groupValue = 1;
      } else {
        groupValue = 0;
      }
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
        body: Scrollbar(
          interactive: true,
          controller: pageScrollController,
          child: SingleChildScrollView(
            controller: pageScrollController,
            child: Form(
              key: formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                        child: Text(locale!.selectLanguage,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3F3D56),
                                fontSize: 16)),
                      ),
                    ),
                    RadioButtonTile(
                        title: 'Bokmål (${locale.norwegian})',
                        value: 0,
                        onPressed: (index) {
                          Provider
                              .of<AppProvider>(context, listen: false)
                              .appLocale = const Locale('nb', '');
                          /*EasyDebounce.debounce('update-language', Duration(milliseconds: 1000),()async{
                          await HttpService.updateUserLanguage(context);
                        });*/
                          setState(() {
                            groupValue = 0;
                          });
                        },
                        groupValue: groupValue,
                        activeColor: const Color(0xFF3F3D56)),
                    RadioButtonTile(
                        title: 'English',
                        value: 1,
                        onPressed: (index) {
                          Provider
                              .of<AppProvider>(context, listen: false)
                              .appLocale = const Locale('en', '');
                          /*EasyDebounce.debounce('update-language', Duration(milliseconds: 1000),()async{
                          await HttpService.updateUserLanguage(context);
                        });*/
                          setState(() {
                            groupValue = 1;
                          });
                        },
                        groupValue: groupValue,
                        activeColor: const Color(0xFF3F3D56)),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isChangePassword = !isChangePassword;
                        });
                      },
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, bottom: 8, top: 8),
                          child: Text(locale.changePassword,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3F3D56),
                                  fontSize: 16)),
                        ),
                      ),
                    ),
                    if (isChangePassword)
                      Container(
                        margin: EdgeInsets.only(left: 16, right: 16),
                        constraints: BoxConstraints(maxWidth: 400),
                        child: Column(children: [
                          TextFormField(
                            style:
                            TextStyle(color: Colors.black, fontSize: 14),
                            keyboardType: TextInputType.visiblePassword,
                            controller: oldPasswordController,
                            obscureText: !isObscureOldPassword,
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
                                return '${locale.oldPassword} ${locale
                                    .cannotBeEmpty}';
                              }
                              isError = false;
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: '${locale.oldPassword}',
                                labelText: '${locale.oldPassword}',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isObscureOldPassword =
                                        !isObscureOldPassword;
                                      });
                                    },
                                    child: !isObscureOldPassword
                                        ? Icon(
                                      Icons.visibility_off,
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                    )
                                        : Icon(Icons.visibility,
                                        color: Theme
                                            .of(context)
                                            .primaryColor)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        width: 1)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        width: 1)),
                                prefixIcon: Icon(
                                  Icons.lock_rounded,
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                )),
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          TextFormField(
                            style:
                            TextStyle(color: Colors.black, fontSize: 14),
                            keyboardType: TextInputType.visiblePassword,
                            controller: newPasswordController,
                            obscureText: !isObscureNewPassword,
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
                                return '${locale.newPassword} ${locale
                                    .cannotBeEmpty}';
                              }
                              isError = false;
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: '${locale.newPassword}',
                                labelText: '${locale.newPassword}',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isObscureNewPassword =
                                        !isObscureNewPassword;
                                      });
                                    },
                                    child: !isObscureNewPassword
                                        ? Icon(
                                      Icons.visibility_off,
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                    )
                                        : Icon(Icons.visibility,
                                        color: Theme
                                            .of(context)
                                            .primaryColor)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        width: 1)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        width: 1)),
                                prefixIcon: Icon(
                                  Icons.lock_rounded,
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                )),
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          TextFormField(
                            style:
                            TextStyle(color: Colors.black, fontSize: 14),
                            keyboardType: TextInputType.visiblePassword,
                            controller: confirmPasswordController,
                            obscureText: !isObscureConfirmPassword,
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
                              if (val != newPasswordController.text) {
                                return '${locale.passwordDoesNotMatch}';
                              }
                              if (val!.isEmpty) {
                                return '${locale.confirmPassword} ${locale
                                    .cannotBeEmpty}';
                              }
                              isError = false;
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: '${locale.confirmPassword}',
                                labelText: '${locale.confirmPassword}',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isObscureConfirmPassword =
                                        !isObscureConfirmPassword;
                                      });
                                    },
                                    child: !isObscureConfirmPassword
                                        ? Icon(
                                      Icons.visibility_off,
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                    )
                                        : Icon(Icons.visibility,
                                        color: Theme
                                            .of(context)
                                            .primaryColor)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        width: 1)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        width: 1)),
                                prefixIcon: Icon(
                                  Icons.lock_rounded,
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                )),
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 12.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                isButtonPressed = true;
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  isLoading =
                                  await HttpService.changePassword(
                                    context,
                                    oldPassword: oldPasswordController.text,
                                    newPassword: newPasswordController.text,
                                  );

                                  oldPasswordController.clear();
                                  newPasswordController.clear();
                                  confirmPasswordController.clear();
                                  isChangePassword = false;
                                  setState(() {});
                                }
                              },
                              child: Text(locale.changePassword),
                            ),
                          )
                        ]),
                      ),
                  ]),
            ),
          ),
        ));
  }
}
