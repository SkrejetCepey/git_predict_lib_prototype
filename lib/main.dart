import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_predict_lib_prototype/cubits/data_table_cubit.dart';
import '';
import 'package:med_predict_lib_prototype/tools/performance_analyser.dart';

import 'models/predict.dart';

class GlobalObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print('${bloc.runtimeType} $change');
    super.onChange(bloc, change);
  }
}

void main() {
  Bloc.observer = GlobalObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Widget build(BuildContext context) {

    return BlocProvider<DataTableCubit>(
      create: (BuildContext context) => DataTableCubit(context),
      child: MaterialApp(
        home: MedPredictDataTable(),
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
      ),
    );
  }
}

class MedPredictDataTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    DataTableCubit dataTableCubit = BlocProvider.of<DataTableCubit>(context);
    final PerformanceAnalyser _performanceAnalyser = PerformanceAnalyser(context: context)..start();
    return BlocBuilder<DataTableCubit, DataTableState>(
      builder: (BuildContext context, DataTableState state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('MedPredictLib ${dataTableCubit.currentDatabaseIndex}'),
            actions: [
              ElevatedButton(onPressed: () {dataTableCubit.swapBase();}, child: Text('Swap base'))
            ],
          ),
          body: Builder(
            builder: (BuildContext context) {

              if (state is DataTableInitialised) {
                Future.microtask(() => _performanceAnalyser.stop());
                return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        sortColumnIndex: 0,
                        sortAscending: true,
                        columns: [
                          DataColumn(
                            label: Text('id'),
                            onSort: (columnIndex, ascending) {
                              if (ascending) {
                                dataTableCubit.list.sort((a, b) => a.id.compareTo(b.id));
                              } else {
                                dataTableCubit.list.sort((a, b) => b.id.compareTo(a.id));
                              }
                            },
                          ),
                          DataColumn(
                              label: Text('sex')
                          ),
                          DataColumn(
                              label: Text('meat')
                          ),
                          DataColumn(
                              label: Text('fish')
                          ),
                          DataColumn(
                              label: Text('vegetables')
                          ),
                          DataColumn(
                              label: Text('sweet')
                          ),
                          DataColumn(
                              label: Text('milk')
                          ),
                          DataColumn(
                              label: Text('curd')
                          ),
                          DataColumn(
                              label: Text('cheese')
                          ),
                          DataColumn(
                              label: Text('physActivity')
                          ),
                          DataColumn(
                              label: Text('smoke')
                          ),
                          DataColumn(
                              label: Text('sleepDuration')
                          ),
                          DataColumn(
                              label: Text('asleepRate')
                          ),
                          DataColumn(
                              label: Text('sleepResist')
                          ),
                          DataColumn(
                              label: Text('diabetesRelatives')
                          ),
                          DataColumn(
                              label: Text('osteochondrosis')
                          ),
                          DataColumn(
                              label: Text('chronicBronchitis')
                          ),
                          DataColumn(
                              label: Text('bronchialAsthma')
                          ),
                          DataColumn(
                              label: Text('gtd')
                          ),
                          DataColumn(
                              label: Text('ulcer')
                          ),
                          DataColumn(
                              label: Text('kidneyDiseases')
                          ),
                          DataColumn(
                              label: Text('thyroidDisease')
                          ),
                          DataColumn(
                              label: Text('height')
                          ),
                          DataColumn(
                              label: Text('weight')
                          ),
                          DataColumn(
                              label: Text('waist')
                          ),
                          DataColumn(
                              label: Text('hip')
                          ),
                          DataColumn(
                              label: Text('age')
                          ),
                          DataColumn(
                              label: Text('meanSBP')
                          ),
                          DataColumn(
                              label: Text('meadDBP')
                          ),
                          DataColumn(
                              label: Text('heartRate')
                          ),
                          DataColumn(
                              label: Text('cholesterol')
                          ),
                          DataColumn(
                              label: Text('glucose')
                          ),
                          DataColumn(
                              label: Text('creatinine')
                          ),
                          DataColumn(
                              label: Text('uricAcid')
                          ),
                          DataColumn(
                              label: Text('dDimer')
                          ),
                          DataColumn(
                              label: Text('crp')
                          ),
                          DataColumn(
                              label: Text('fibrinogen')
                          ),
                          DataColumn(
                              label: Text('insulin')
                          ),
                          DataColumn(
                              label: Text('probnp')
                          ),
                        ],
                        rows: [
                          for(Predict predicate in dataTableCubit.list)
                            DataRow(
                                cells: [
                                  DataCell(Text('${predicate.id}')),
                                  DataCell(Text('${predicate.sex}')),
                                  DataCell(Text('${predicate.meat}')),
                                  DataCell(Text('${predicate.fish}')),
                                  DataCell(Text('${predicate.vegetables}')),
                                  DataCell(Text('${predicate.sweet}')),
                                  DataCell(Text('${predicate.milk}')),
                                  DataCell(Text('${predicate.curd}')),
                                  DataCell(Text('${predicate.cheese}')),
                                  DataCell(Text('${predicate.physActivity}')),
                                  DataCell(Text('${predicate.smoke}')),
                                  DataCell(Text('${predicate.sleepDuration}')),
                                  DataCell(Text('${predicate.asleepRate}')),
                                  DataCell(Text('${predicate.sleepResist}')),
                                  DataCell(Text('${predicate.diabetesRelatives}')),
                                  DataCell(Text('${predicate.osteochondrosis}')),
                                  DataCell(Text('${predicate.chronicBronchitis}')),
                                  DataCell(Text('${predicate.bronchialAsthma}')),
                                  DataCell(Text('${predicate.gtd}')),
                                  DataCell(Text('${predicate.ulcer}')),
                                  DataCell(Text('${predicate.kidneyDiseases}')),
                                  DataCell(Text('${predicate.thyroidDisease}')),
                                  DataCell(Text('${predicate.height}')),
                                  DataCell(Text('${predicate.weight}')),
                                  DataCell(Text('${predicate.waist}')),
                                  DataCell(Text('${predicate.hip}')),
                                  DataCell(Text('${predicate.age}')),
                                  DataCell(Text('${predicate.meanSBP}')),
                                  DataCell(Text('${predicate.meadDBP}')),
                                  DataCell(Text('${predicate.heartRate}')),
                                  DataCell(Text('${predicate.cholesterol}')),
                                  DataCell(Text('${predicate.glucose}')),
                                  DataCell(Text('${predicate.creatinine}')),
                                  DataCell(Text('${predicate.uricAcid}')),
                                  DataCell(Text('${predicate.dDimer}')),
                                  DataCell(Text('${predicate.crp}')),
                                  DataCell(Text('${predicate.fibrinogen}')),
                                  DataCell(Text('${predicate.insulin}')),
                                  DataCell(Text('${predicate.probnp}')),
                                ]
                            ),
                        ],
                      ),
                    )
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                child: Icon(Icons.settings),
                onPressed: () async {
                  BlocProvider.of<DataTableCubit>(context).import();
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              FloatingActionButton(
                child: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<DataTableCubit>(context).deleteAll();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}