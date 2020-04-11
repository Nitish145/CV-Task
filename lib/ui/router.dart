import 'package:cv_projects_task/ui/views/about_view.dart';
import 'package:cv_projects_task/ui/views/contributors_view.dart';
import 'package:cv_projects_task/ui/views/home_view.dart';
import 'package:cv_projects_task/ui/views/login_view.dart';
import 'package:cv_projects_task/ui/views/my_projects_view.dart';
import 'package:cv_projects_task/ui/views/profile_view.dart';
import 'package:cv_projects_task/ui/views/projects_detail_view.dart';
import 'package:cv_projects_task/ui/views/public_projects_view.dart';
import 'package:cv_projects_task/ui/views/teachers_view.dart';
import 'package:flutter/material.dart';

class Router {
  static const String initialRoute = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'about':
        return MaterialPageRoute(builder: (_) => AboutView());
      case 'contribute':
        return MaterialPageRoute(builder: (_) => ContributorsView());
      case 'teachers':
        return MaterialPageRoute(builder: (_) => TeachersView());
      case 'public_projects':
        return MaterialPageRoute(builder: (_) => PublicProjectsView());
      case 'profile':
        return MaterialPageRoute(builder: (_) => ProfileView());
      case 'my_projects':
        return MaterialPageRoute(builder: (_) => MyProjectsView());
      case 'project_details':
        var id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => ProjectDetailView(
            id: id,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
