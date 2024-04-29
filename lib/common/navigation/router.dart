import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:student_helper/features/auth/sign_up_page.dart';
import 'package:student_helper/features/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:student_helper/features/main_page/main_page.dart';
import 'package:student_helper/features/subjects_page/subjects_page.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});

class AppRouter {
  
  final auth = RouteMap(
    onUnknownRoute: (_) {
      return const Redirect('/sign_in');
    },
      routes: {
        '/sign_up': (_) {
          return MaterialPage(
              child: SignUpPage()
          );
        },
        '/sign_in': (_) {
          return MaterialPage(
              child: SignUpPage()
          );
        }
      }
  );
  
  
  final router = RouteMap(
    onUnknownRoute: (_) {
      return const Redirect('/');
    },
    routes: {
      '/': (_) {
        return const TabPage(
            child: BottomNavBarView(),
            paths: ['/main', '/subjects', '/schedule']
        );
      },
      '/main': (_) {
        return MaterialPage(
            child: MainPage()
        );
      },
      '/subjects': (_) {
        return MaterialPage(
            child: SubjectsPage()
        );
      },
      '/schedule': (_) {
        return MaterialPage(
            child: MainPage()
        );
      }
    }
  );
}