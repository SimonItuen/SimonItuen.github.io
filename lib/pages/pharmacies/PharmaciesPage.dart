import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/order_model.dart';
import 'package:vaksine_web/models/pharmacy_model.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';
import 'package:vaksine_web/widget/PharmaciesTile.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PharmaciesPage extends StatefulWidget {
  const PharmaciesPage({Key? key}) : super(key: key);

  @override
  _PharmaciesPageState createState() => _PharmaciesPageState();
}

class _PharmaciesPageState extends State<PharmaciesPage> {
  ScrollController pageScrollController = ScrollController();

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
     /* isLoading = await HttpService.getPharmacies(context);*/
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
                phone: Container(
                  child: Container(
                    child:  Scrollbar(
                      interactive:true,
                      controller: pageScrollController,
                      child: SingleChildScrollView(
                        controller: pageScrollController,
                        child: Column(
                          children: [
                            for (PharmacyModel model in appProvider.pharmacyList)
                              PharmaciesTile(
                                name: model.name,
                                onPress: () {},
                                address: model.address,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                tablet: Container(
                  child:  Scrollbar(
                    interactive:true,
                    controller: pageScrollController,
                    child: SingleChildScrollView(
                      controller: pageScrollController,
                      child: Column(
                        children: [
                          for (PharmacyModel model in appProvider.pharmacyList)
                            PharmaciesTile(
                              name: model.name,
                              onPress: () {},
                              address: model.address,)
                        ],
                      ),
                    ),
                  ),
                ),
                desktop: Container(
                  child:  Scrollbar(
                    interactive:true,
                    controller: pageScrollController,
                    child: SingleChildScrollView(
                      controller: pageScrollController,
                      child: Column(
                        children: [
                          for (PharmacyModel model in appProvider.pharmacyList)
                            PharmaciesTile(
                              name: model.name,
                              onPress: () {},
                              address: model.address,)
                        ],
                      ),
                    ),
                  ),
                )),
          ));
  }
}
