
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/components/round_button.dart';
import 'package:fitness/components/round_textfield.dart';
import 'package:fitness/view/Authentication/ForgotScreen/forgot_screen.dart';
import 'package:fitness/view/Authentication/RegisterScreen/signup_view.dart';
import 'package:fitness/view/dashboard/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formState = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool isPasswordSecured = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: media.height * 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: media.width * 0.3,
                ),
                Text(
                  "Hey there,",
                  style: TextStyle(color: TColor.gray, fontSize: 20.sp),
                ),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.2,
                ),
                Form(
                  key: _formState,
                  child: Column(
                    children: [
                      RoundTextField(
                        controller: _emailController,
                        hitText: "Email",
                        isRequired: true,
                        icon: "assets/img/email.png",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      RoundTextField(
                        controller: _passwordController,
                        hitText: "Password",
                        isRequired: true,
                        obscureText: true,
                        secured: isPasswordSecured,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordSecured = !isPasswordSecured;
                              });
                            },
                            icon: isPasswordSecured
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                        icon: "assets/img/lock.png",
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const ForgotScreen()));
                            },
                            child: Text(
                              "Forgot your password?",
                              style: TextStyle(
                                  color: TColor.gray,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.3,
                      ),
                      RoundButton(
                          title: "Login",
                          onPressed: () async {
                            if (_formState.currentState!.validate()) {
                              if (_emailController.text == "istiaq66@gmail.com" && _passwordController.text == "12345678") {
                                try { await
                                _auth.signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text)
                                    .then((value) {
                                    showTopSnackBar(Overlay.of(context),const CustomSnackBar.success(message: "Login Successfully",),
                                    );
                                    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (_) => const BottomNavBar()),(route) => false);});
                                } catch (e) {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(
                                      message: e.toString(),
                                    ),
                                  );
                                }}
                              //else {
                              //   try {
                              //     await _auth
                              //         .signInWithEmailAndPassword(
                              //             email: _emailController.text,
                              //             password: _passwordController.text)
                              //         .then((value) {
                              //       showTopSnackBar(
                              //         Overlay.of(context),
                              //         const CustomSnackBar.success(
                              //           message: "Login Successfully",
                              //         ),
                              //       );
                              //       Navigator.pushAndRemoveUntil(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (_) => HomeView()),
                              //           (route) => false);
                              //     });
                              //   } catch (e) {
                              //     showTopSnackBar(
                              //       Overlay.of(context),
                              //       CustomSnackBar.error(
                              //         message: e.toString(),
                              //       ),
                              //     );
                              //   }
                              // }
                            }
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                TextButton(
                  onPressed: () {
                       Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const SignUpView()));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don’t have an account yet? ",
                        style: TextStyle(
                          color: TColor.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Register",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}