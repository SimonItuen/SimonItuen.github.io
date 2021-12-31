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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    AppLocalizations? locale = AppLocalizations.of(context);
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                  Provider.of<AppProvider>(context, listen: false).appLocale =
                  const Locale('nb', '');
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
                  Provider.of<AppProvider>(context, listen: false).appLocale =
                  const Locale('en', '');
                  /*EasyDebounce.debounce('update-language', Duration(milliseconds: 1000),()async{
                    await HttpService.updateUserLanguage(context);
                  });*/
                  setState(() {
                    groupValue = 1;
                  });
                },
                groupValue: groupValue,
                activeColor: const Color(0xFF3F3D56)),
          ],
        ));
  }
}
