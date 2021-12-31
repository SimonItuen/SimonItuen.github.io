import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vaksine_web/models/child_vaccine_program_model.dart';
import 'package:vaksine_web/models/country_model.dart';
import 'package:vaksine_web/models/dashboard_model.dart';
import 'package:vaksine_web/models/vaccine_model.dart';
import 'package:vaksine_web/models/disease_model.dart';
import 'package:vaksine_web/models/admin_model.dart';
import 'package:vaksine_web/models/order_model.dart';
import 'package:vaksine_web/models/pharmacy_model.dart';
import 'package:vaksine_web/models/child_vaccine_program_model.dart';
import 'package:vaksine_web/models/user_model.dart';
import 'dart:convert' as convert;

class AppProvider with ChangeNotifier {
  Locale _appLocale = const Locale('nb', '');
  AdminModel _currentAdmin = AdminModel(givenName: 'Ola', surname: 'Turmo');
  UserModel _selectedUser = UserModel();
  DashboardModel _currentDashboard = DashboardModel(
      userCount: '0',
      diseaseCount: '0',
      orderCount: '0',
      vaccineCount: '0',
      countryCount: '0',
      childProgramCount: '0',
      pharmacyCount: '0');
  OrderModel _selectedOrder = OrderModel();
  PharmacyModel _selectedPharmacy = PharmacyModel();
  ChildVaccineProgramModel _selectedChildProgram = ChildVaccineProgramModel();
  DiseaseModel _selectedDisease = DiseaseModel();
  VaccineModel _selectedVaccine = VaccineModel();

  int _currentPage = 0;

  CountryModel _selectedCountry =
      CountryModel(nameEn: 'Afghanistan', nameBo: 'Afghanistan', code: 'AF');

  CountryModel get selectedCountry => _selectedCountry;

  set selectedCountry(CountryModel value) {
    _selectedCountry = value;
    notifyListeners();
  }

  List<VaccineModel> _vaccineList = [];
  List<OrderModel> _orderList = [];
  List<PharmacyModel> _pharmacyList = [];
  List<UserModel> _userList = [];

  List<VaccineModel> get vaccineList => _vaccineList;

  set vaccineList(List<VaccineModel> value) {
    _vaccineList = value;
    notifyListeners();
  }

  List<ChildVaccineProgramModel> _childVaccineProgramList = [];

  List<ChildVaccineProgramModel> get childVaccineProgramList =>
      _childVaccineProgramList;

  set childVaccineProgramList(List<ChildVaccineProgramModel> value) {
    _childVaccineProgramList = value;
    notifyListeners();
  }

  List<CountryModel> _countryList = [];
  List<DiseaseModel> _diseaseList = [];

  List<DiseaseModel> get diseaseList => _diseaseList;

  set diseaseList(List<DiseaseModel> value) {
    _diseaseList = value;
    notifyListeners();
  }

  int _currentTab = 0;

  Locale get appLocale => _appLocale;

  UserModel get selectedUser => _selectedUser;


  DashboardModel get currentDashboard => _currentDashboard;

  set currentDashboard(DashboardModel value) {
    _currentDashboard = value;
    notifyListeners();
  }

  set selectedUser(UserModel value) {
    _selectedUser = value;
    notifyListeners();
  }

  set appLocale(Locale value) {
    _appLocale = value;
    notifyListeners();
  }

  List<CountryModel> get countryList => _countryList;

  set countryList(List<CountryModel> value) {
    _countryList = value;
    notifyListeners();
  }

  int get currentTab => _currentTab;

  set currentTab(int value) {
    _currentTab = value;
    notifyListeners();
  }

  AdminModel get currentAdmin => _currentAdmin;

  set currentAdmin(AdminModel value) {
    _currentAdmin = value;
    notifyListeners();
  }

  OrderModel get selectedOrder => _selectedOrder;

  set selectedOrder(OrderModel value) {
    _selectedOrder = value;
    notifyListeners();
  }

  PharmacyModel get selectedPharmacy => _selectedPharmacy;

  set selectedPharmacy(PharmacyModel value) {
    _selectedPharmacy = value;
    notifyListeners();
  }

  ChildVaccineProgramModel get selectedChildProgram => _selectedChildProgram;

  set selectedChildProgram(ChildVaccineProgramModel value) {
    _selectedChildProgram = value;
    notifyListeners();
  }

  DiseaseModel get selectedDisease => _selectedDisease;

  set selectedDisease(DiseaseModel value) {
    _selectedDisease = value;
    notifyListeners();
  }

  VaccineModel get selectedVaccine => _selectedVaccine;

  set selectedVaccine(VaccineModel value) {
    _selectedVaccine = value;
    notifyListeners();
  }

  List<OrderModel> get orderList => _orderList;

  set orderList(List<OrderModel> value) {
    _orderList = value;
    notifyListeners();
  }

  List<PharmacyModel> get pharmacyList => _pharmacyList;

  set pharmacyList(List<PharmacyModel> value) {
    _pharmacyList = value;
    notifyListeners();
  }

  List<UserModel> get userList => _userList;

  set userList(List<UserModel> value) {
    _userList = value;
    notifyListeners();
  }

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  void clear() {
    _currentTab = 0;
    _appLocale = const Locale('nb', '');
    _selectedCountry =
        CountryModel(nameEn: 'Afghanistan', nameBo: 'Afghanistan', code: 'AF');
    _selectedUser = UserModel();
    _selectedOrder = OrderModel();
    _selectedPharmacy = PharmacyModel();
    _selectedChildProgram = ChildVaccineProgramModel();
    _selectedDisease = DiseaseModel();
    _selectedVaccine = VaccineModel();
    notifyListeners();
  }
}
