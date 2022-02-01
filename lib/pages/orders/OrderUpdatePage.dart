import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/country_model.dart';
import 'package:vaksine_web/models/order_model.dart';
import 'package:vaksine_web/models/vaccine_model.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';
import 'package:vaksine_web/widget/AppTabIndicator.dart';
import 'package:vaksine_web/widget/ExpiryCountTile.dart';

class OrderUpdatePage extends StatefulWidget {
  const OrderUpdatePage({Key? key}) : super(key: key);

  @override
  _OrderUpdatePageState createState() => _OrderUpdatePageState();
}

class _OrderUpdatePageState extends State<OrderUpdatePage> {
  ScrollController pageScrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isEditMode = false;
  bool isDeleteMode = false;
  List<Widget> children = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: true);
    AppLocalizations? locale = AppLocalizations.of(context);
    OrderModel order = appProvider.selectedOrder;
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
              actions: [],
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
                              child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                        text: '${locale!.id}: ',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: '${order.id}',
                                        style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontSize: 14,
                                        ),
                                      )
                                    ]),
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                        text: '${locale.amount}: ',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: '${order.amount / 100}kr',
                                        style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontSize: 14,
                                        ),
                                      )
                                    ]),
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                        text: '${locale.phoneNumber}: ',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: '${order.customerPhone}',
                                        style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontSize: 14,
                                        ),
                                      )
                                    ]),
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                        text: '${locale.vaccines}:\n',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            '${order.vaccineIds.map((String e) => appProvider.appLocale.languageCode == 'en' ? appProvider.vaccineList.firstWhere((VaccineModel element) => e == element.vaccineId, orElse: () => VaccineModel()).nameEn : appProvider.vaccineList.firstWhere((VaccineModel element) => e == element.vaccineId, orElse: () => VaccineModel()).nameBo).toList().toString().replaceAll('[', '').replaceAll(']', '')}',
                                        style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontSize: 14,
                                        ),
                                      )
                                    ]),
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                        text: '${locale.date}: ',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            '${DateFormat.yMMMMd(appProvider.appLocale.languageCode).format(DateTime.parse(order.createdAt))}. (${DateFormat.jm(appProvider.appLocale.languageCode).format(DateTime.parse(order.createdAt))})',
                                        style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontSize: 14,
                                        ),
                                      )
                                    ]),
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
                                '${locale.deleteAlert} ${appProvider.selectedOrder.id}',
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

                                      isLoading = await HttpService.deleteOrder(
                                          context,
                                          appProvider.selectedOrder.id);
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
