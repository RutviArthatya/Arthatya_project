

import 'dart:convert';

RatesModel ratesModelFromJson(String str) => RatesModel.fromJson(json.decode(str));

String ratesModelToJson(RatesModel data) => json.encode(data.toJson());

class RatesModel {
  final String? disclaimer;
  final String? license;
  final int? timestamp;
  final String? base;
  final Map<String, double>? rates;

  RatesModel({
    this.disclaimer,
    this.license,
    this.timestamp,
    this.base,
    this.rates,
  });

  factory RatesModel.fromJson(Map<String, dynamic> json) => RatesModel(
    disclaimer: json["disclaimer"],
    license: json["license"],
    timestamp: json["timestamp"],
    base: json["base"],
    rates: Map.from(json["rates"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "disclaimer": disclaimer,
    "license": license,
    "timestamp": timestamp,
    "base": base,
    "rates": Map.from(rates!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

