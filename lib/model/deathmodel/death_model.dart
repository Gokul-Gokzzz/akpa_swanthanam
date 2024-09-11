class DeathDetail {
  final int id;
  final int districtId;
  final int meghalaId;
  final int unitId;
  final String districtName;
  final String meghalaName;
  final String unitName;
  final String name;
  final String username;
  final String nomineeName;
  final String mobile;
  final String upiId;
  final String image;
  final String dateOfBirth;
  final String joinYear;
  final String lastRenewedDate;
  final int accountAmount;
  final int balanceAmount;
  final int lastDeathId;
  final int previousDeathId;
  final String dateOfDeath;
  final String chequeNumber;
  final String creditedDate;
  final int creditedAmount;
  final String helpImage;
  final int creditedStatus;
  final int status;
  final int deathStatus;
  final String age;

  DeathDetail({
    required this.id,
    required this.districtId,
    required this.meghalaId,
    required this.unitId,
    required this.districtName,
    required this.meghalaName,
    required this.unitName,
    required this.name,
    required this.username,
    required this.nomineeName,
    required this.mobile,
    required this.upiId,
    required this.image,
    required this.dateOfBirth,
    required this.joinYear,
    required this.lastRenewedDate,
    required this.accountAmount,
    required this.balanceAmount,
    required this.lastDeathId,
    required this.previousDeathId,
    required this.dateOfDeath,
    required this.chequeNumber,
    required this.creditedDate,
    required this.creditedAmount,
    required this.helpImage,
    required this.creditedStatus,
    required this.status,
    required this.deathStatus,
    required this.age,
  });

  factory DeathDetail.fromJson(Map<String, dynamic> json) {
    return DeathDetail(
      id: json['id'],
      districtId: json['district_id'],
      meghalaId: json['meghala_id'],
      unitId: json['unit_id'],
      districtName: json['district_name'],
      meghalaName: json['meghala_name'],
      unitName: json['unit_name'],
      name: json['name'],
      username: json['username'],
      nomineeName: json['nominee_name'],
      mobile: json['mobile'],
      upiId: json['upi_id'],
      image: json['image'],
      dateOfBirth: json['date_of_birth'],
      joinYear: json['join_year'],
      lastRenewedDate: json['last_renewed_date'],
      accountAmount: json['account_amount'],
      balanceAmount: json['balance_amount'],
      lastDeathId: json['last_death_id'],
      previousDeathId: json['previous_death_id'],
      dateOfDeath: json['date_of_death'],
      chequeNumber: json['cheque_number'],
      creditedDate: json['credited_date'],
      creditedAmount: json['credited_amount'],
      helpImage: json['help_image'],
      creditedStatus: json['credited_status'],
      status: json['status'],
      deathStatus: json['death_status'],
      age: json['age'],
    );
  }
}
