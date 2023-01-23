import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libas_app/core/widgets/navigation_drawer.dart';

import 'package:libas_app/features/grades/presentation/bloc/grades_bloc.dart';
import 'package:libas_app/features/grades/presentation/widgets/grades_display.dart';
import 'package:libas_app/locator.dart';

class GradesPage extends StatefulWidget {
  const GradesPage({Key? key}) : super(key: key);

  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Oceny'),
        actions: [
          IconButton(
              onPressed: () {
                _displayDialog(context);
              },
              icon: const Icon(Icons.filter_list))
        ],
      ),
      body: BlocProvider<GradesBloc>.value(
        value: sl<GradesBloc>()..add(const GradesEvent.getGrades()),
        child: Builder(builder: (context) {
          return BlocBuilder<GradesBloc, GradesState>(
              builder: (context, state) {
            if (state is GradesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GradesLoaded) {
              return RefreshIndicator(
                  onRefresh: () async => _refresh(context),
                  child: GradesDisplay(subjects: state.grades.subjects));
            } else if (state is GradesError) {
              return RefreshIndicator(
                onRefresh: () async => _refresh(context),
                child: Stack(children: [
                  Center(child: Text('error w chuuj ${state.message}')),
                  ListView(),
                ]),
              );
            } else {
              return const Text('nic');
            }
          });
        }),
      ),
    );
  }

  void _refresh(BuildContext context) {
    BlocProvider.of<GradesBloc>(context, listen: false)
        .add(const GradesEvent.getGrades());
    // sl<GradesBloc>().add(const GradesEvent.getGrades());
  }

  // ignore: todo
  //TODO filters and setting to order the subjects
  _displayDialog(BuildContext context) async {
    SingingCharacter? _character = SingingCharacter.lafayette;

    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              Radio<SingingCharacter>(
                // title: const Text('Lafayette'),
                value: SingingCharacter.lafayette,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = SingingCharacter.lafayette;
                  });
                },
              ),
              Radio<SingingCharacter>(
                // title: const Text('Thomas Jefferson'),
                value: SingingCharacter.jefferson,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = SingingCharacter.jefferson;
                  });
                },
              ),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Zapisz'))
            ],
          ),
        );
      },
    );
  }
}

enum SingingCharacter { lafayette, jefferson }
