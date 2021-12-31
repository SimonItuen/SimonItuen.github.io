import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';

class PharmaciesTile extends StatelessWidget {
  final String name;
  final String address;
  final VoidCallback onPress;

  PharmaciesTile(
      {Key? key, required this.name, required this.onPress,required this.address})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        phone: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadowColor: Theme.of(context).primaryColor,
          margin: EdgeInsets.symmetric(horizontal: 19, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 12),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                Expanded(
                  child: Text(
                    address,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 12),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                Icon(
                  Icons.open_in_new_rounded,
                  color: Colors.blueGrey,
                  size: 14,
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
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 14),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                Expanded(
                  child: Text(
                    address,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 14),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                Icon(
                  Icons.open_in_new_rounded,
                  color: Colors.blueGrey,
                  size: 14,
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
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                Expanded(
                  child: Text(
                    address,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 14),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                Icon(
                  Icons.expand,
                  color: Colors.blueGrey,
                  size: 28,
                ),
              ],
            ),
          ),
        ));
  }
}
