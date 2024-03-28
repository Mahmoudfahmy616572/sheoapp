// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sheoapp/views/shared/app_style.dart';
import 'package:sheoapp/views/shared/snake_bar.dart';
import 'package:sheoapp/views/ui/mainScreen/main_screen.dart';
import 'package:sheoapp/views/ui/register/register_screen.dart';

import 'component/custom_buttom.dart';
import 'component/custom_form_field.dart';
import 'component/option_register_or_login.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isVisable = false;
  bool isLoading = false;
  loginCode() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      showSnackBar(context, "sign in successfully");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, "'No user found for that email.'");
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, "Wrong password provided for that user.");
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  final _formKey = GlobalKey<FormState>();

  Key _k1 = GlobalKey();
  Key _k2 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome! ",
                    style: appstyle(30, Colors.white, FontWeight.bold),
                  ),
                  Text(
                    "Fill to your details to login into your account ",
                    style: appstyle(15, Colors.white, FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextField(
                    key: _k1,
                    controller: email,
                    hitTxt: 'Email',
                    obsTxt: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                      myKey: _k2,
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
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off_outlined))),
                  const SizedBox(
                    height: 10,
                  ),
                  OptionRegisterOrLogin(
                    txt: 'sign up',
                    onprss: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButtom(
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.black)
                        : Text(
                            "Sign in",
                            style: appstyle(20, Colors.black, FontWeight.bold),
                          ),
                    ontap: () async {
                      if (_formKey.currentState!.validate()) {
                        await loginCode();
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
