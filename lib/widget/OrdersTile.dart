import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';

class OrdersTile extends StatelessWidget {
  final String id;
  final String orderDate;
  final String status;
  final VoidCallback onPress;

  OrdersTile(
      {Key? key, required this.orderDate, required this.onPress,required this.id,required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        phone: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadowColor: Theme.of(context).primaryColor,
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  id,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.w500),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 6)),
                Expanded(
                  child: Text(
                    status,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 12),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                Icon(
                  Icons.open_in_new_rounded,
                  color: Colors.blueGrey,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        tablet: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadowColor: Theme.of(context).primaryColor,
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  id,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                Expanded(
                  child: Text(
                    status,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 14),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                Icon(
                  Icons.open_in_new_rounded,
                  color: Colors.blueGrey,
                  size: 26,
                ),
              ],
            ),
          ),
        ),
        desktop: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadowColor: Theme.of(context).primaryColor,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  id,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                Expanded(
                  child: Text(
                    orderDate,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                Expanded(
                  child: Text(
                    status,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 14),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                Icon(
                  Icons.open_in_new_rounded,
                  color: Colors.blueGrey,
                  size: 28,
                ),
              ],
            ),
          ),
        ));
  }
}
