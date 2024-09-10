// import 'package:akpa/model/usermodel/user_model.dart';
// import 'package:akpa/service/api_service.dart';
// import 'package:flutter/material.dart';

// final ApiService apiService = ApiService();
// UserProfile? userProfile;
// Widget dashBoardDetails() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Card(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text('Name',
//                         style: TextStyle(
//                             fontSize: 16.0, fontWeight: FontWeight.bold)),
//                     Text(userProfile!.name,
//                         style: const TextStyle(fontSize: 18.0)),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     const Text('AKPA ID',
//                         style: TextStyle(
//                             fontSize: 16.0, fontWeight: FontWeight.bold)),
//                     Text(userProfile!.akpaId,
//                         style: const TextStyle(fontSize: 18.0)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       const SizedBox(height: 16.0),
//       Center(
//         child: Column(
//           children: [
//             const Text('Account Balance',
//                 style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white)),
//             Text(userProfile!.accountAmount.toStringAsFixed(2),
//                 style: const TextStyle(
//                     fontSize: 28.0,
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//       const SizedBox(height: 16.0),
//       Card(
//         child: Padding(
//           padding: const EdgeInsets.all(6.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text('Account Number',
//                         style: TextStyle(
//                             fontSize: 16.0, fontWeight: FontWeight.bold)),
//                     Text(
//                       userProfile!.accountNumber.isNotEmpty
//                           ? userProfile!.accountNumber
//                           : 'N/A',
//                       style: const TextStyle(fontSize: 18.0),
//                     ),
//                     const SizedBox(height: 8.0),
//                     const Text('UPI ID',
//                         style: TextStyle(
//                             fontSize: 16.0, fontWeight: FontWeight.bold)),
//                     Text(userProfile!.upiId,
//                         style: const TextStyle(fontSize: 18.0)),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     const Text('IFSC Code',
//                         style: TextStyle(
//                             fontSize: 16.0, fontWeight: FontWeight.bold)),
//                     Text(
//                       userProfile!.ifscCode.isNotEmpty
//                           ? userProfile!.ifscCode
//                           : 'N/A',
//                       style: const TextStyle(fontSize: 18.0),
//                     ),
//                     const SizedBox(height: 8.0),
//                     const Text('Aadhaar Number',
//                         style: TextStyle(
//                             fontSize: 16.0, fontWeight: FontWeight.bold)),
//                     Text(userProfile!.aadhaarNumber,
//                         style: const TextStyle(fontSize: 18.0)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       const SizedBox(height: 16.0),
//       Card(
//         child: Padding(
//           padding: const EdgeInsets.all(6.0),
//           child: Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text('Mobile Number',
//                             style: TextStyle(
//                                 fontSize: 16.0, fontWeight: FontWeight.bold)),
//                         Text(userProfile!.mobile,
//                             style: const TextStyle(fontSize: 18.0)),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         const Text('Email ID',
//                             style: TextStyle(
//                                 fontSize: 16.0, fontWeight: FontWeight.bold)),
//                         Text(
//                           userProfile!.email.isNotEmpty
//                               ? userProfile!.email
//                               : 'N/A',
//                           style: const TextStyle(
//                               fontSize: 13.0, fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16.0),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text('District',
//                             style: TextStyle(
//                                 fontSize: 16.0, fontWeight: FontWeight.bold)),
//                         Text(userProfile!.districtName,
//                             style: const TextStyle(fontSize: 18.0)),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         const Text('Place',
//                             style: TextStyle(
//                                 fontSize: 16.0, fontWeight: FontWeight.bold)),
//                         Text(userProfile!.meghalaName,
//                             style: const TextStyle(fontSize: 18.0)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16.0),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text('Address',
//                             style: TextStyle(
//                                 fontSize: 16.0, fontWeight: FontWeight.bold)),
//                         Text(userProfile!.address,
//                             style: const TextStyle(fontSize: 18.0)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     ],
//   );
// }
