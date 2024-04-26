import 'package:routemaster/routemaster.dart';
import 'package:student_helper/features/bottom_nav_bar/bottom_nav_bar_view.dart';

class AppRouter {
  final router = RouteMap(
    onUnknownRoute: (_) {
      return const Redirect('/');
    },
    routes: {
      '/': (_) {
        return TabPage(
            child: BottomNavBarView(),
            paths: ['/main', '/subjects', 'schedule']
        );
      }
    }
  );
}