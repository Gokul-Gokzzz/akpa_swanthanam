class UserProfile {
  final int id;
  final int districtId;
  final int meghalaId;
  final int unitId;
  final String districtName;
  final String meghalaName;
  final String unitName;
  final String akpaId;
  final String name;
  final String username;
  final String nomineeName;
  final String mobile;
  final String upiId;
  final String image;
  final String dateOfBirth;
  final String joinYear;
  final String lastRenewedDate;
  final double accountAmount;
  final double balanceAmount;
  final int lastDeathId;
  final int previousDeathId;
  final String dateOfDeath;
  final String chequeNumber;
  final String creditedDate;
  final double creditedAmount;
  final String helpImage;
  final int creditedStatus;
  final int status;
  final int deathStatus;
  final String rememberToken;
  final String cmFirebaseToken;
  final String deviceToken;
  final String temporaryToken;
  final String createdAt;
  final String updatedAt;
  final String accountNumber;
  final String ifscCode;
  final String aadhaarNumber;
  final String email;
  final String place;
  final String address;

  UserProfile({
    required this.id,
    required this.districtId,
    required this.meghalaId,
    required this.unitId,
    required this.districtName,
    required this.meghalaName,
    required this.unitName,
    required this.akpaId,
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
    required this.rememberToken,
    required this.cmFirebaseToken,
    required this.deviceToken,
    required this.temporaryToken,
    required this.createdAt,
    required this.updatedAt,
    required this.accountNumber,
    required this.ifscCode,
    required this.aadhaarNumber,
    required this.email,
    required this.place,
    required this.address,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? 0,
      districtId: json['district_id'] ?? 0,
      meghalaId: json['meghala_id'] ?? 0,
      unitId: json['unit_id'] ?? 0,
      districtName: json['district_name'] ?? '',
      meghalaName: json['meghala_name'] ?? '',
      unitName: json['unit_name'] ?? '',
      akpaId: json['akpa_id']?.toString() ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      nomineeName: json['nominee_name'] ?? '',
      mobile: json['mobile'] ?? '',
      upiId: json['upi_id'] ?? '',
      image: json['image'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      joinYear: json['join_year'] ?? '',
      lastRenewedDate: json['last_renewed_date'] ?? '',
      accountAmount: (json['account_amount'] as num?)?.toDouble() ?? 0.0,
      balanceAmount: (json['balance_amount'] as num?)?.toDouble() ?? 0.0,
      lastDeathId: json['last_death_id'] ?? 0,
      previousDeathId: json['previous_death_id'] ?? 0,
      dateOfDeath: json['date_of_death'] ?? '',
      chequeNumber: json['cheque_number'] ?? '',
      creditedDate: json['credited_date'] ?? '',
      creditedAmount: (json['credited_amount'] as num?)?.toDouble() ?? 0.0,
      helpImage: json['help_image'] ?? '',
      creditedStatus: json['credited_status'] ?? 0,
      status: json['status'] ?? 0,
      deathStatus: json['death_status'] ?? 0,
      rememberToken: json['remember_token'] ?? '',
      cmFirebaseToken: json['cm_firebase_token'] ?? '',
      deviceToken: json['device_token'] ?? '',
      temporaryToken: json['temporary_token'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      accountNumber: json['account_number'] ?? '',
      ifscCode: json['ifsc_code'] ?? '',
      aadhaarNumber: json['aadhaar_number'] ?? '',
      email: json['email'] ?? '',
      place: json['place'] ?? '',
      address: json['address'] ?? '',
    );
  }
}
