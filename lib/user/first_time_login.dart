// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class fstReg extends StatefulWidget {
//   const fstReg({super.key});
//
//   @override
//   State<fstReg> createState() => _fstRegState();
// }
//
// class _fstRegState extends State<fstReg> {
//   TextEditingController mobilenumber = TextEditingController();
//   String?verficationid;
//
//   final GlobalKey<FormState> formkey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Color(0xff111C0B),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: formkey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                   child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 50),
//                 child: Image.asset(
//                   'images/Spotify_Logo_RGB_Green.png',
//                   fit: BoxFit.fitWidth,
//                 ),
//               )),
//               SizedBox(
//                 height: 40,
//               ),
//               Card(
//                 elevation: 5.0,
//                 color: Color(0xff111C0B),
//                 shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.greenAccent, width: 2),
//                     borderRadius: BorderRadius.circular(10.0)),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 15),
//                   child: TextFormField(
//                     style: TextStyle(color: Colors.white),
//                     controller: mobilenumber,
//                     // keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                         labelText: "Mobile Number",
//                         labelStyle: TextStyle(color: Colors.greenAccent),
//                         hintText: "Enter Mobile Number",
//                         floatingLabelStyle:
//                             TextStyle(color: Colors.greenAccent),
//                         hintStyle: TextStyle(color: Colors.blueGrey),
//                         focusedBorder: InputBorder.none),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a valid value.';
//                       }
//                       if (!RegExp(r'^\d{10}$').hasMatch(value)) {
//                         return 'Please enter a 10-digit number.';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Card(
//                 elevation: 5.0,
//                 color: Color(0xff111C0B),
//                 shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.greenAccent, width: 2),
//                     borderRadius: BorderRadius.circular(10.0)),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 15),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                   onPressed: () async {
//                     String phoneNumber = '+${mobilenumber.text}';
//                     await FirebaseAuth.instance.verifyPhoneNumber(
//                         verificationCompleted:
//                             (phoneAuthCredential) async {
//                           await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
//
//                             },
//                         verificationFailed: (FirebaseAuthException ex) {
//                           print (ex.message);
//                         },
//                         codeSent: (String verificationID, [int? resendToken]) {
//                           setState(() {
//                             verficationid= verificationID;
//                             Navigator.push(context, MaterialPageRoute(
//                                 builder: (context) => verification()));
//                           });},
//                         codeAutoRetrievalTimeout: (String verificationID) {
//                           setState(() {
//                             verficationid= verificationID;
//                           });
//                         },
//                         phoneNumber: phoneNumber);
//                   },
//                   style: ButtonStyle(
//                       backgroundColor: MaterialStatePropertyAll(Colors.green)),
//                   child: Text(
//                     "Verify OTP",
//                     style: TextStyle(color: Color(0xff111C0B)),
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class verification extends StatefulWidget {
//   verification({super.key});
//
//   @override
//   State<verification> createState() => _verificationState();
// }
//
// class _verificationState extends State<verification> {
//   TextEditingController otpcontroller = TextEditingController();
//   String? verificationid;
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       actions: [
//         Card(
//           elevation: 5.0,
//           color: Color(0xff111C0B),
//           shape: RoundedRectangleBorder(
//               side: BorderSide(color: Colors.greenAccent, width: 2),
//               borderRadius: BorderRadius.circular(10.0)),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15),
//             child: TextFormField(
//               style: TextStyle(color: Colors.white),
//               controller: otpcontroller,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                   labelText: "OTP",
//                   labelStyle: TextStyle(color: Colors.greenAccent),
//                   hintText: "Enter OTP",
//                   floatingLabelStyle:
//                   TextStyle(color: Colors.greenAccent),
//                   hintStyle: TextStyle(color: Colors.blueGrey),
//                   focusedBorder: InputBorder.none),
//             ),
//           ),
//         ),
//         ElevatedButton(
//             onPressed: () async {
//               if(otpcontroller.text.isNotEmpty){
//                 try{
//                   PhoneAuthCredential credential=PhoneAuthProvider.credential(
//                       verificationId: verificationid!,
//                       smsCode: otpcontroller.text);
//                   await FirebaseAuth.instance.signInWithCredential(credential);
//                 }
//                 catch(ex){
//                   ScaffoldMessenger.of(context)
//                       .showSnackBar(SnackBar(content: Text("Error:$ex")));
//                   print(ex);
//                 }
//               }
//             },
//             style: ButtonStyle(
//                 backgroundColor: MaterialStatePropertyAll(Colors.green)),
//             child: Text(
//               "Verify",
//               style: TextStyle(color: Color(0xff111C0B)),
//             )),
//
//
//       ],
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone/music_list/home_page.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {

  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _otpController = TextEditingController();
  String? _verificationId;

  Future<void> _verifyPhoneNumber() async {
    if (_formKey.currentState!.validate()) {
      String phoneNumber = "+${_phoneNumberController.text}";
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>homepage()));
        },
        verificationFailed: (FirebaseAuthException error) {
          // Handle error
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval failed, use manual verification
          setState(() => _verificationId = verificationId);
        },
        codeSent: (String verificationId, [int? resendToken]) {
          setState(() => _verificationId = verificationId);
        },
      );
    }
  }




  Future<void> _verifyOtp() async {
    if (_otpController.text.isNotEmpty) {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!,
          smsCode: _otpController.text,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>homepage()));

      } on FirebaseAuthException catch (error) {
        // Handle error
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_verificationId == null) ...[
                TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your phone number' : null,
                ),
                ElevatedButton(
                  onPressed: _verifyPhoneNumber,
                  child: Text('Request OTP'),
                ),
              ] else


                ...[
                  TextFormField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Enter OTP'),
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter the OTP' : null,
                  ),
                  ElevatedButton(
                    onPressed: _verifyOtp,
                    child: Text('Verify OTP'),
                  ),
                ],
            ],
          ),
        ),
      ),
    );
  }
}