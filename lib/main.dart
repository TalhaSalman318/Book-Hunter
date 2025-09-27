import 'package:book_hunt/core/routing.dart';
import 'package:book_hunt/core/theme.dart';
import 'package:book_hunt/providers/auth_provider.dart';
import 'package:book_hunt/providers/author_provider.dart';
import 'package:book_hunt/providers/book_provider.dart';
import 'package:book_hunt/providers/bottom_nav_provider.dart';
import 'package:book_hunt/providers/cover_provider.dart';
import 'package:book_hunt/providers/editions_provider.dart';
import 'package:book_hunt/providers/favourites_provider.dart';
import 'package:book_hunt/providers/search_provider.dart';
import 'package:book_hunt/providers/subject_provider.dart';
import 'package:book_hunt/providers/theme_provider.dart';
import 'package:book_hunt/providers/work_detail_provider.dart';
import 'package:book_hunt/repositories/author_repository.dart';
import 'package:book_hunt/repositories/book_repository.dart';
import 'package:book_hunt/repositories/cover_repository.dart';
import 'package:book_hunt/repositories/subject_repository.dart';
import 'package:book_hunt/screens/auth/log_in_screen.dart';
import 'package:book_hunt/screens/main/main_screen.dart';
import 'package:book_hunt/services/favorite_service.dart';
import 'package:book_hunt/services/network_client.dart';
import 'package:book_hunt/services/open_library_api.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        ChangeNotifierProvider(
          create: (_) => EditionProvider(BookRepository(api)),
        ),

        ChangeNotifierProvider(
          create: (context) => AuthorProvider(AuthorRepository(api)),
        ),
        ChangeNotifierProvider(create: (context) => BookProvider(repository)),
        ChangeNotifierProvider(
          create: (context) => SubjectProvider(SubjectRepository(api)),
        ),
        ChangeNotifierProvider(create: (_) => SearchBooksProvider(repository)),
        ChangeNotifierProvider(create: (_) => WorkDetailProvider(repository)),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(
          create: (_) => CoverProvider(CoverRepository(api)),
        ),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => ThemeChangerProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return Consumer<ThemeChangerProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                themeMode: themeProvider.themeMode,
                theme: ThemeData.light(),

                darkTheme: ThemeData.dark(),

                // 📌 Default route (jo sabse pehle open hogi)
                initialRoute: AppRoutes.splash,

                // 📌 Hamara route generator
                onGenerateRoute: AppRouter.generateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
