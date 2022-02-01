import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/user_model.dart';
import 'package:vaksine_web/pages/users/UserMessagePage.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';
import 'package:vaksine_web/widget/UsersTile.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  ScrollController pageScrollController = ScrollController();
  bool isLoading = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      isLoading = await HttpService.getUsers(context);
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
          color: Theme
              .of(context)
              .scaffoldBackgroundColor,
          child: ResponsiveLayout(
              phone: appProvider.selectedUser.id != UserModel().id
                  ? sidePanel(locale!, appProvider)
                  : Container(
                child: Scrollbar(
                  interactive: true,
                  controller: pageScrollController,
                  child: SingleChildScrollView(
                    controller: pageScrollController,
                    child: Column(
                      children: [
                        for (UserModel model in appProvider.userList)
                          UsersTile(
                              icon: model.genderString == 'm'
                                  ? Icons.male
                                  : Icons.female,
                              name:
                              '${model.givenName} ${model.surname} ',
                              onPress: () {
                                /*Future.delayed(Duration.zero, () async {
                                  await HttpService.getUsers(context);
                                });*/
                                if (Provider
                                    .of<AppProvider>(context,
                                    listen: false)
                                    .selectedUser !=
                                    model) {
                                  Provider
                                      .of<AppProvider>(context,
                                      listen: false)
                                      .selectedUser = UserModel();
                                  Provider
                                      .of<AppProvider>(context,
                                      listen: false)
                                      .selectedUser = model;
                                } else {
                                  Provider
                                      .of<AppProvider>(context,
                                      listen: false)
                                      .selectedUser = UserModel();
                                }
                              }, isSelected:
                          appProvider.selectedUser ==
                              model)
                      ],
                    ),
                  ),
                ),
              ),
              tablet: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Scrollbar(
                        interactive: true,
                        controller: pageScrollController,
                        child: SingleChildScrollView(
                          controller: pageScrollController,
                          child: Column(
                            children: [
                              for (UserModel model in appProvider.userList)
                                UsersTile(

                                    icon: model.genderString == 'm'
                                        ? Icons.male
                                        : Icons.female,
                                    name:
                                    '${model.givenName} ${model.surname} ',
                                    onPress: () {
                                      /*Future.delayed(Duration.zero, () async {
                                        await HttpService.getUsers(context);
                                      });*/
                                      if (Provider
                                          .of<AppProvider>(context,
                                          listen: false)
                                          .selectedUser !=
                                          model) {
                                        Provider
                                            .of<AppProvider>(context,
                                            listen: false)
                                            .selectedUser = UserModel();
                                        Provider
                                            .of<AppProvider>(context,
                                            listen: false)
                                            .selectedUser = model;
                                      } else {
                                        Provider
                                            .of<AppProvider>(context,
                                            listen: false)
                                            .selectedUser = UserModel();
                                      }
                                    }, isSelected:
                                appProvider.selectedUser ==
                                    model)
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: appProvider.selectedUser.id != UserModel().id
                          ? 304
                          : 0,
                      child: sidePanel(locale!, appProvider),
                    )
                  ],
                ),
              ),
              desktop: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Scrollbar(
                        interactive: true,
                        controller: pageScrollController,
                        child: SingleChildScrollView(
                          controller: pageScrollController,
                          child: Column(
                            children: [
                              for (UserModel model in appProvider.userList)
                                UsersTile(
                                  icon: model.genderString == 'm'
                                      ? Icons.male
                                      : Icons.female,
                                  name:
                                  '${model.givenName} ${model.surname}',
                                  onPress: () {
                                    /*Future.delayed(Duration.zero, () async {
                                      await HttpService.getUsers(context);
                                    });*/
                                    if (Provider
                                        .of<AppProvider>(context,
                                        listen: false)
                                        .selectedUser !=
                                        model) {
                                      Provider
                                          .of<AppProvider>(context,
                                          listen: false)
                                          .selectedUser = UserModel();
                                      Provider
                                          .of<AppProvider>(context,
                                          listen: false)
                                          .selectedUser = model;
                                    } else {
                                      Provider
                                          .of<AppProvider>(context,
                                          listen: false)
                                          .selectedUser = UserModel();
                                    }
                                  }, isSelected:
                                appProvider.selectedUser ==
                                    model,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: appProvider.selectedUser.id != UserModel().id
                          ? 304
                          : 0,
                      child: sidePanel(locale, appProvider),
                    )
                  ],
                ),
              )),
        ));
  }

  Widget sidePanel(AppLocalizations locale, AppProvider appProvider) {
    UserModel model = appProvider.selectedUser;
    return Scaffold(
        backgroundColor: Theme
            .of(context)
            .cardColor,
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .cardColor,
          foregroundColor: Theme
              .of(context)
              .primaryColor,
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.close_rounded),
              onPressed: () {
                Future.delayed(Duration.zero, () async {
                  await HttpService.getUsers(context);
                });
                setState(() {
                  Provider
                      .of<AppProvider>(context, listen: false)
                      .selectedUser = UserModel();
                });
              }),
          title: Text(
            '${model.givenName} ${model.surname}',
            style: TextStyle(color: Colors.blueGrey, fontSize: 16),
          ),
        ),
        body:  UserMessagePage(
          key: UniqueKey(),
        ));
  }
}
