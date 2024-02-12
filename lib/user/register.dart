import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController uname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  bool pswdvissible = false;
  bool cnfpswdvissible = false;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> saveDetails() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference nameCollection = firestore.collection('Register');
      if (formkey.currentState?.validate() ?? false) {
        print("Form is valid");

        Map<String, dynamic> nameData = {
          'uname': uname.text,
          'email': email.text,
          'mobilenumber': mobilenumber.text,
          'password': password.text,
        };
        await nameCollection.add(nameData);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(("success"))));
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error:$error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: uname,
                      decoration: InputDecoration(
                          labelText: "name", hintText: "Enter name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid value.';
                        }
                        if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                          return 'Please enter a valid name with only letters and spaces.';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "e-mail", hintText: "Enter email"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid email address.';
                        }
                        if (!RegExp(
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: mobilenumber,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Mobile Number",
                          hintText: "Enter Mobile Number"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid value.';
                        }
                        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Please enter a 10-digit number.';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                          labelText: "password",
                          hintText: "Enter password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  pswdvissible = !pswdvissible;
                                });
                              },
                              icon: Icon(pswdvissible
                                  ? Icons.visibility_sharp
                                  : Icons.visibility_off))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter a valid input";
                        }
                        if (value.length < 8 ||
                            !RegExp(r'[0-9]').hasMatch(value) ||
                            !RegExp(r'[!@#$%^&*]').hasMatch(value)) {
                          return 'Password should contain a minimum of 8 characters,\n one number, and one special character.';
                        }
                        return null;
                      },
                      obscureText: !pswdvissible,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: confirmpassword,
                      decoration: InputDecoration(
                          labelText: "Confirm password",
                          hintText: "Enter password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  cnfpswdvissible = !cnfpswdvissible;
                                });
                              },
                              icon: Icon(cnfpswdvissible
                                  ? Icons.visibility_sharp
                                  : Icons.visibility_off))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter a valid input";
                        }
                        if (value != password.text) {
                          return 'Password doesnt match.';
                        }
                        return null;
                      },
                      obscureText: !cnfpswdvissible,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      saveDetails();
                    },
                    child: Text("submit")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
