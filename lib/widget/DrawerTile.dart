import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';

class DrawerTile extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String title;
  final VoidCallback onPress;

  DrawerTile(
      {Key? key,
      required this.isSelected,
      required this.icon,
      required this.title,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        phone: Column(
          children: [
            ListTile(
              onTap: onPress,
              title: Text(
                title,
                style: TextStyle(
                    color: isSelected ? const Color(0xFF05A7E7) : Colors.white,
                    fontSize: 14),
              ),
              leading: Icon(
                icon,
                color: isSelected ? const Color(0xFF05A7E7) : Colors.white,
                size: 16,
              ),
            ),
            Divider(
              color: Colors.white.withOpacity(0.4),
            )
          ],
        ),
        tablet: InkWell(
          onTap:onPress,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    icon,
                    color: isSelected ? const Color(0xFF05A7E7) : Colors.white,
                    size: 22,
                  ),
                  Divider(
                    color: Colors.white.withOpacity(0.4),
                  )
                ],
              ),
            ),
          ),
        ),
        desktop: Column(
          children: [
            ListTile(
              onTap: onPress,
              title: Text(
                title,
                style: TextStyle(color: isSelected ? const Color(0xFF05A7E7) : Colors.white, fontSize: 14),
              ),
              leading: Icon(
                icon,
                color: isSelected ? const Color(0xFF05A7E7) : Colors.white,
                size: 20,
              ),
            ),
            Divider(
              color: Colors.white.withOpacity(0.4),
            )
          ],
        ));
  }
}
