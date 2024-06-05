import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/string_const.dart';

class AnyCurrencyConversionController extends GetxController {
  var dataList1 = {}.obs;
  var dropdownValue1 = 'USD'.obs;
  var dropdownValue2 = 'INR'.obs;
  var answer = 'Converted Currency will be shown here :)'.obs;

  // var answer = '0'.obs;

  var isLoading = true.obs;
  var precision = 2.obs; // Precision observable
  var isFavorited = false.obs; // Observable to track favorite status
  TextEditingController amountController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getData();
    checkIfFavorited(); // Check if the current conversion is already favorited on init
  }

  void getData() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(StringConst.url));
      if (response.statusCode == 200) {
        dataList1.value = json.decode(response.body);
        log("dataList1 = $dataList1");
      } else {
        throw Exception('Failed to load data');
      }
    } finally {
      isLoading.value = false;
    }
  }

  String convertany(Map exchangeRates, String amount, String currencybase,
      String currencyfinal) {
    if (exchangeRates[currencybase] == null ||
        exchangeRates[currencyfinal] == null) {
      return 'Invalid exchange rates for currencies: $currencybase, $currencyfinal';
    }

    double? baseRate = double.tryParse(exchangeRates[currencybase].toString());
    double? finalRate =
        double.tryParse(exchangeRates[currencyfinal].toString());

    if (baseRate == null || finalRate == null) {
      return 'Invalid exchange rates for currencies: $currencybase, $currencyfinal';
    }

    double? inputAmount = double.tryParse(amount);
    if (inputAmount == null) {
      return 'Invalid amount: $amount';
    }

    double output = (inputAmount / baseRate * finalRate);
    log("precision.value >>>>>> ???? ${precision.value}");
    return output.toStringAsFixed(precision.value); // Apply precision
  }

  void updateDropdownValue1(String value) {
    dropdownValue1.value = value;
  }

  void updateDropdownValue2(String value) {
    dropdownValue2.value = value;
  }

  void calculate(String amount, String currency1, String currency2,
      Map<String, double> rates) {
    answer.value = amount +
        ' ' +
        currency1 +
        ' = ' +
        convertany(rates, amount, currency1, currency2) +
        ' ' +
        currency2;
    log("answer === === ?? $answer");
    checkIfFavorited(); // Check if the current conversion is favorited when a new calculation is made
  }

  void reset() {
    amountController.clear();
    answer.value = 'Converted Currency will be shown here :)';
    updateDropdownValue1('USD');
    updateDropdownValue2('INR');
    isFavorited.value = false; // Reset favorite status when reset is called
  }

  void setPrecision(int value) {
    precision.value = value;
    log("precision.value >>>>>> ???? ${precision.value}");
  }

  Future<void> addToFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];

    String now = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    String favoriteItem = '${answer.value} (Saved on $now)';
    favorites.add(favoriteItem);

    await prefs.setStringList('favorites', favorites);
    isFavorited.value = true; // Set favorite status to true
  }

  Future<void> removeFromFavorites(String favoriteItem) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];

    favorites.removeWhere((item) => item.contains(favoriteItem));

    await prefs.setStringList('favorites', favorites);
    isFavorited.value =
        false; // Set favorite status to false if current item is removed
  }

  Future<void> toggleFavorite() async {
    if (isFavorited.value) {
      await removeFromFavorites(answer.value);
    } else {
      await addToFavorites();
    }
  }

  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }

  Future<void> checkIfFavorited() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];

    isFavorited.value = favorites.any((item) => item.contains(answer.value));
  }

  Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('favorites');
    isFavorited.value = false; // Reset favorite status
  }
}
