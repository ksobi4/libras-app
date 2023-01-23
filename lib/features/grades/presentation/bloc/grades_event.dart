part of 'grades_bloc.dart';

@freezed
abstract class GradesEvent with _$GradesEvent {
  const factory GradesEvent.getGrades() = GetGrades;
  const factory GradesEvent.getOneGrade(String gradeId) = GetOneGrade;
}
