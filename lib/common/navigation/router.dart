import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:student_helper/features/auth/forgot_password_page.dart';
import 'package:student_helper/features/auth/sign_up_complete_page.dart';
import 'package:student_helper/features/auth/sign_up_page.dart';
import 'package:student_helper/features/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:student_helper/features/main_page/main_page.dart';
import 'package:student_helper/features/queue_page/queue_page.dart';
import 'package:student_helper/features/schedule_page/schedule_page.dart';
import 'package:student_helper/features/special_thanks/special_thanks_page.dart';
import 'package:student_helper/features/subjects_page/subjects_page.dart';
import 'package:student_helper/features/topic_selection/topic_selection_page.dart';

import '../../features/auth/sign_in_page.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter(ref);
});


/// Данный класс содержит маршруты экранов приложения
class AppRouter {

  final Ref _ref;

  AppRouter(this._ref);

  
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
        '/sign_up/complete': (_) {
          return MaterialPage(
              child: SignUpCompletePage()
          );
        },
        '/sign_up/complete/special_thanks': (_) {
          return MaterialPage(
              child: SpecialThanksPage()
          );
        },
        '/sign_in': (_) {
          return MaterialPage(
              child: SignInPage()
          );
        },
        '/sign_in/forgot_password': (_) {
          return MaterialPage(
              child: ForgotPasswordPage()
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
            child: MainPage(),
        );
      },
      '/main/topic': (info) {
        return MaterialPage(
            child: TopicSelectionPage(
                topicId: info.queryParameters['id']!,
                title: info.queryParameters['title']!,
            )
        );
      },
      '/main/queue': (info) {
        return MaterialPage(
            child: QueuePage(
                queueId: info.queryParameters['id']!,
                title: info.queryParameters['title']!,
            )
        );
      },
      '/subjects': (_) {
        return MaterialPage(
            child: SubjectsPage()
        );
      },
      '/schedule': (_) {
        return MaterialPage(
            child: SchedulePage()
        );
      }
    }
  );
}