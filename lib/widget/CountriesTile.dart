import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';

class CountriesTile extends StatelessWidget {
  final String name;
  final String code;
  final bool isSelected;
  final VoidCallback onPress;

  CountriesTile(
      {Key? key,
      required this.name,
      required this.code,
      this.isSelected = false,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: ResponsiveLayout(
          phone: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: ((MediaQuery.of(context).size.width / 3) * 9 / 10),
            child: Card(
              color: isSelected ? Color(0xFF05A7E7) : Colors.white,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              shadowColor: Theme.of(context).primaryColor,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4.0, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(8)),
                            child: Image.asset(
                              'assets/images/flags/${code.toLowerCase()}.png',
                              fit: BoxFit.fill,
                              height: 50,
                              width: 30,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: Text(
                                code.toUpperCase(),
                                style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Theme.of(context).primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Text(
                        name,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          tablet: Container(
            width: MediaQuery.of(context).size.width / 6,
            height: ((MediaQuery.of(context).size.width / 6) * 2 / 3),
            child: Card(
              color: isSelected ? Color(0xFF05A7E7) : Colors.white,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              shadowColor: Theme.of(context).primaryColor,
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4.0, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(8)),
                            child: Image.asset(
                              'assets/images/flags/${code.toLowerCase()}.png',
                              fit: BoxFit.fill,
                              height: 50,
                              width: 30,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: Text(
                                code.toUpperCase(),
                                style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Text(
                        name,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          desktop: Container(
            width: MediaQuery.of(context).size.width / 7,
            height: ((MediaQuery.of(context).size.width / 7) * 2 / 3),
            child: Card(
              color: isSelected ? Color(0xFF05A7E7) : Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              shadowColor: Theme.of(context).primaryColor,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4.0, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(8)),
                            child: Image.asset(
                              'assets/images/flags/${code.toLowerCase()}.png',
                              fit: BoxFit.fill,
                              height: 50,
                              width: 30,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: Text(
                                code.toUpperCase(),
                                style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Text(
                        name,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
