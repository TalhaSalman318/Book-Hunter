import 'package:book_hunt/core/routing.dart';
import 'package:book_hunt/providers/auth_provider.dart';
import 'package:book_hunt/providers/bottom_nav_provider.dart';
import 'package:book_hunt/providers/search_provider.dart';
import 'package:book_hunt/providers/work_detail_provider.dart';
import 'package:book_hunt/repositories/book_repository.dart';
import 'package:book_hunt/screens/auth/log_in_screen.dart';
import 'package:book_hunt/screens/main/main_screen.dart';
import 'package:book_hunt/services/network_client.dart';
import 'package:book_hunt/services/open_library_api.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final client = NetworkClient();
    final api = OpenLibraryApi(client);
    final repository = BookRepository(api);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SearchBooksProvider(repository)),
        ChangeNotifierProvider(create: (_) => WorkDetailProvider(repository)),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        // 📌 Default route (jo sabse pehle open hogi)
        initialRoute: AppRoutes.main,

        // 📌 Hamara route generator
        onGenerateRoute: AppRouter.generateRoute,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        // home: MainScreen(),
      ),
    );
  }
}
