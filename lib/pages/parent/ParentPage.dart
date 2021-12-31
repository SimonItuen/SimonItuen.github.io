import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_scraper/web_scraper.dart';

class ParentPage extends StatefulWidget {
  @override
  _ParentPageState createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool visibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 500) {
            return Row(
              children: [
                Expanded(
                  child: SvgPicture.asset(kIsWeb
                      ? 'images/Parent_picture.svg'
                      : 'assets/images/Parent_picture.svg'),
                ),
                Expanded(
                  child: Card(
                    child: Column(
                      children: [
                        Text(
                          'Welcome a bo',
                          style:
                              TextStyle(fontFamily: 'Comfortaa', fontSize: 45),
                        ),
                        TextFormField(
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Email cannot be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Email Address',
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 14),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 1)),
                              fillColor: Colors.black.withOpacity(0.3),
                              prefixIcon: Icon(
                                Icons.mail_rounded,
                                color: Colors.white.withOpacity(0.6),
                              )),
                        ),
                        Padding(padding: EdgeInsets.all(8)),
                        TextFormField(
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          obscureText: !visibility,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Password cannot be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      visibility = !visibility;
                                    });
                                  },
                                  child: !visibility
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: Colors.white,
                                        )
                                      : Icon(Icons.visibility,
                                          color: Colors.white)),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 1)),
                              fillColor: Colors.black.withOpacity(0.3),
                              prefixIcon: Icon(
                                Icons.lock_rounded,
                                color: Colors.white.withOpacity(0.6),
                              )),
                        ),
                        RaisedButton(onPressed: () async {
                          final webScraper = WebScraper('https://webscraper.io');
                          if (await webScraper.loadWebPage('/test-sites/e-commerce/allinone')) {
                            List<Map<String, dynamic>> elements = webScraper.getElement('h3.title > a.caption', ['href']);
                            print(elements);
                          }
                        })
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
            return Column(
              children: [
                TextFormField(
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Email cannot be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Email Address',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1)),
                      fillColor: Colors.black.withOpacity(0.3),
                      prefixIcon: Icon(
                        Icons.mail_rounded,
                        color: Colors.white.withOpacity(0.6),
                      )),
                ),
                Padding(padding: EdgeInsets.all(8)),
                TextFormField(
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  obscureText: !visibility,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              visibility = !visibility;
                            });
                          },
                          child: !visibility
                              ? Icon(
                                  Icons.visibility_off,
                                  color: Colors.white,
                                )
                              : Icon(Icons.visibility, color: Colors.white)),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1)),
                      fillColor: Colors.black.withOpacity(0.3),
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: Colors.white.withOpacity(0.6),
                      )),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
