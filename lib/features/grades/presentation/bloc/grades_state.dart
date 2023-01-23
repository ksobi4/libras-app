part of 'grades_bloc.dart';

@freezed
abstract class GradesState with _$GradesState {
  const factory GradesState.loading() = GradesLoading;
  const factory GradesState.loaded(Grades grades) = GradesLoaded;
  const factory GradesState.error(String message) = GradesError;

  const factory GradesState.oneGradeLoading() = OneGradeLoading;
  const factory GradesState.oneGradeLoaded(Grade grade) = OneGradeLoaded;
  const factory GradesState.oneGradeError(String message) = OneGradeError;
}
