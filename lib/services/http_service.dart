import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:vaksine_web/models/admin_model.dart';
import 'package:vaksine_web/models/child_vaccine_program_model.dart';
import 'package:vaksine_web/models/country_model.dart';
import 'package:vaksine_web/models/dashboard_model.dart';
import 'package:vaksine_web/models/disease_model.dart';
import 'package:vaksine_web/models/order_model.dart';
import 'package:vaksine_web/models/pharmacy_model.dart';
import 'package:vaksine_web/models/user_model.dart';
import 'package:vaksine_web/models/vaccine_model.dart';
import 'package:vaksine_web/pages/parent/ParentPage.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/util/session_manager_util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart' show PlatformException;

class HttpService {
  static const String baseUrl = "https://vaksineapp.herokuapp.com";

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
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
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
          childVaccineProgramList.add(ChildVaccineProgramModel.fromJson(i));
        }

        childVaccineProgramList.sort(
            (ChildVaccineProgramModel a, ChildVaccineProgramModel b) =>
                int.parse(a.year).compareTo(int.parse(b.year)));
        Provider.of<AppProvider>(context, listen: false)
            .childVaccineProgramList = childVaccineProgramList;
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

  static Future<bool> login(BuildContext context,
      {required String email, required String password}) async {
    String url = '$baseUrl/api/v1/admin/login';
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    final msg = convert.jsonEncode({'email': email, 'password': password});

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: msg);
      print(response.statusCode.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        AdminModel admin = AdminModel.fromJson(jsonResponse['data']);
        admin.accessToken = jsonResponse['access_token'];
        Provider.of<AppProvider>(context, listen: false).currentAdmin = admin;
        Navigator.of(context).pushNamedAndRemoveUntil(
            ParentPage.routeName, ModalRoute.withName('/'));
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
                  .replaceAll(']', ''),
              invertColor: true);
        } else {
          _showResponseSnackBar(context,
              '${AppLocalizations.of(context)!.couldntInternetConnection}',
              invertColor: true);
        }
      }
    } on TimeoutException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noInternetConnection}',
          invertColor: true);
    } on SocketException catch (e) {
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.noConnectionWithServer}',
          invertColor: true);
    } on Error catch (e) {
      print(e);
      _showResponseSnackBar(
          context, '${AppLocalizations.of(context)!.somethingWentWrong}',
          invertColor: true);
    }

    return false;
  }

  static Future<bool> getDashboard(BuildContext context) async {
    String url = '$baseUrl/api/v1/dashboard';
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "Access-Control-Allow-Origin": "$baseUrl",
          // Required for CORS support to work
          "Access-Control-Allow-Credentials": "true",
          // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT",
          HttpHeaders.authorizationHeader:
              'Bearer ${_appProvider.currentAdmin.accessToken}',
        },
      );
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        _appProvider.currentDashboard =
            DashboardModel.fromJson(jsonResponse['data']);
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
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "Access-Control-Allow-Origin": "$baseUrl",
          // Required for CORS support to work
          "Access-Control-Allow-Credentials": "true",
          // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
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

        Provider.of<AppProvider>(context, listen: false).userList = userList;
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
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
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
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    print(url);
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "Access-Control-Allow-Origin": "$baseUrl",
          // Required for CORS support to work
          "Access-Control-Allow-Credentials": "true",
          // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT",
          HttpHeaders.authorizationHeader:
              'Bearer ${_appProvider.currentAdmin.accessToken}',
        },
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

        Provider.of<AppProvider>(context, listen: false).orderList = orderList;
        await getVaccines(context);
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
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
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
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
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

  static Future<bool> updateConsultationFee(
      BuildContext context, String id, String amount) async {
    String url = '$baseUrl/api/v1/price/$id';
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    final msg = convert.jsonEncode({'amount': amount});
    print(msg);
    try {
      http.Response response = await http.put(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "Access-Control-Allow-Origin": "$baseUrl",
            // Required for CORS support to work
            "Access-Control-Allow-Credentials": "true",
            // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
            HttpHeaders.authorizationHeader:
                'Bearer ${_appProvider.currentAdmin.accessToken}',
          },
          body: msg);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        await getDashboard(context);
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {}
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

  static Future<bool> updateOther(BuildContext context, String id,
      {required String descriptionBo, required String descriptionEn}) async {
    String url = '$baseUrl/api/v1/other/$id';
    print(url);
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    final msg = convert.jsonEncode({
      'description_bo': descriptionBo,
      'description_en': descriptionEn,
    });
    print(msg);
    try {
      http.Response response = await http.put(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "Access-Control-Allow-Origin": "$baseUrl",
            // Required for CORS support to work
            "Access-Control-Allow-Credentials": "true",
            // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
            HttpHeaders.authorizationHeader:
                'Bearer ${_appProvider.currentAdmin.accessToken}',
          },
          body: msg);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        await getDashboard(context);
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {}
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

  static Future<bool> sendUserMessage(BuildContext context, String id,
      {required String title, required String body}) async {
    String url = '$baseUrl/api/v1/user/message';
    print(url);
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    final msg = convert.jsonEncode({
      "title": title,
      "body": body,
      "user_id": id,
    });
    print(msg);
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "Access-Control-Allow-Origin": "$baseUrl",
            // Required for CORS support to work
            "Access-Control-Allow-Credentials": "true",
            // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
            HttpHeaders.authorizationHeader:
                'Bearer ${_appProvider.currentAdmin.accessToken}',
          },
          body: msg);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        var jsonResponse = convert.jsonDecode(response.body);
        await getUsers(context);
        Provider.of<AppProvider>(context, listen: false).selectedUser =
            UserModel();
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

  static Future<bool> changePassword(BuildContext context,
      {required String oldPassword, required String newPassword}) async {
    String url = '$baseUrl/api/v1/admin/password';
    print(url);
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    final msg = convert.jsonEncode({
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    });
    print(msg);
    try {
      http.Response response = await http.put(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "Access-Control-Allow-Origin": "$baseUrl",
            // Required for CORS support to work
            "Access-Control-Allow-Credentials": "true",
            // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
            HttpHeaders.authorizationHeader:
                'Bearer ${_appProvider.currentAdmin.accessToken}',
          },
          body: msg);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        var jsonResponse = convert.jsonDecode(response.body);
        await getDiseases(context);
        Provider.of<AppProvider>(context, listen: false).selectedDisease =
            DiseaseModel();
        _showResponseSnackBar(
            context,
            jsonResponse['message']
                .toString()
                .replaceAll('{', '')
                .replaceAll('}', '')
                .replaceAll('[', '')
                .replaceAll(']', ''));
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

  static Future<bool> createCountry(BuildContext context,
      {required String nameBo,
      required String nameEn,
      required String malPrevBo,
      required String malPrevEn,
      required String shortTrip,
      required String longTrip,
      required String code}) async {
    String url = '$baseUrl/api/v1/country/new';
    print(url);
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    final msg = convert.jsonEncode({
      "name_en": nameEn,
      "code": code,
      "short_trip": shortTrip,
      "long_trip": longTrip,
      "name_bo": nameBo,
      "mal_prev_en": malPrevEn,
      "mal_prev_bo": malPrevBo
    });
    print(msg);
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "Access-Control-Allow-Origin": "$baseUrl",
            // Required for CORS support to work
            "Access-Control-Allow-Credentials": "true",
            // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
            HttpHeaders.authorizationHeader:
                'Bearer ${_appProvider.currentAdmin.accessToken}',
          },
          body: msg);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        var jsonResponse = convert.jsonDecode(response.body);
        await getCountries(context);
        Provider.of<AppProvider>(context, listen: false).selectedCountry =
            CountryModel();
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

  static Future<bool> updateCountry(BuildContext context, String id,
      {required String nameBo,
      required String nameEn,
      required String malPrevBo,
      required String malPrevEn,
      required String shortTrip,
      required String longTrip,
      required String code}) async {
    String url = '$baseUrl/api/v1/country/$id';
    print(url);
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    final msg = convert.jsonEncode({
      "name_en": nameEn,
      "code": code,
      "short_trip": shortTrip,
      "long_trip": longTrip,
      "name_bo": nameBo,
      "mal_prev_en": malPrevEn,
      "mal_prev_bo": malPrevBo
    });
    print(msg);
    try {
      http.Response response = await http.put(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "Access-Control-Allow-Origin": "$baseUrl",
            // Required for CORS support to work
            "Access-Control-Allow-Credentials": "true",
            // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
            HttpHeaders.authorizationHeader:
                'Bearer ${_appProvider.currentAdmin.accessToken}',
          },
          body: msg);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        var jsonResponse = convert.jsonDecode(response.body);
        await getCountries(context);
        Provider.of<AppProvider>(context, listen: false).selectedCountry =
            CountryModel();
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

  static Future<bool> deleteCountry(BuildContext context, String id) async {
    String url = '$baseUrl/api/v1/country/$id';
    print(url);
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    try {
      http.Response response = await http.delete(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Access-Control-Allow-Origin": "$baseUrl",
        // Required for CORS support to work
        "Access-Control-Allow-Credentials": "true",
        // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
        HttpHeaders.authorizationHeader:
            'Bearer ${_appProvider.currentAdmin.accessToken}',
      });
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        var jsonResponse = convert.jsonDecode(response.body);
        await getCountries(context);
        Provider.of<AppProvider>(context, listen: false).selectedCountry =
            CountryModel();
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

  static Future<bool> createChildVaccineProgramme(BuildContext context,
      {required String programBo,
      required String programEn,
      required String year}) async {
    String url = '$baseUrl/api/v1/child_vaccine_program/new';
    print(url);
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    final msg = convert.jsonEncode({
      "year": int.parse(year),
      "program_bo": programBo,
      "program_en": programEn
    });
    print(msg);
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "Access-Control-Allow-Origin": "$baseUrl",
            // Required for CORS support to work
            "Access-Control-Allow-Credentials": "true",
            // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
            HttpHeaders.authorizationHeader:
                'Bearer ${_appProvider.currentAdmin.accessToken}',
          },
          body: msg);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        var jsonResponse = convert.jsonDecode(response.body);
        await getChildVaccineProgram(context);
        Provider.of<AppProvider>(context, listen: false).selectedChildProgram =
            ChildVaccineProgramModel();
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

  static Future<bool> updateChildVaccineProgramme(
      BuildContext context, String id,
      {required String programBo,
      required String programEn,
      required String year}) async {
    String url = '$baseUrl/api/v1/child_vaccine_program/$id';
    print(url);
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    final msg = convert.jsonEncode({
      "year": int.parse(year),
      "program_bo": programBo,
      "program_en": programEn
    });
    print(msg);
    try {
      http.Response response = await http.put(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "Access-Control-Allow-Origin": "$baseUrl",
            // Required for CORS support to work
            "Access-Control-Allow-Credentials": "true",
            // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
            HttpHeaders.authorizationHeader:
                'Bearer ${_appProvider.currentAdmin.accessToken}',
          },
          body: msg);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        var jsonResponse = convert.jsonDecode(response.body);
        await getChildVaccineProgram(context);
        Provider.of<AppProvider>(context, listen: false).selectedChildProgram =
            ChildVaccineProgramModel();
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

  static Future<bool> deleteChildVaccineProgram(
      BuildContext context, String id) async {
    String url = '$baseUrl/api/v1/child_vaccine_program/$id';
    print(url);
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    try {
      http.Response response = await http.delete(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Access-Control-Allow-Origin": "$baseUrl",
        // Required for CORS support to work
        "Access-Control-Allow-Credentials": "true",
        // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
        HttpHeaders.authorizationHeader:
            'Bearer ${_appProvider.currentAdmin.accessToken}',
      });
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        var jsonResponse = convert.jsonDecode(response.body);
        await getChildVaccineProgram(context);
        Provider.of<AppProvider>(context, listen: false).selectedChildProgram =
            ChildVaccineProgramModel();
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

  static Future<bool> createDisease(BuildContext context,
      {required String nameBo,
      required String nameEn,
      required String vaccineId,
      required String key,
      required List<String> countRule}) async {
    String url = '$baseUrl/api/v1/disease/new';
    print(url);
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    final msg = convert.jsonEncode({
      "key": key,
      "name_en": nameEn,
      "name_bo": nameBo,
      "vaccine_id": vaccineId,
      "count_rule": countRule.toList(),
    });
    print(msg);
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "Access-Control-Allow-Origin": "$baseUrl",
            // Required for CORS support to work
            "Access-Control-Allow-Credentials": "true",
            // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
            HttpHeaders.authorizationHeader:
                'Bearer ${_appProvider.currentAdmin.accessToken}',
          },
          body: msg);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        var jsonResponse = convert.jsonDecode(response.body);
        await getDiseases(context);
        Provider.of<AppProvider>(context, listen: false).selectedDisease =
            DiseaseModel();
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

  static Future<bool> updateDisease(BuildContext context, String id,
      {required String nameBo,
      required String nameEn,
      required String vaccineId,
      required String key,
      required List<String> countRule}) async {
    String url = '$baseUrl/api/v1/disease/$id';
    print(url);
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    final msg = convert.jsonEncode({
      "key": key,
      "name_en": nameEn,
      "name_bo": nameBo,
      "vaccine_id": vaccineId,
      "count_rule": countRule.toList(),
    });
    print(msg);
    try {
      http.Response response = await http.put(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "Access-Control-Allow-Origin": "$baseUrl",
            // Required for CORS support to work
            "Access-Control-Allow-Credentials": "true",
            // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
            HttpHeaders.authorizationHeader:
                'Bearer ${_appProvider.currentAdmin.accessToken}',
          },
          body: msg);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        var jsonResponse = convert.jsonDecode(response.body);
        await getDiseases(context);
        Provider.of<AppProvider>(context, listen: false).selectedDisease =
            DiseaseModel();
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

  static Future<bool> deleteDisease(BuildContext context, String id) async {
    String url = '$baseUrl/api/v1/disease/$id';
    print(url);
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    try {
      http.Response response = await http.delete(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Access-Control-Allow-Origin": "$baseUrl",
        // Required for CORS support to work
        "Access-Control-Allow-Credentials": "true",
        // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
        HttpHeaders.authorizationHeader:
            'Bearer ${_appProvider.currentAdmin.accessToken}',
      });
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        var jsonResponse = convert.jsonDecode(response.body);
        await getDiseases(context);
        Provider.of<AppProvider>(context, listen: false).selectedDisease =
            DiseaseModel();
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

  static Future<bool> createVaccine(
    BuildContext context, {
    required String nameBo,
    required String nameEn,
    required String categoryBo,
    required String categoryEn,
    required String vaccineId,
    required List<String> vaccineQuestionsMaleEn,
    required List<String> vaccineQuestionsMaleBo,
    required List<String> vaccineQuestionsFemaleEn,
    required List<String> vaccineQuestionsFemaleBo,
  }) async {
    String url = '$baseUrl/api/v1/vaccine/new';
    print(url);
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    final msg = convert.jsonEncode({
      "name_en": nameEn,
      "name_bo": nameBo,
      "vaccine_id": vaccineId,
      "category_name_en": categoryEn,
      "category_name_bo": categoryBo,
      "vaccine_questions_male_en": vaccineQuestionsMaleEn,
      "vaccine_questions_male_bo": vaccineQuestionsMaleBo,
      "vaccine_questions_female_en": vaccineQuestionsFemaleEn,
      "vaccine_questions_female_bo": vaccineQuestionsFemaleBo,
    });
    print(msg);
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "Access-Control-Allow-Origin": "$baseUrl",
            // Required for CORS support to work
            "Access-Control-Allow-Credentials": "true",
            // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
            HttpHeaders.authorizationHeader:
                'Bearer ${_appProvider.currentAdmin.accessToken}',
          },
          body: msg);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        var jsonResponse = convert.jsonDecode(response.body);
        await getVaccines(context);
        Provider.of<AppProvider>(context, listen: false).selectedVaccine =
            VaccineModel();
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

  static Future<bool> updateVaccine(BuildContext context, String id,
      {required String nameBo,
      required String nameEn,
      required String categoryBo,
      required String categoryEn,
      required String vaccineId,
      required List<String> vaccineQuestionsMaleEn,
      required List<String> vaccineQuestionsMaleBo,
      required List<String> vaccineQuestionsFemaleEn,
      required List<String> vaccineQuestionsFemaleBo}) async {
    String url = '$baseUrl/api/v1/vaccine/$id';
    print(url);
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    final msg = convert.jsonEncode({
      "name_en": nameEn,
      "name_bo": nameBo,
      "vaccine_id": vaccineId,
      "category_name_en": categoryEn,
      "category_name_bo": categoryBo,
      "vaccine_questions_male_en": vaccineQuestionsMaleEn,
      "vaccine_questions_male_bo": vaccineQuestionsMaleBo,
      "vaccine_questions_female_en": vaccineQuestionsFemaleEn,
      "vaccine_questions_female_bo": vaccineQuestionsFemaleBo,
    });
    print(msg);
    try {
      http.Response response = await http.put(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "Access-Control-Allow-Origin": "$baseUrl",
            // Required for CORS support to work
            "Access-Control-Allow-Credentials": "true",
            // Required for cookies, authorization headers with HTTPS
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
            HttpHeaders.authorizationHeader:
                'Bearer ${_appProvider.currentAdmin.accessToken}',
          },
          body: msg);
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        var jsonResponse = convert.jsonDecode(response.body);
        await getVaccines(context);
        Provider.of<AppProvider>(context, listen: false).selectedVaccine =
            VaccineModel();
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

  static Future<bool> deleteVaccine(BuildContext context, String id) async {
    String url = '$baseUrl/api/v1/vaccine/$id';
    print(url);
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    try {
      http.Response response = await http.delete(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Access-Control-Allow-Origin": "$baseUrl",
        // Required for CORS support to work
        "Access-Control-Allow-Credentials": "true",
        // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
        HttpHeaders.authorizationHeader:
            'Bearer ${_appProvider.currentAdmin.accessToken}',
      });
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        var jsonResponse = convert.jsonDecode(response.body);
        await getVaccines(context);
        Provider.of<AppProvider>(context, listen: false).selectedVaccine =
            VaccineModel();
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

  static Future<bool> deleteOrder(BuildContext context, String id) async {
    String url = '$baseUrl/api/v1/order/$id';
    print(url);
    AppProvider _appProvider = Provider.of<AppProvider>(context, listen: false);
    try {
      http.Response response = await http.delete(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Access-Control-Allow-Origin": "$baseUrl",
        // Required for CORS support to work
        "Access-Control-Allow-Credentials": "true",
        // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT, DELETE",
        HttpHeaders.authorizationHeader:
        'Bearer ${_appProvider.currentAdmin.accessToken}',
      });
      print(response.statusCode.toString());
      print(response.body.toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        var jsonResponse = convert.jsonDecode(response.body);
        await getOrders(context);
        Provider.of<AppProvider>(context, listen: false).selectedOrder =
            OrderModel();
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

  static void _showResponseSnackBar(BuildContext context, String message,
      {bool invertColor = false}) {
    final snackBar = SnackBar(
        content: Text(
          '$message',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: invertColor
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).cardColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: invertColor
            ? Theme.of(context).cardColor
            : Theme.of(context).primaryColor);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void _navigateRoute(BuildContext context, String route) {
    /**This Navigates push Replacement thus popping the current screen off the navigation stack*/
    Navigator.of(context).pushReplacementNamed(route);
  }
}
