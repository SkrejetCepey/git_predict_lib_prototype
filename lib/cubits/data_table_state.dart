part of 'data_table_cubit.dart';

@immutable
abstract class DataTableState {}

class DataTableInitial extends DataTableState {}

class DataTableInitialised extends DataTableState {}

class DataTableEmpty extends DataTableState {}

class DataTableImport extends DataTableState {}

class DataTableDeleteAll extends DataTableState {}

class DataTableSwapBase extends DataTableState {}
