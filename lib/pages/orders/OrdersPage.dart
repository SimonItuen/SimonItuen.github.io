import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/order_model.dart';
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
                phone: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (OrderModel model in appProvider.orderList)
                          OrdersTile(
                              onPress: () {},
                              id: '${model.id}',
                              orderDate:
                              '${model.textRef}',
                              status:
                              '${model.success ? locale!.successfully : locale!.failed}')
                      ],
                    ),
                  ),
                ),
                tablet:Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (OrderModel model in appProvider.orderList)
                          OrdersTile(
                              onPress: () {},
                              id: '${model.id}',
                              orderDate:
                              '${model.textRef}',
                              status:
                              '${model.success ? locale!.successfully : locale!.failed}')
                      ],
                    ),
                  ),
                ),
                desktop: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (OrderModel model in appProvider.orderList)
                          OrdersTile(
                              onPress: () {},
                              id: '${model.id}',
                              orderDate:
                                  '${model.textRef}',
                              status:
                                  '${model.success ? locale!.successfully : locale!.failed}')
                      ],
                    ),
                  ),
                )),
          ));
  }
}
