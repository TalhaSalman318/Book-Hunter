import 'package:book_hunt/core/theme.dart';
import 'package:book_hunt/providers/auth_provider.dart';
import 'package:book_hunt/screens/auth/sign_in_screen.dart';
import 'package:book_hunt/screens/home/home_screen.dart';
import 'package:book_hunt/screens/main/main_screen.dart';
import 'package:book_hunt/widgets/reuseable_button.dart';
import 'package:book_hunt/widgets/reuseable_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity.w,
            child: Image.asset(
              'assets/login.jpg',
              height: 250.h,
              fit: BoxFit.cover,
            ),
          ), // Add your image here
          SizedBox(height: 15.h),

          Text(
            "   Email",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),

          ReuseableTextfield(controller: _emailController, labelText: 'Email'),
          SizedBox(height: 20.h),
          Text(
            "   Password",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          ReuseableTextfield(
            controller: _passwordController,
            labelText: 'Password',
          ),
          SizedBox(height: 20),
          Center(
            child: ReuseableButton(
              onTap: () async {
                try {
                  await auth.logInWithEmail(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );

                  // ✅ Success ke baad HomeScreen pr le jao
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                } catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Email Sign-In failed")),
                  );
                }
              },
              text: 'Login',
            ),
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 2,
                    height: 12.h,
                    color: AppColors.navBarGray,
                  ),
                ),
              ),
              Text(
                "Or Login With",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 2,
                    height: 12,
                    color: AppColors.navBarGray,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: ElevatedButton.icon(
              icon: Image.asset(
                'assets/google_logo.png',
                height: 20.h,
                width: 20.w,
              ),
              label: const Text("Continue with Google"),
              onPressed: () async {
                try {
                  await auth.signInWithGoogle();

                  // ✅ Success ke baad HomeScreen pr le jao
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                } catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Google Sign-In failed")),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account? "),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                ),
                child: Text(
                  "Sign-Up",
                  style: TextStyle(color: AppColors.mainColor),
                ),
              ),
            ],
          ),
          // const SizedBox(height: 30),
          // if (auth.isSignedIn)
          //   Column(
          //     children: [
          //       Text("Welcome, ${auth.user?.email ?? ''}"),
          //       ElevatedButton(
          //         onPressed: () => auth.signOut(),
          //         child: const Text("Sign Out"),
          //       ),
          //     ],
          //   ),
        ],
      ),
    );
  }
}
