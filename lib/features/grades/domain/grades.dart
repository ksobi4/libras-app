import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grades.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true)
class Grades {
  @HiveField(0)
  List<Subject> subjects;
  @HiveField(2, defaultValue: false)
  @JsonKey(defaultValue: false)
  bool isCachedData;

  Grades({
    required this.subjects,
    required this.isCachedData,
  });

  factory Grades.fromJson(Map<String, dynamic> json) => _$GradesFromJson(json);

  Map<String, dynamic> toJson() => _$GradesToJson(this);
}

@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true)
class Subject {
  @HiveField(0)
  List<Term> terms;
  @HiveField(1)
  String name;

  Subject({
    required this.terms,
    required this.name,
  });

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}

@HiveType(typeId: 3)
@JsonSerializable(explicitToJson: true)
class Term {
  @HiveField(0)
  List<Grade> grades;

  Term({
    required this.grades,
  });

  factory Term.fromJson(Map<String, dynamic> json) => _$TermFromJson(json);

  Map<String, dynamic> toJson() => _$TermToJson(this);
}

@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class Grade {
  @HiveField(0)
  String value;
  @HiveField(1)
  String id;
  @HiveField(2)
  @JsonKey(defaultValue: '')
  String date = '';
  @HiveField(3)
  @JsonKey(defaultValue: '')
  String teacher = '';
  @HiveField(4)
  @JsonKey(defaultValue: '')
  String lesson = '';
  @HiveField(5)
  @JsonKey(defaultValue: false)
  bool inAverage;
  @HiveField(6)
  @JsonKey(defaultValue: '')
  String multiplier = '';
  @HiveField(7)
  @JsonKey(defaultValue: '')
  String user = '';
  @HiveField(8)
  @JsonKey(defaultValue: '')
  String comment = '';
  @HiveField(9)
  @JsonKey(defaultValue: '')
  String category = '';
  @HiveField(10, defaultValue: false)
  @JsonKey(defaultValue: false)
  bool isHasDetails;
  @HiveField(11, defaultValue: false)
  @JsonKey(defaultValue: false)
  bool isCachedData;

  Grade({
    required this.value,
    required this.id,
    required this.date,
    required this.teacher,
    required this.lesson,
    required this.inAverage,
    required this.multiplier,
    required this.user,
    required this.comment,
    required this.category,
    required this.isHasDetails,
    required this.isCachedData,
  });

  factory Grade.fromJson(Map<String, dynamic> json) => _$GradeFromJson(json);

  Map<String, dynamic> toJson() => _$GradeToJson(this);
}
