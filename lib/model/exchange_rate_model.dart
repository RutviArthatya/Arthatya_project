// class ExchangeRateResponse {
//   String result;
//   String documentation;
//   String termsOfUse;
//   int timeLastUpdateUnix;
//   String timeLastUpdateUtc;
//   int timeNextUpdateUnix;
//   String timeNextUpdateUtc;
//   String baseCode;
//   Map<String, double> conversionRates;
//
//   ExchangeRateResponse({
//     required this.result,
//     required this.documentation,
//     required this.termsOfUse,
//     required this.timeLastUpdateUnix,
//     required this.timeLastUpdateUtc,
//     required this.timeNextUpdateUnix,
//     required this.timeNextUpdateUtc,
//     required this.baseCode,
//     required this.conversionRates,
//   });
//
//   factory ExchangeRateResponse.fromJson(Map<String, dynamic> json) {
//     return ExchangeRateResponse(
//       result: json['result'],
//       documentation: json['documentation'],
//       termsOfUse: json['terms_of_use'],
//       timeLastUpdateUnix: json['time_last_update_unix'],
//       timeLastUpdateUtc: json['time_last_update_utc'],
//       timeNextUpdateUnix: json['time_next_update_unix'],
//       timeNextUpdateUtc: json['time_next_update_utc'],
//       baseCode: json['base_code'],
//       conversionRates: (json['conversion_rates'] as Map<String, dynamic>).map((key, value) => MapEntry(key, value.toDouble())),
//     );
//   }
// }
