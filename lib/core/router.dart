import 'package:auto_route/auto_route.dart';
import 'package:libas_app/features/auth/presentation/login_page.dart';
import 'package:libas_app/features/grades/presentation/grades_page.dart';
import 'package:libas_app/features/grades/presentation/widgets/grade_details_page.dart';
import 'package:libas_app/test.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: GradesPage,
      // initial: true,
    ),
    AutoRoute(page: GradeDetailsPage),
    AutoRoute(
      page: TestPage,
      // initial: true,
    ),
    AutoRoute(
      page: LoginPage,
      initial: true,
    )
  ],
)
class $AppRouter {}
