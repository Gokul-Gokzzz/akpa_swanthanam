import 'dart:convert';
import 'dart:developer';
import 'package:akpa/model/confgmodel/config_model.dart';
import 'package:akpa/model/deathmodel/death_model.dart';
import 'package:akpa/model/helpmodel/help_model.dart';
import 'package:akpa/model/loginmodel/login_model.dart';
import 'package:akpa/model/transactionmodel/transaction_model.dart';
import 'package:akpa/model/usermodel/user_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'https://akpa.in/santhwanam/api/v1/';
  final Dio _dio = Dio();

  Future<Config> fetchConfig() async {
    final response = await _dio.get('https://akpa.in/santhwanam/api/v1/config');
    if (response.statusCode == 200) {
      return Config.fromJson(response.data);
    } else {
      throw Exception('Failed to load config');
    }
  }

  //---login---Service---//
  Future<LoginModel?> login(String username, String password) async {
    const url = "https://akpa.in/santhwanam/api/v1/auth/login";

    try {
      final response = await _dio.post(
        url,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == true) {
          final loginModel = LoginModel.fromJson(data);

          // Save member_id to SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (loginModel.memberId != null) {
            await prefs.setString('member_id', loginModel.memberId!);
          }

          return loginModel;
        } else {
          log('Login failed with message: ${data['message']}');
          return null;
        }
      } else {
        log('Login failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Login failed with error: $e');
      return null;
    }
  }

  Future<void> updateDeviceToken(String username) async {
    final url = "${baseUrl}user/update_device_token";

    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final deviceToken = sharedPreferences.getString('deviceToken') ?? '';

      await _dio.post(
        url,
        data: {
          'username': username,
          'deviceToken': deviceToken,
        },
      );
    } catch (e) {
      log('Failed to update device token: $e');
    }
  }

  Future<void> logout() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.remove('username');
    await sharedPreferences.remove('password');

    final url = "${baseUrl}user/remove_device_token";
    final deviceToken = sharedPreferences.getString('deviceToken') ?? '';

    try {
      await _dio.post(
        url,
        data: {
          'deviceToken': deviceToken,
        },
      );
    } catch (e) {
      log('Failed to remove device token: $e');
    }
  }

  //---user---view--//

  // Future<UserProfile?> getUserView(int memberId) async {
  //   try {
  //     final response = await _dio.post(
  //       'https://lifelinekeralatrust.com/api/v1/user/profile',
  //       data: {
  //         'member_id': memberId.toString(),
  //       },
  //     );

  //     if (response.statusCode == 200 && response.data['status'] == true) {
  //       final userProfile = UserProfile.fromJson(response.data['data']);
  //       return userProfile;
  //     } else {
  //       log('Failed to load profile. Message: ${response.data['message']}');
  //       return null;
  //     }
  //   } catch (e) {
  //     log('Error: $e');
  //     return null;
  //   }
  // }

//---- user==profilr---//

  Future<UserProfile> getUserProfile(String memberId) async {
    final url = '${baseUrl}user/profile';
    try {
      final response = await _dio.post(
        url,
        data: {'member_id': memberId},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        return UserProfile.fromJson(data);
      } else {
        throw Exception('Failed to fetch user profile');
      }
    } catch (e) {
      log('Failed to fetch user profile with error: $e');
      throw Exception('Failed to fetch user profile');
    }
  }

  Future<Config> getConfig() async {
    const url = 'https://akpa.in/santhwanam/api/v1/config';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        return Config.fromJson(response.data);
      } else {
        throw Exception('Failed to load configuration');
      }
    } catch (e) {
      log('Error fetching config: $e');
      rethrow;
    }
  }

  //---dashboard--//
  Future<UserProfile?> getDashboard() async {
    try {
      final response = await _dio.post(
        'https://akpa.in/santhwanam/api/v1/user/dashboard',
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.data);
        return UserProfile.fromJson(data['member_details']);
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      throw Exception('Failed to load user profile: $e');
    }
  }

  //--transaction---//
  Future<List<Transaction>> getTransactionList(String memberId) async {
    const String url = 'https://akpa.in/santhwanam/api/v1/user/transactions';

    try {
      final response = await _dio.post(
        url,
        data: {'member_id': memberId},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['list']['data'];
        return data.map((item) => Transaction.fromJson(item)).toList();
      } else {
        log('Error: ${response.statusCode}');
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      log('Exception: $e');
      throw Exception('Failed to load transactions: $e');
    }
  }

  //---help--list---//

  Future<HelpModel> getUserList(String memberId) async {
    try {
      final response = await Dio().post(
        'https://akpa.in/santhwanam/api/v1/user/help_list',
        data: {'member_id': memberId},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        log('response${response.data}');
        return HelpModel.fromJson(response.data);
      } else {
        log('service help');
        return HelpModel(data: []);
      }
    } catch (e) {
      log('Error service: $e');
      throw Exception('Failed to fetch help list');
    }
  }

  // Future<Map<String, dynamic>> fetchUserData(String memberId) async {
  //   final response = await _dio.get(
  //     'https://lifelinekeralatrust.com/api/v1/user/view',
  //     queryParameters: {
  //       'member_id': memberId,
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final data = response.data;
  //     print(data);
  //     return {
  //       "memberDetails": MemberDetails.fromJson(data['member_details']),
  //       "familyDetails": (data['family_details'] as List)
  //           .map((family) => FamilyDetails.fromJson(family))
  //           .toList(),
  //       "helpReceived": (data['help_received'] as List)
  //           .map((help) => HelpReceived.fromJson(help))
  //           .toList(),
  //     };
  //   } else {
  //     throw Exception('Failed to load user data');
  //   }
  // }

  // Future<MemberDetails> fetchMemberDetails(String memberId) async {
  //   try {
  //     final response = await _dio.post(
  //       'https://lifelinekeralatrust.com/api/v1/user/view',
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
  //           'Content-Type': 'application/json',
  //         },
  //       ),
  //       data: {
  //         'member_id': memberId,
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       log('Response data: ${response.data}');
  //       var data = response.data['member_details'];
  //       if (data != null) {
  //         return MemberDetails.fromJson(data);
  //       } else {
  //         throw Exception('Member details are missing from the response');
  //       }
  //     } else {
  //       throw Exception('Failed to load member details');
  //     }
  //   } catch (e) {
  //     log('Failed to load member details: $e');
  //     rethrow;
  //   }
  // }

  // Future<List<FamilyDetails>> fetchFamilyDetails(String memberId) async {
  //   try {
  //     final response = await _dio.post(
  //       'https://lifelinekeralatrust.com/api/v1/user/view',
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
  //           'Content-Type': 'application/json',
  //         },
  //       ),
  //       data: {
  //         'member_id': memberId,
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       var familyDetailsData = response.data['family_details'] as List;
  //       return familyDetailsData
  //           .map((familyDetail) => FamilyDetails.fromJson(familyDetail))
  //           .toList();
  //     } else {
  //       throw Exception('Failed to load family details');
  //     }
  //   } catch (e) {
  //     log('Failed to load family details: $e');
  //     rethrow;
  //   }
  // }

  Future<List<DeathDetail>> fetchDeathDetails(String memberId) async {
    try {
      final response = await _dio
          .post('https://akpa.in/santhwanam/api/v1/user/death_list', data: {
        'member_id': memberId,
      });

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['list']['data'];
        return data.map((json) => DeathDetail.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load death details');
      }
    } catch (e) {
      throw Exception('Error fetching death details: $e');
    }
  }
}
