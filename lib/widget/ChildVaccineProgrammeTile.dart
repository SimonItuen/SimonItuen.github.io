import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';

class ChildVaccineProgrammeTile extends StatelessWidget {
  final String year;
  final bool isSelected;
  final VoidCallback onPress;

  ChildVaccineProgrammeTile(
      {Key? key,
      required this.year,
      this.isSelected = false,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: ResponsiveLayout(
          phone: Container(
            width: MediaQuery.of(context).size.width / 4,
            height: ((MediaQuery.of(context).size.width / 4) * 1 / 2),
            child: Card(
              color: isSelected ? Color(0xFF05A7E7) : Colors.white,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              shadowColor: Theme.of(context).primaryColor,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6),
                child: Center(
                  child: Text(
                    year,
                    style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
          tablet: Container(
            width: MediaQuery.of(context).size.width / 7,
            height: ((MediaQuery.of(context).size.width / 7) * 1.2 / 2),
            child: Card(
              color: isSelected ? Color(0xFF05A7E7) : Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              shadowColor: Theme.of(context).primaryColor,
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6),
                child: Center(
                  child: Text(
                    year,
                    style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
          desktop: Container(
            width: MediaQuery.of(context).size.width / 8,
            height: ((MediaQuery.of(context).size.width / 8) * 1 / 2),
            child: Card(
              color: isSelected ? Color(0xFF05A7E7) : Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              shadowColor: Theme.of(context).primaryColor,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                child: Center(
                  child: Text(
                    year,
                    style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
