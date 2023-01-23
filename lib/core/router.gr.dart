// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../features/auth/presentation/login_page.dart' as _i4;
import '../features/grades/domain/grades.dart' as _i7;
import '../features/grades/presentation/grades_page.dart' as _i1;
import '../features/grades/presentation/widgets/grade_details_page.dart' as _i2;
import '../test.dart' as _i3;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    GradesRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.GradesPage(),
      );
    },
    GradeDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<GradeDetailsRouteArgs>();
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.GradeDetailsPage(
          key: args.key,
          grade: args.grade,
        ),
      );
    },
    TestRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.TestPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          GradesRoute.name,
          path: '/grades-page',
        ),
        _i5.RouteConfig(
          GradeDetailsRoute.name,
          path: '/grade-details-page',
        ),
        _i5.RouteConfig(
          TestRoute.name,
          path: '/test-page',
        ),
        _i5.RouteConfig(
          LoginRoute.name,
          path: '/',
        ),
      ];
}

/// generated route for
/// [_i1.GradesPage]
class GradesRoute extends _i5.PageRouteInfo<void> {
  const GradesRoute()
      : super(
          GradesRoute.name,
          path: '/grades-page',
        );

  static const String name = 'GradesRoute';
}

/// generated route for
/// [_i2.GradeDetailsPage]
class GradeDetailsRoute extends _i5.PageRouteInfo<GradeDetailsRouteArgs> {
  GradeDetailsRoute({
    _i6.Key? key,
    required _i7.Grade grade,
  }) : super(
          GradeDetailsRoute.name,
          path: '/grade-details-page',
          args: GradeDetailsRouteArgs(
            key: key,
            grade: grade,
          ),
        );

  static const String name = 'GradeDetailsRoute';
}

class GradeDetailsRouteArgs {
  const GradeDetailsRouteArgs({
    this.key,
    required this.grade,
  });

  final _i6.Key? key;

  final _i7.Grade grade;

  @override
  String toString() {
    return 'GradeDetailsRouteArgs{key: $key, grade: $grade}';
  }
}

/// generated route for
/// [_i3.TestPage]
class TestRoute extends _i5.PageRouteInfo<void> {
  const TestRoute()
      : super(
          TestRoute.name,
          path: '/test-page',
        );

  static const String name = 'TestRoute';
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/',
        );

  static const String name = 'LoginRoute';
}
