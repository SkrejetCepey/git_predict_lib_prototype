import 'package:med_predict_lib_prototype/drivers/analog_sqllite_db_driver.dart';
import 'package:med_predict_lib_prototype/drivers/sqllite_db_driver.dart';

import 'predict.dart';

abstract class ListModel<T> {

  Future<List<T>> get list;

  Future<void> add(T predict);
  Future<void> update(T predict);
  Future<void> delete(T predict);
  Future<void> deleteAll();

}

class PredictListModel extends ListModel<Predict> {

  @override
  Future<List<Predict>> get list async => await DBDriver.db.getAll();

  @override
  Future<void> add(Predict predict) async {
    await DBDriver.db.create(predict);
  }

  @override
  Future<void> delete(Predict predict) async {
    await DBDriver.db.delete(predict.id);
  }

  @override
  Future<void> update(Predict predict) async {
    await DBDriver.db.update(predict);
  }

  @override
  Future<void> deleteAll() async {
    return await list.then((List<Predict> value) => value.forEach((Predict element) {
      DBDriver.db.delete(element.id);
    }));
  }

}

class AnalogPredictListModel extends ListModel<Predict> {

  @override
  Future<List<Predict>> get list async => await AnalogDBDriver.db.getAll();

  @override
  Future<void> add(Predict predict) async {
    await AnalogDBDriver.db.create(predict);
  }

  @override
  Future<void> delete(Predict predict) async {
    await AnalogDBDriver.db.delete(predict.id);
  }

  @override
  Future<void> update(Predict predict) async {
    await AnalogDBDriver.db.update(predict);
  }

  @override
  Future<void> deleteAll() async {
    return await list.then((List<Predict> value) => value.forEach((Predict element) {
      AnalogDBDriver.db.delete(element.id);
    }));
  }

}
