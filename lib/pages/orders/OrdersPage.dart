import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/order_model.dart';
import 'package:vaksine_web/pages/orders/OrderUpdatePage.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/services/http_service.dart';
import 'package:vaksine_web/widget/OrdersTile.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  ScrollController pageScrollController = ScrollController();

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      isLoading = await HttpService.getOrders(context);
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
                phone: appProvider.selectedOrder.id != OrderModel().id
                    ? sidePanel(locale!, appProvider)
                    : Container(
                        child: Scrollbar(
                          interactive: true,
                          controller: pageScrollController,
                          child: SingleChildScrollView(
                            controller: pageScrollController,
                            child: Column(
                              children: [
                                for (OrderModel model in appProvider.orderList)
                                  OrdersTile(
                                      isSelected:
                                      appProvider.selectedOrder ==
                                          model,
                                      isSuccessful: model.success,
                                      onPress: () {
                                        if (Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .selectedOrder !=
                                            model) {
                                          Provider.of<AppProvider>(context,
                                                  listen: false)
                                              .selectedOrder = model;
                                        } else {
                                          Provider.of<AppProvider>(context,
                                                  listen: false)
                                              .selectedOrder = OrderModel();
                                        }
                                      },
                                      id: '${model.id}',
                                      orderDate: '${model.textRef}',
                                      status:
                                          '${model.success ? locale!.successfully : locale!.failed}')
                              ],
                            ),
                          ),
                        ),
                      ),
                tablet: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Scrollbar(
                          interactive: true,
                          controller: pageScrollController,
                          child: SingleChildScrollView(
                            controller: pageScrollController,
                            child: Column(
                              children: [
                                for (OrderModel model in appProvider.orderList)
                                  OrdersTile(
                                      isSelected:
                                      appProvider.selectedOrder ==
                                          model,
                                      isSuccessful: model.success,
                                      onPress: () {
                                        if (Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .selectedOrder !=
                                            model) {
                                          Provider.of<AppProvider>(context,
                                                  listen: false)
                                              .selectedOrder = model;
                                        } else {
                                          Provider.of<AppProvider>(context,
                                                  listen: false)
                                              .selectedOrder = OrderModel();
                                        }
                                      },
                                      id: '${model.id}',
                                      orderDate: '${model.textRef}',
                                      status:
                                          '${model.success ? locale!.successfully : locale!.failed}')
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: appProvider.selectedOrder.id != OrderModel().id
                            ? 304
                            : 0,
                        child: sidePanel(locale!, appProvider),
                      )
                    ],
                  ),
                ),
                desktop: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Scrollbar(
                          interactive: true,
                          controller: pageScrollController,
                          child: SingleChildScrollView(
                            controller: pageScrollController,
                            child: Column(
                              children: [
                                for (OrderModel model in appProvider.orderList)
                                  OrdersTile(
                                      isSelected:
                                      appProvider.selectedOrder ==
                                          model,
                                      isSuccessful: model.success,
                                      onPress: () {
                                        if (Provider.of<AppProvider>(context,
                                                    listen: false)
                                                .selectedOrder !=
                                            model) {
                                          Provider.of<AppProvider>(context,
                                                  listen: false)
                                              .selectedOrder = model;
                                        } else {
                                          Provider.of<AppProvider>(context,
                                                  listen: false)
                                              .selectedOrder = OrderModel();
                                        }
                                      },
                                      id: '${model.id}',
                                      orderDate: '${model.textRef}',
                                      status:
                                          '${model.success ? locale.successfully : locale.failed}')
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: appProvider.selectedOrder.id != OrderModel().id
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
    OrderModel order = appProvider.selectedOrder;
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        foregroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.close_rounded),
            onPressed: () {
              Future.delayed(Duration.zero, () async {
                await HttpService.getOrders(context);
              });
              setState(() {
                Provider.of<AppProvider>(context, listen: false).selectedOrder =
                    OrderModel();
              });
            }),
        title: Text(
          order.id,
          style: TextStyle(color: Colors.blueGrey, fontSize: 16),
        ),
      ),
        body: OrderUpdatePage(
          key: UniqueKey(),
        )
    );
  }
}
