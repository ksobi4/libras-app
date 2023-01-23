import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:libas_app/core/router.gr.dart';
import 'package:libas_app/features/grades/domain/grades.dart';

class GradesDisplay extends StatefulWidget {
  final List<Subject> subjects;

  const GradesDisplay({
    Key? key,
    required this.subjects,
  }) : super(key: key);

  @override
  _GradesDisplayState createState() => _GradesDisplayState();
}

class _GradesDisplayState extends State<GradesDisplay> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Text((Random().nextInt(1000)).toString()),
          Expanded(
            child: ListView.builder(
                // shrinkWrap: true,
                itemCount: widget.subjects.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubjectWidget(subject: widget.subjects[index]);
                }),
          ),
        ],
      ),
    );
  }
}

class SubjectWidget extends StatelessWidget {
  final Subject subject;

  const SubjectWidget({
    required this.subject,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AutoRouter.of(context);
    String str = '';

    for (var term in subject.terms) {
      for (var grade in term.grades) {
        str += grade.value + '  ';
      }
    }
    if (subject.terms.isEmpty) {
      str = 'Brak ocen';
    }

    List<Grade> grades = _getGradesList(subject);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(subject.name),
        trailing: Text(
          str,
          overflow: TextOverflow.fade,
        ),
        backgroundColor: Colors.grey[300],
        collapsedBackgroundColor: Colors.grey[600],
        children: [
          SizedBox(
            height: _getSizedBoxSize(grades.length),
            child: ListView.builder(
                itemCount: grades.length,
                itemBuilder: (BuildContext context, int index) {
                  return ElevatedButton(
                    onPressed: () {
                      context.router
                          .push(GradeDetailsRoute(grade: grades[index]));
                    },
                    child: Text(
                      grades[index].value,
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                }),
          )
        ],
      ),
    );
    // return Text(subject.name);
  }
}

List<Grade> _getGradesList(Subject subject) {
  List<Grade> _list = [];
  for (Term term in subject.terms) {
    for (Grade grade in term.grades) {
      _list.add(grade);
    }
  }
  return _list;
}

double _getSizedBoxSize(gradesAmount) {
  if (gradesAmount < 5) {
    return (48 * gradesAmount).toDouble();
  } else {
    return 48 * 5;
  }
}
