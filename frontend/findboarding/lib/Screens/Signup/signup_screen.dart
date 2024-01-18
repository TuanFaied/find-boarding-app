import 'package:findboarding/constants.dart';
import 'package:flutter/material.dart';
import '../Signup/components/sign_up_top_image.dart';
import '../Signup/components/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SignUpScreenTopImage(),
            // You can adjust the width or constraints of the form as needed
            SizedBox(
              width: 450,
              child: SignUpForm(),
            ),
            SizedBox(height: defaultPadding / 2),
            // Include other widgets or components here
          ],
        ),
      ),
    );
  }
}

// For mobile
class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SignUpScreenTopImage(),
        // You can adjust the width or constraints of the form as needed
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: SignUpForm(),
        ),
        SizedBox(height: defaultPadding / 2),
        // Include other widgets or components here
      ],
    );
  }
}
