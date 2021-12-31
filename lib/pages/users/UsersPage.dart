import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/user_model.dart';
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
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
     isLoading= await HttpService.getUsers(context);
     setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    AppLocalizations? locale = AppLocalizations.of(context);
    return isLoading?Scaffold(body: Center(child: CircularProgressIndicator())):Scaffold(
        body: Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ResponsiveLayout(
          phone: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for(UserModel model in appProvider.userList)
                    UsersTile(icon: model.genderString=='m'?Icons.male:Icons.female, name: '${model.givenName} ${model.surname} ', onPress: (){})

                ],
              ),
            ),
          ),
          tablet: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for(UserModel model in appProvider.userList)
                    UsersTile(icon: model.genderString=='m'?Icons.male:Icons.female, name: '${model.givenName} ${model.surname} ', onPress: (){})

                ],
              ),
            ),
          ),
          desktop: Container(
            child: SingleChildScrollView(
              child: Column(
              children: [
                for(UserModel model in appProvider.userList)
                  UsersTile(icon: model.genderString=='m'?Icons.male:Icons.female, name: '${model.givenName} ${model.surname} ', onPress: (){})

              ],
              ),
            ),
          )),
    ));
  }
}
