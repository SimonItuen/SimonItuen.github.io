import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/child_vaccine_program_model.dart';
import 'package:vaksine_web/models/country_model.dart';
import 'package:vaksine_web/models/dashboard_model.dart';
import 'package:vaksine_web/models/disease_model.dart';
import 'package:vaksine_web/models/order_model.dart';
import 'package:vaksine_web/models/pharmacy_model.dart';
import 'package:vaksine_web/models/user_model.dart';
import 'package:vaksine_web/models/vaccine_model.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/util/session_manager_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart' show PlatformException;

class HttpService {
  static const String baseUrl = "https://whispering-beach-03875.herokuapp.com";

  static late HttpService _httpService;

  static Future<HttpService> getInstance() async {
    if (_httpService == null) {
      // keep local instance till it is fully initialized.
      _httpService = HttpService._();
      await SessionManagerUtil.getInstance();
    }
    ;
    return _httpService;
  }

  HttpService._();

  static Future<bool> getChildVaccineProgram(BuildContext context) async {
    String url = '$baseUrl/api/v1/child_vaccine_program';
    AppProvider _appProvider =
    Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        List<ChildVaccineProgramModel> childVaccineProgramList = [];
        for (Map<String, dynamic> i in jsonResponse['data']) {
          print(ChildVaccineProgramModel.fromJson(i).toMap());
          childVaccineProgramList.add(ChildVaccineProgramModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false)
            .childVaccineProgramList = childVaccineProgramList;
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          _showResponseSnackBar(
              context,
              jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(
              context, AppLocalizations.of(context)!.couldntInternetConnection);
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.somethingWentWrong}');
    }

    return false;
  }


  static Future<bool> getDashboard(BuildContext context) async {
    String url = '$baseUrl/api/v1/dashboard';
    AppProvider _appProvider =
    Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "Access-Control-Allow-Origin": "$baseUrl", // Required for CORS support to work
          "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT",
          HttpHeaders.authorizationHeader:
          'Bearer ${_appProvider.currentAdmin.accessToken}',
        },
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
    _appProvider.currentDashboard = DashboardModel.fromJson(jsonResponse['data']);


        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          _showResponseSnackBar(
              context,
              jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context)!.couldntInternetConnection}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.somethingWentWrong}');
    }

    return false;
  }
  
  static Future<bool> getUsers(BuildContext context) async {
    String url = '$baseUrl/api/v1/users';
    AppProvider _appProvider =
    Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "Access-Control-Allow-Origin": "$baseUrl", // Required for CORS support to work
          "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT",
          HttpHeaders.authorizationHeader:
          'Bearer ${_appProvider.currentAdmin.accessToken}',
        },
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        List<UserModel> userList = [];
        for (Map<String, dynamic> i in jsonResponse['data']) {
          print(UserModel.fromJson(i).toMap());
          userList.add(UserModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false).userList =
            userList;

        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          _showResponseSnackBar(
              context,
              jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context)!.couldntInternetConnection}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getVaccines(BuildContext context) async {
    String url = '$baseUrl/api/v1/vaccines';
    AppProvider _appProvider =
    Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        List<VaccineModel> vaccineList = [];
        for (Map<String, dynamic> i in jsonResponse['data']) {
          print(VaccineModel.fromJson(i).toMap());
          vaccineList.add(VaccineModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false).vaccineList =
            vaccineList;

        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          _showResponseSnackBar(
              context,
              jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context)!.couldntInternetConnection}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getPharmacies(BuildContext context) async {
    String url = '$baseUrl/api/v1/pharmacies';
    AppProvider _appProvider =
    Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        List<PharmacyModel> pharmacyList = [];
        for (Map<String, dynamic> i in jsonResponse['data']) {
          print(PharmacyModel.fromJson(i).toMap());
          pharmacyList.add(PharmacyModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false).pharmacyList =
            pharmacyList;

        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          _showResponseSnackBar(
              context,
              jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context)!.couldntInternetConnection}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getOrders(BuildContext context) async {
    String url = '$baseUrl/api/v1/orders';
    AppProvider _appProvider =
    Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        List<OrderModel> orderList = [];
        for (Map<String, dynamic> i in jsonResponse['data']) {
          print(OrderModel.fromJson(i).toMap());
          orderList.add(OrderModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false).orderList =
            orderList;

        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          _showResponseSnackBar(
              context,
              jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context)!.couldntInternetConnection}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getCountries(BuildContext context) async {
    String url = '$baseUrl/api/v1/countries';
    AppProvider _appProvider =
    Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        List<CountryModel> countryList = [];
        for (Map<String, dynamic> i in jsonResponse['data']) {
          print(CountryModel.fromJson(i).toMap());
          countryList.add(CountryModel.fromJson(i));
        }
        countryList.sort((CountryModel a, CountryModel b) =>
        Provider.of<AppProvider>(context, listen: false)
            .appLocale
            .languageCode ==
            'en'
            ? a.nameEn
            .toString()
            .toLowerCase()
            .compareTo(b.nameEn.toString().toLowerCase())
            : a.nameBo
            .toString()
            .toLowerCase()
            .compareTo(b.nameBo.toString().toLowerCase()));
        Provider.of<AppProvider>(context, listen: false).countryList =
            countryList;

        if (countryList.isNotEmpty) {
          Provider.of<AppProvider>(context, listen: false).selectedCountry =
              countryList.first;
        }
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          _showResponseSnackBar(
              context,
              jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context)!.couldntInternetConnection}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.somethingWentWrong}');
    }

    return false;
  }

  static Future<bool> getDiseases(BuildContext context) async {
    String url = '$baseUrl/api/v1/diseases';
    AppProvider _appProvider =
    Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: null,
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        List<DiseaseModel> diseaseList = [];
        for (Map<String, dynamic> i in jsonResponse['data']) {
          print(DiseaseModel.fromJson(i).toMap());
          diseaseList.add(DiseaseModel.fromJson(i));
        }

        Provider.of<AppProvider>(context, listen: false).diseaseList =
            diseaseList;
        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          _showResponseSnackBar(
              context,
              jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context)!.couldntInternetConnection}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.somethingWentWrong}');
    }

    return false;
  }
  

  static Future<bool> confirmVippsPayment(
      BuildContext context,
      {required String orderId}) async {
    String url = '$baseUrl/api/v1/vipps/confirm/$orderId';
    print(url);
    AppProvider _appProvider =
    Provider.of<AppProvider>(context, listen: false);

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
        'Bearer ${_appProvider.currentAdmin.accessToken}',
      });
      print(response.statusCode.toString());
      print(response.body.toString());

      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        if(jsonResponse['data']['transactionLogHistory'][0]['operation'].toString().contains('RESERVE')){
        }else{

        }

        /*UserModel model = UserModel.fromJson(jsonResponse);*/
        /*
        SessionManagerUtil.putString('username', model.username);
        SessionManagerUtil.putString('email', model.email);
        SessionManagerUtil.putString('token', model.token);
        SessionManagerUtil.putString('id', model.id);
        _navigateRoute(context, RegisterScreen.routeName);*/
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          _showResponseSnackBar(
              context,
              jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''));
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context)!.couldntInternetConnection}');
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noInternetConnection}');
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noConnectionWithServer}');
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.somethingWentWrong}');
    }

    return false;
  }

  static void _showResponseSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
        content: Text(
          '$message',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).cardColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Theme.of(context).primaryColor);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void _navigateRoute(BuildContext context, String route) {
    /**This Navigates push Replacement thus popping the current screen off the navigation stack*/
    Navigator.of(context).pushReplacementNamed(route);
  }


}
