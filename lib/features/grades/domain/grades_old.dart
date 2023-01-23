// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:hive/hive.dart';

// part 'grades.freezed.dart';
// part 'grades.g.dart';

// @freezed
// class Grades with _$Grades {
//   @JsonSerializable(explicitToJson: true)
//   const factory Grades({
//     required List<Subject> subjects,
//   }) = _Grades;

//   factory Grades.fromJson(Map<String, dynamic> json) => _$GradesFromJson(json);
// }

// @freezed
// class Subject with _$Subject {
//   @JsonSerializable(explicitToJson: true)
//   const factory Subject({required List<Term> terms, required String name}) =
//       _Subject;

//   factory Subject.fromJson(Map<String, dynamic> json) =>
//       _$SubjectFromJson(json);
// }

// @freezed
// class Term with _$Term {
//   @JsonSerializable(explicitToJson: true)
//   const factory Term({required List<Grade> grades}) = _Term;

//   factory Term.fromJson(Map<String, dynamic> json) => _$TermFromJson(json);
// }

// @freezed
// class Grade with _$Grade {
//   @JsonSerializable(explicitToJson: true)
//   @HiveType(typeId: 0, adapterName: 'GradeAdapter')
//   const factory Grade({
//     @HiveField(0) required String id,
//     @HiveField(1) required String value,
//     @HiveField(2) @Default(null) GradeDetails? description,
//     @HiveField(3) @Default(false) bool isHasDescription,
//   }) = _Grade;

//   factory Grade.fromJson(Map<String, dynamic> json) => _$GradeFromJson(json);
// }

// @freezed
// class GradeDetails with _$GradeDetails {
//   @JsonSerializable(explicitToJson: true)
//   const factory GradeDetails({
//     required String grade,
//     required String category,
//     required String date,
//     required String teacher,
//     required String lesson,
//     required bool inAverage,
//     required String multiplier,
//     required String user,
//     required String comment,
//   }) = _GradeDetails;

//   factory GradeDetails.fromJson(Map<String, dynamic> json) =>
//       _$GradeDetailsFromJson(json);
// }
