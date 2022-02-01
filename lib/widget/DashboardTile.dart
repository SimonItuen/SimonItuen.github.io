import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';

class DashboardTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onPress;
  final bool isSelected;

  DashboardTile(
      {Key? key,
      required this.icon,
      required this.title,
      required this.description,
      required this.onPress, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: ResponsiveLayout(
          phone: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: ((MediaQuery.of(context).size.width / 2))/1.5,
            child: Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                        Icon(icon,color: Theme.of(context).primaryColor, size: 16,),
                        Padding(padding:EdgeInsets.symmetric(horizontal: 6)),
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.w700 ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Expanded(
                      child: Text(
                        description,
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16, fontFamily: 'Comfortaa', fontWeight: FontWeight.w400),
                      ),

                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          tablet: Container(
            width: MediaQuery.of(context).size.width / 3.5,
            height: ((MediaQuery.of(context).size.width / 3.5)* 2)/3,
            child: Card(
              color: isSelected?Color(0xFF05A7E7):Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              shadowColor: Theme.of(context).primaryColor,
              margin: EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(icon,color: isSelected?Colors.white:Colors.blueGrey, size: 20,),
                        Padding(padding:EdgeInsets.symmetric(horizontal: 6)),
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(color: isSelected?Colors.white:Theme.of(context).primaryColor, fontSize: 12 ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          description,
                          style: TextStyle(color: isSelected?Colors.white:Colors.blueGrey, fontSize: 20, fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
                        ),
                      ),

                    ),
                  ],
                ),
              ),
            ),
          ),
          desktop: Container(
            width: MediaQuery.of(context).size.width / 4,
            height: (MediaQuery.of(context).size.width / 4)/2,
            child: Card(
              color: isSelected?Color(0xFF05A7E7):Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              shadowColor: Theme.of(context).primaryColor,
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(icon,color: isSelected?Colors.white:Colors.blueGrey, size: 28,),
                        Padding(padding:EdgeInsets.symmetric(horizontal: 6)),
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(color: isSelected?Colors.white:Theme.of(context).primaryColor, fontSize: 16 ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Expanded(
                      child: Text(
                        description,
                        style: TextStyle(color: isSelected?Colors.white:Colors.blueGrey, fontSize: 28, fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
                      ),

                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
