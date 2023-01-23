import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:libas_app/features/grades/domain/grades.dart';
import 'package:libas_app/features/grades/presentation/bloc/grades_bloc.dart';
import 'package:libas_app/locator.dart';

class GradeDetailsPage extends StatelessWidget {
  final Grade grade;
  const GradeDetailsPage({
    Key? key,
    required this.grade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Szczegóły oceny')),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _generateTable([
              ['id', grade.id],
              ['ocena', grade.value]
            ]),
            BlocProvider<GradesBloc>.value(
              value: sl<GradesBloc>()..add(GradesEvent.getOneGrade(grade.id)),
              child: Builder(builder: (context) {
                return BlocBuilder<GradesBloc, GradesState>(
                    builder: (context, state) {
                  if (state is OneGradeLoading) {
                    return Column(children: const [
                      SizedBox(
                        height: 100,
                      ),
                      CircularProgressIndicator()
                    ]);
                  } else if (state is OneGradeLoaded) {
                    // return Text('pokazuje dobrze' + state.grade.category);
                    return _generateTable([
                      ['kategoria', state.grade.category],
                      ['data', state.grade.date],
                      ['lekcja', state.grade.lesson],
                      ['nauczyciel', state.grade.teacher],
                      [
                        'czy do sredniej',
                        _boolToPolishString(state.grade.inAverage)
                      ],
                      ['komentarz', state.grade.comment],
                      ['waga', state.grade.multiplier],
                    ]);
                  } else if (state is OneGradeError) {
                    return Text('Err mess= ${state.message}');
                  } else {
                    return const Text('nic');
                  }
                });
              }),
            )
          ],
        ),
      )),
    );
  }
}

_boolToPolishString(bool data) {
  if (data) return 'tak';
  return 'nie';
}

_generateTable(List list) {
  return Table(
    border: _constTableBorder,
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    children: [
      for (var el in list)
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(el[0]),
          ),
          Text(el[1])
        ])
    ],
  );
}

TableBorder _constTableBorder = const TableBorder(
  horizontalInside: BorderSide(
    width: 1,
    color: Colors.blue,
  ),
  left: BorderSide(
    width: 1,
    color: Colors.blue,
  ),
  right: BorderSide(
    width: 1,
    color: Colors.blue,
  ),
  top: BorderSide(
    width: 1,
    color: Colors.blue,
  ),
  bottom: BorderSide(
    width: 1,
    color: Colors.blue,
  ),
);
