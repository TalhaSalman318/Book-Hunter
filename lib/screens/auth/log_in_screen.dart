import 'package:book_hunt/providers/auth_provider.dart';
import 'package:book_hunt/screens/auth/sign_in_screen.dart';
import 'package:book_hunt/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(title: const Text("Log In")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.login),
              label: const Text("Continue with Google"),
              onPressed: () async {
                try {
                  await auth.signInWithGoogle();

                  // ✅ Success ke baad HomeScreen pr le jao
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                } catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Google Sign-In failed")),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text("Continue with Email"),
              onPressed: () async {
                try {
                  await auth.logInWithEmail(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );

                  // ✅ Success ke baad HomeScreen pr le jao
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                } catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Email Sign-Up failed")),
                  );
                }
              },
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
              ),
              child: Text("Dont have an account? SignUp"),
            ),
            const SizedBox(height: 30),
            if (auth.isSignedIn)
              Column(
                children: [
                  Text("Welcome, ${auth.user?.email ?? ''}"),
                  ElevatedButton(
                    onPressed: () => auth.signOut(),
                    child: const Text("Sign Out"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
