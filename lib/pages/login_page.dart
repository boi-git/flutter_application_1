// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import '../backend_components/backend_auth.dart';
import '../components/constants/colourandfont.dart';
import '../components/forgetpassword.dart';
import '../components/roundedbutton.dart';
import '../components/roundedinputwidget.dart';
import '../components/roundedpasswordwidget.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whitecolor,
      body: SafeArea(
          child: Center(
        child: ListView(
          //chage to listview and set up the padding for better UI

          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.34,
                  child: const Image(
                    image: AssetImage('lib/images/iiumlogo.png'),
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                RoundedInputWidget(
                  hintText: 'Username',
                  icon: Icons.people,
                  emailController: emailController,
                ),
                RoundedPasswordWidget(
                  passwordController: passwordController,
                ),
                SizedBox(height: size.height * 0.05),
                RoundedButton(
                  size: size,
                  text: 'Login',
                  color: orangeColor,
                  textColor: Colors.black,
                  press: () {
                    loginWithUsername(
                        emailController.text, passwordController.text, context);
                  },
                ),
                SizedBox(height: size.height * 0.01),
                const ForgetPassword(),
              ],
            )
          ],
        ),
      )),
    );
  }
}
