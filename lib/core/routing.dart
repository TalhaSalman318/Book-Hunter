import 'package:book_hunt/screens/auth/sign_in_screen.dart';
import 'package:book_hunt/screens/home/home_screen.dart';
import 'package:book_hunt/screens/work_detail/work_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_hunt/screens/main/main_screen.dart';

// 📌 Route Names
class AppRoutes {
  static const String main = '/';
  static const String search = '/search';
  static const String workDetail = '/work_detail';
  static const String editions = '/editions';
  static const String author = '/author';
  static const String subjectBooks = '/subject_books';
  static const String favorites = '/favorites';
  static const String signIn = '/sign_in';
  static const String settings = '/settings';
}

// 📌 Route Generator
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.main:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      // case AppRoutes.search:
      //   final query = settings.arguments as String?;
      //   return MaterialPageRoute(
      //     builder: (_) => SearchScreen(initialQuery: query ?? ""),
      //   );

      case AppRoutes.workDetail:
        final workId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => WorkDetailScreen(workId: workId),
        );

      // case AppRoutes.editions:
      //   final workId = settings.arguments as String;
      //   return MaterialPageRoute(
      //     builder: (_) => EditionsScreen(workId: workId),
      //   );

      // case AppRoutes.author:
      //   final authorId = settings.arguments as String;
      //   return MaterialPageRoute(
      //     builder: (_) => AuthorScreen(authorId: authorId),
      //   );

      // case AppRoutes.subjectBooks:
      //   final subject = settings.arguments as String;
      //   return MaterialPageRoute(
      //     builder: (_) => SubjectBooksScreen(subject: subject),
      //   );

      // case AppRoutes.favorites:
      //   return MaterialPageRoute(builder: (_) => const FavoritesScreen());

      // case AppRoutes.signIn:
      //   return MaterialPageRoute(builder: (_) => const SignInScreen());

      // case AppRoutes.settings:
      //   return MaterialPageRoute(builder: (_) => const SettingsScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Page not found"))),
        );
    }
  }
}
