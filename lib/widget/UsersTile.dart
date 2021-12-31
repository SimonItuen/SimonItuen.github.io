import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';

class UsersTile extends StatelessWidget {
  final IconData icon;
  final String name;
  final VoidCallback onPress;

  UsersTile(
      {Key? key,
      required this.icon,
      required this.name,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        phone: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          shadowColor: Theme.of(context).primaryColor,
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.account_circle_rounded,color: Colors.blueGrey, size: 24,),
                Padding(padding:EdgeInsets.symmetric(horizontal: 6)),
                Text(
                  name,
                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14 ),
                ),
                Spacer(),
                Icon(Icons.chat_rounded,color: Colors.blueGrey, size: 24,),
              ],
            ),
          ),
        ),
        tablet: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadowColor: Theme.of(context).primaryColor,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.account_circle_rounded,color: Colors.blueGrey, size: 24,),
                Padding(padding:EdgeInsets.symmetric(horizontal: 6)),
                Text(
                  name,
                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14 ),
                ),Padding(padding:EdgeInsets.symmetric(horizontal: 2)),
                Icon(icon,color: Colors.blueGrey.withOpacity(0.5), size: 24,),
                Spacer(),
                Icon(Icons.chat_rounded,color: Colors.blueGrey, size: 24,),
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
              children: [
                Icon(Icons.account_circle_rounded,color: Colors.blueGrey, size: 28,),
                Padding(padding:EdgeInsets.symmetric(horizontal: 6)),
                Text(
                  name,
                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16 ),
                ),Padding(padding:EdgeInsets.symmetric(horizontal: 2)),
                Icon(icon,color: Colors.blueGrey.withOpacity(0.5), size: 28,),
                Spacer(),
                Icon(Icons.chat_rounded,color: Colors.blueGrey, size: 28,),
              ],
            ),
          ),
        ));
  }
}
