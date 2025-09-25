import 'package:book_hunt/core/theme.dart';
import 'package:book_hunt/providers/auth_provider.dart';
import 'package:book_hunt/screens/auth/log_in_screen.dart';
import 'package:book_hunt/screens/home/home_screen.dart';
import 'package:book_hunt/screens/main/main_screen.dart';
import 'package:book_hunt/widgets/reuseable_button.dart';
import 'package:book_hunt/widgets/reuseable_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Text(
              "Welcome to Book Hunt",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              "Create Account",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                textAlign: TextAlign.center,
                "Fill Your Information Below Or Register With Your Social Account",
                style: TextStyle(
                  fontSize: 20.sp,

                  fontWeight: FontWeight.bold,
                  color: AppColors.fontGreyColor,
                ),
              ),
            ),
            SizedBox(height: 30.h),

            Align(
              alignment: Alignment.centerLeft,

              child: Text(
                textAlign: TextAlign.start,

                "   Email",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
            ),
            ReuseableTextfield(
              controller: _emailController,
              labelText: 'Email',
            ),
            SizedBox(height: 20.h),

            Align(
              alignment: Alignment.centerLeft,

              child: Text(
                "   Password",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
            ),
            ReuseableTextfield(
              controller: _passwordController,
              labelText: 'Password',
            ),
            // ElevatedButton.icon(
            //   icon: const Icon(Icons.login),
            //   label: const Text("Continue with Google"),
            //   onPressed: () async {
            //     try {
            //       await auth.signInWithGoogle();

            //       // ✅ Success ke baad HomeScreen pr le jao
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(builder: (context) => const MainScreen()),
            //       );
            //     } catch (_) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(content: Text("Google Sign-In failed")),
            //       );
            //     }
            //   },
            // ),
            SizedBox(height: 40),
            ReuseableButton(
              onTap: () async {
                try {
                  await auth.signUpWithEmail(
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
              text: 'Sign In',
            ),

            // ElevatedButton(
            //   child: const Text("Continue with Email"),
            //   onPressed: () async {
            //     try {
            //       await auth.signUpWithEmail(
            //         _emailController.text.trim(),
            //         _passwordController.text.trim(),
            //       );

            //       // ✅ Success ke baad HomeScreen pr le jao
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(builder: (context) => const MainScreen()),
            //       );
            //     } catch (_) {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(content: Text("Email Sign-In failed")),
            //       );
            //     }
            //   },
            // ),
            SizedBox(height: 20.h),

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
                  "Or Sign-Up With",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
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
            SizedBox(height: 20.h),

            ElevatedButton.icon(
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
            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ),
                  child: Text(
                    "Log-In",
                    style: TextStyle(color: AppColors.mainColor),
                  ),
                ),
              ],
            ),

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
      ),
    );
  }
}
