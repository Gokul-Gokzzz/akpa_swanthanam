class HelpModel {
  final List<HelpData> data;

  HelpModel({required this.data});

  factory HelpModel.fromJson(Map<String, dynamic> json) {
    return HelpModel(
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => HelpData.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class HelpData {
  final String name;
  final String districtName;
  final String accountAmount;
  final String balanceAmount;
  final String dateOfDeath;
  final String chequeNumber;
  final String creditedAmount;
  final String image;

  HelpData({
    required this.name,
    required this.districtName,
    required this.accountAmount,
    required this.balanceAmount,
    required this.dateOfDeath,
    required this.chequeNumber,
    required this.creditedAmount,
    required this.image,
  });

  factory HelpData.fromJson(Map<String, dynamic> json) {
    return HelpData(
      name: json['name'] ?? '',
      districtName: json['district_name'] ?? '',
      accountAmount: json['account_amount']?.toString() ?? '',
      balanceAmount: json['balance_amount']?.toString() ?? '',
      dateOfDeath: json['date_of_death'] ?? '',
      chequeNumber: json['cheque_number']?.toString() ?? '',
      creditedAmount: json['credited_amount']?.toString() ?? '',
      image: json['image'] ?? '',
    );
  }
}
