import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';

class DashboardTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onPress;

  DashboardTile(
      {Key? key,
      required this.icon,
      required this.title,
      required this.description,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        phone: Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          shadowColor: Theme.of(context).primaryColor,
          margin: EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon,color: Colors.blueGrey, size: 20,),
                    Padding(padding:EdgeInsets.symmetric(horizontal: 6)),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14 ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Expanded(
                  child: Text(
                    description,
                    style: TextStyle(color: Colors.blueGrey, fontSize: 20, fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
                  ),

                ),
                Spacer(),
              ],
            ),
          ),
        ),
        tablet: Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          shadowColor: Theme.of(context).primaryColor,
          margin: EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon,color: Colors.blueGrey, size: 20,),
                    Padding(padding:EdgeInsets.symmetric(horizontal: 6)),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14 ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Expanded(
                  child: Text(
                    description,
                    style: TextStyle(color: Colors.blueGrey, fontSize: 20, fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
                  ),

                ),
                Spacer(),
              ],
            ),
          ),
        ),
        desktop: Card(
          color: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadowColor: Theme.of(context).primaryColor,
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(icon,color: Colors.blueGrey, size: 28,),
                    Padding(padding:EdgeInsets.symmetric(horizontal: 6)),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16 ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Expanded(
                  child: Text(
                    description,
                    style: TextStyle(color: Colors.blueGrey, fontSize: 28, fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
                  ),
                  
                ),
                Spacer(),
              ],
            ),
          ),
        ));
  }
}
