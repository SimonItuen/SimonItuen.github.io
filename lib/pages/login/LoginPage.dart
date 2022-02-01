import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String routeName = '/manage/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isError = false;
  bool isObscurePassword = false;
  bool isButtonPressed = false;
  final formKey = GlobalKey<FormState>();
  int groupValue = 0;

  @override
  Widget build(BuildContext context) {
    AppLocalizations? locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 12),
              height: 36,
              width: 36,
              child: Image.asset(
                'assets/images/icon.png',
              ),
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: 'Vaks',
                style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
              ),
              TextSpan(
                text: 'i',
                style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF05A7E7)),
              ),
              TextSpan(
                text: 'ne',
                style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF5F5F5)),
              )
            ])),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton(
              value: groupValue,
              dropdownColor: Theme.of(context).primaryColor,
              underline: Container(),
              icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
              items: [
                DropdownMenuItem(
                    value: 0, child: Text('Bokmål (${locale!.norwegian})', style: TextStyle(color: Colors.white, fontSize: 12),)),
                DropdownMenuItem(value: 1, child: Text("English", style: TextStyle(color: Colors.white, fontSize: 12))),
              ],
              onChanged: (value) {
                if (value == 0) {
                  Provider.of<AppProvider>(context, listen: false).appLocale =
                      const Locale('nb', '');
                } else {
                  Provider.of<AppProvider>(context, listen: false).appLocale =
                      const Locale('en', '');
                }
                setState(() {
                  groupValue = value as int;
                });
              },
              /* onChanged: (int newValue){

              }*/
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
          : Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 400),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 24),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 4.0, bottom: 16),
                            child: Text(
                              locale.welcome,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24),
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
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
                                return '${locale.email} ${locale.cannotBeEmpty}';
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val)) {
                                return "Not a valid email";
                              } else {
                                isError = false;
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: '${locale.email}',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 1)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 1)),
                                prefixIcon: Icon(
                                  Icons.mail_rounded,
                                  color: Theme.of(context).primaryColor,
                                )),
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          TextFormField(
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.go,
                            onFieldSubmitted: (value)async{
                              isButtonPressed = true;
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                isLoading = await HttpService.login(context,
                                    email: emailController.text,
                                    password: passwordController.text);
                                setState(() {});
                              }
                            },
                            controller: passwordController,
                            obscureText: !isObscurePassword,
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
                                return '${locale.password} ${locale.cannotBeEmpty}';
                              }
                              isError = false;
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: '${locale.password}',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isObscurePassword = !isObscurePassword;
                                      });
                                    },
                                    child: !isObscurePassword
                                        ? Icon(
                                            Icons.visibility_off,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )
                                        : Icon(Icons.visibility,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 1)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 1)),
                                prefixIcon: Icon(
                                  Icons.lock_rounded,
                                  color: Theme.of(context).primaryColor,
                                )),
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          Padding(padding: EdgeInsets.all(8)),
                          InkWell(
                            onTap: () async {
                              isButtonPressed = true;
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                isLoading = await HttpService.login(context,
                                    email: emailController.text,
                                    password: passwordController.text);
                                setState(() {});
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              height: 48,
                              width: null,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  '${locale.login}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
