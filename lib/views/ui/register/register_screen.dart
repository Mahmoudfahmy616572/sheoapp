// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sheoapp/views/shared/snake_bar.dart';
import 'package:sheoapp/views/ui/login/login_screen.dart';

import '../../shared/app_style.dart';
import '../login/component/custom_buttom.dart';
import '../login/component/custom_form_field.dart';
import '../login/component/option_register_or_login.dart';
import '../mainScreen/main_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();
  bool isVisable = false;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final Key _k1 = GlobalKey();
  final Key _k2 = GlobalKey();
  final Key _k3 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    registertation() async {
      setState(() {
        isLoading = true;
      });
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );

        CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        users
            .doc(credential.user!.uid)
            .set({
              'Name': username.text,
              "password": password.text,
              "email": email.text
            })
            .then((value) => showSnackBar(context, 'Successfully added'))
            .catchError((error) =>
                showSnackBar(context, 'Failed to merge data: $error'));

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
        } else if (e.code == 'email-already-in-use') {
          showSnackBar(context, "The account already exists for that email.");
        }
      } catch (e) {
        showSnackBar(context, "$e");
      }
      setState(() {
        isLoading = false;
      });
    }

    @override
    void dispose() {
      email.dispose();
      password.dispose();
      super.dispose();
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.5,
                image: AssetImage("assets/images/bg.jpg"),
                fit: BoxFit.fill),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello! ",
                    style: appstyle(30, Colors.white, FontWeight.bold),
                  ),
                  Text(
                    "Fill to your details to Signup into your account ",
                    style: appstyle(15, Colors.white, FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextField(
                    myKey: _k1,
                    validator: (currentValue) {
                      var nonNullValue = currentValue ?? '';
                      if (nonNullValue.isEmpty) {
                        return ("username is required");
                      }

                      return null;
                    },
                    controller: username,
                    hitTxt: 'username',
                    obsTxt: false,
                    inputType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    myKey: _k2,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email address';
                      } else if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null; // Return null if the input is valid
                    },
                    controller: email,
                    hitTxt: 'Email',
                    obsTxt: false,
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    myKey: _k3,
                    validator: (passCurrentValue) {
                      RegExp regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      var passNonNullValue = passCurrentValue ?? "";
                      if (passNonNullValue.isEmpty) {
                        return ("Password is required");
                      } else if (passNonNullValue.length < 6) {
                        return ("Password Must be more than 5 characters");
                      } else if (!regex.hasMatch(passNonNullValue)) {
                        return ("Password should contain upper,lower,digit and Special character ");
                      }
                      return null;
                    },
                    controller: password,
                    hitTxt: 'password',
                    obsTxt: isVisable ? true : false,
                    icon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisable = !isVisable;
                          });
                        },
                        icon: isVisable
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                    inputType: TextInputType.visiblePassword,
                  ),
                  OptionRegisterOrLogin(
                    txt: 'sign in',
                    onprss: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButtom(
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.black)
                        : Text(
                            "Sign up",
                            style: appstyle(20, Colors.black, FontWeight.bold),
                          ),
                    ontap: () async {
                      if (_formKey.currentState!.validate()) {
                        await registertation();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
