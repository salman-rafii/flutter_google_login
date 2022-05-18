import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_with_google/pages/details_page.dart';
import 'package:login_with_google/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return const DetailsPage();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something Went Wrong"),
              );
            } else {
              return const SignInPage();
            }
          }),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ElevatedButton.icon(
          icon: const FaIcon(FontAwesomeIcons.google),
          label: const Text("Sign in Google"),
          style: ElevatedButton.styleFrom(
              primary: Colors.red, minimumSize: Size(double.infinity, 50)),
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.googleLogin();
          },
        ),
      ),
    );
  }
}
