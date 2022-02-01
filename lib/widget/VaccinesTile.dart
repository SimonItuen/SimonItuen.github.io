import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';

class VaccinesTile extends StatelessWidget {
  final String id;
  final String name;
  final bool isSelected;
  final String category;
  final VoidCallback onPress;

  VaccinesTile(
      {Key? key, required this.name, required this.onPress,required this.id,required this.category, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: ResponsiveLayout(
          phone: Card(
            color: isSelected?Color(0xFF05A7E7):Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            shadowColor: Theme.of(context).primaryColor,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                  
                ],
              ),
            ),
          ),
          tablet: Card(
            color: isSelected?Color(0xFF05A7E7):Colors.white,
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
                      category,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 12),
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                  
                ],
              ),
            ),
          ),
          desktop: Card(
            color: isSelected?Color(0xFF05A7E7):Colors.white,
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
                    id+' . ',
                    style: TextStyle(
                        color: isSelected?Colors.white:Theme.of(context).primaryColor, fontSize: 16),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                          color: isSelected?Colors.white:Theme.of(context).primaryColor, fontSize: 16),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Text(
                      category,
                      style: TextStyle(
                          color: isSelected?Colors.white:Theme.of(context).primaryColor, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
