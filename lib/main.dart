// import 'package:fb/firebase_options.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options:
//         DefaultFirebaseOptions.currentPlatform, // Web-specific configuration
//   );
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: PhoneAuthScreen(),
//     );
//   }
// }

// class PhoneAuthScreen extends StatefulWidget {
//   @override
//   _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
// }

// class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();

//   String verificationId = '';

//   Future<void> sendOTP() async {
//     String phone = phoneController.text.trim();

//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: phone,
//       verificationCompleted: (PhoneAuthCredential credential) {
//         // Auto verification completed
//         FirebaseAuth.instance.signInWithCredential(credential).then((user) {
//           print('User signed in: ${user.user}');
//         });
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         // Handle failure
//         print('Verification failed: ${e.message}');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Verification failed: ${e.message}')),
//         );
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         // Save the verification ID for later use
//         setState(() {
//           this.verificationId = verificationId;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('OTP sent to $phone')),
//         );
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         // Auto-retrieval timeout
//         this.verificationId = verificationId;
//       },
//     );
//   }

//   Future<void> verifyOTP() async {
//     String otp = otpController.text.trim();

//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: otp,
//       );

//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithCredential(credential);

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Phone number verified!')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Invalid OTP. Please try again.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Phone Authentication'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: phoneController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 labelText: 'Phone Number',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: sendOTP,
//               child: Text('Send OTP'),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: otpController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Enter OTP',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: verifyOTP,
//               child: Text('Verify OTP'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/user_form_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserFormScreen(),
    );
  }
}
