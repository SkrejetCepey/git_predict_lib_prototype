import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:med_predict_lib_prototype/models/predict.dart';
import 'package:med_predict_lib_prototype/models/predict_list_model.dart';
import 'package:meta/meta.dart';

part 'data_table_state.dart';

List<ListModel> _dataTableVariants = [PredictListModel(), AnalogPredictListModel()];

class DataTableCubit extends Cubit<DataTableState> {

  int _varDatabase = 1;
  ListModel abstractListModel = _dataTableVariants[1];
  List<Predict> list;
  final BuildContext context;

  DataTableCubit(this.context) : super(DataTableInitial()) {
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
    list = await abstractListModel.list;
    emit(DataTableInitialised());
  }

  void deleteAll() async {
    await abstractListModel.deleteAll();
    emit(DataTableDeleteAll());
    _init();
  }

  Future<void> import() async {
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
    _init();
  }
}
