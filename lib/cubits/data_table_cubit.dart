import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:med_predict_lib_prototype/models/predict.dart';
import 'package:med_predict_lib_prototype/models/predict_list_model.dart';
import 'package:med_predict_lib_prototype/tools/performance_analyser.dart';
import 'package:meta/meta.dart';

part 'data_table_state.dart';

List<ListModel> _dataTableVariants = [PredictListModel(), AnalogPredictListModel()];

class DataTableCubit extends Cubit<DataTableState> {

  int _varDatabase = 0;
  ListModel abstractListModel;
  List<Predict> list;
  BuildContext context;

  DataTableCubit(this.context) : super(DataTableInitial()) {
    abstractListModel = _dataTableVariants[_varDatabase];
    _init();
  }

  int get currentDatabaseIndex => _varDatabase;

  void swapBase() {
    _varDatabase = _varDatabase == 1 ? 0 : 1;
    abstractListModel = _dataTableVariants[_varDatabase];
    emit(DataTableSwapBase());

    _init();
  }

  Future<void> _init() async {
    PerformanceAnalyser _performanceAnalyser = PerformanceAnalyser(testThing: 'fetch', context: context)..start();

    list = await abstractListModel.list;

    Future.microtask(() => _performanceAnalyser.stop());

    emit(DataTableInitialised());
  }

  void deleteAll() async {
    PerformanceAnalyser _performanceAnalyser = PerformanceAnalyser(testThing: 'deleteAll', context: context)..start();
    await abstractListModel.deleteAll();
    emit(DataTableDeleteAll());
    Future.microtask(() =>_performanceAnalyser.stop());
    _init();
  }

  Future<void> import() async {
    PerformanceAnalyser _performanceAnalyser = PerformanceAnalyser(testThing: 'import', context: context)..start();
    FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['csv']);

    if(result != null) {
      File file = File(result.files.single.path);
      final Stream<List<int>> data = file.openRead();
      final List<dynamic> body = await data
          .transform(utf8.decoder)
          .transform(CsvToListConverter())
          .toList()..removeRange(0, 2);

      for (List<dynamic> list in body) {
        await abstractListModel.add(Predict.fromList(list));
      }
    } else {
      // User canceled the picker
    }
    emit(DataTableImport());
    Future.microtask(() =>_performanceAnalyser.stop());
    _init();
  }
}
