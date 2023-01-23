import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:libas_app/core/errors/failures.dart';
import 'package:libas_app/features/grades/data/grades_repository.dart';
import 'package:libas_app/features/grades/domain/grades.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'grades_event.dart';
part 'grades_state.dart';
part 'grades_bloc.freezed.dart';

class GradesBloc extends Bloc<GradesEvent, GradesState> {
  final GradesRepository gradesRepository;

  GradesBloc({required this.gradesRepository})
      : super(const GradesState.loading()) {
    on<GetGrades>(_onGetGrades);
    on<GetOneGrade>(_onGetOneGrade);
  }

  Future<void> _onGetGrades(GetGrades event, Emitter<GradesState> emit) async {
    emit(const GradesState.loading());
    Either<Failure, Grades> failureOrGrades =
        await gradesRepository.getGrades();
    emit(_eitherLoadedOrErrorState(failureOrGrades));
  }

  GradesState _eitherLoadedOrErrorState(
      Either<Failure, Grades> failureOrGrades) {
    return failureOrGrades.fold(
      (failure) {
        if (failure is CacheFailure) {
          return const GradesState.error('CACHE ERR mess ');
        } else if (failure is ServerFailure) {
          return const GradesState.error('SERVER ERR mess');
        } else {
          return const GradesState.error('jakis error');
        }
      },
      (grades) => GradesState.loaded(grades),
    );
  }

  FutureOr<void> _onGetOneGrade(
      GetOneGrade event, Emitter<GradesState> emit) async {
    emit(const GradesState.oneGradeLoading());
    Either<Failure, Grade> failureOrGrade =
        await gradesRepository.getOneGrade(event.gradeId);
    emit(_oneGradeEitherLoadedOrErrorState(failureOrGrade));
  }

  GradesState _oneGradeEitherLoadedOrErrorState(
      Either<Failure, Grade> failureOrGrades) {
    return failureOrGrades.fold(
      (failure) {
        if (failure is CacheFailure) {
          return const GradesState.oneGradeError('CACHE ERR mess ');
        } else if (failure is ServerFailure) {
          return const GradesState.oneGradeError('SERVER ERR mess');
        } else {
          return const GradesState.oneGradeError('jakis error');
        }
      },
      (grade) => GradesState.oneGradeLoaded(grade),
    );
  }
}
