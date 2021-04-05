import 'dart:io';
import 'package:med_predict_lib_prototype/models/predict.dart';
import 'database.dart' as predictDatabase;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../abstracts/converter_entry_to_database.dart';

class DBDriver extends predictDatabase.Database<Predict> with ConverterPredictToDatabase{

  //singleton
  DBDriver._();
  static final DBDriver db = DBDriver._();

  Database _db;

  Future get database async {
    if (_db == null) {
      _db = await _init();
    }
    return _db;
  }

  Future<Database> _init() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    String path = p.join(docsDir.path, 'predicts.db');
    Database db = await openDatabase(path, version: 1, onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXISTS predicts ('
                'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
                'sex INTEGER,'
                'meat INTEGER,'
                'fish INTEGER,'
                'vegetables INTEGER,'
                'sweet INTEGER,'
                'milk INTEGER,'
                'curd INTEGER,'
                'cheese INTEGER,'
                'phys_activity INTEGER,'
                'smoke INTEGER,'
                'sleep_duration INTEGER,'
                'asleep_rate INTEGER,'
                'sleep_resist INTEGER,'
                'diabetes_relatives INTEGER,'
                'osteochondrosis INTEGER,'
                'chronic_bronchitis INTEGER,'
                'bronchial_asthma INTEGER,'
                'gtd INTEGER,'
                'ulcer INTEGER,'
                'kidney_diseases INTEGER,'
                'thyroid_disease INTEGER,'
                'height REAL,'
                'weight REAL,'
                'waist REAL,'
                'hip REAL,'
                'age INTEGER,'
                'mean_sbp INTEGER,'
                'mead_dbp INTEGER,'
                'heart_rate INTEGER,'
                'cholesterol REAL,'
                'glucose REAL,'
                'creatinine REAL,'
                'uric_acid INTEGER,'
                'd_dimer REAL,'
                'crp REAL,'
                'fibrinogen REAL,'
                'insulin REAL,'
                'probnp INTEGER,'
                'personId INTEGER'
                ')'
        );
      },
    );
    return db;
  }

  @override
  Future<void> create(Predict predict) async {
    Database db = await database;

    return await db.rawInsert(
        'INSERT INTO predicts (sex, meat, fish, vegetables, sweet, milk, curd, cheese, phys_activity, smoke, sleep_duration, '
            'asleep_rate, sleep_resist, diabetes_relatives, osteochondrosis, chronic_bronchitis, bronchial_asthma, gtd, ulcer, kidney_diseases, '
            'thyroid_disease, height, weight, waist, hip, age, mean_sbp, mead_dbp, heart_rate, cholesterol, glucose, creatinine, uric_acid, d_dimer, crp, fibrinogen, insulin, probnp) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [predict.sex, predict.meat, predict.fish, predict.vegetables, predict.sweet, predict.milk, predict.curd, predict.cheese, predict.physActivity, predict.smoke, predict.sleepDuration,
          predict.asleepRate, predict.sleepResist, predict.diabetesRelatives, predict.osteochondrosis, predict.chronicBronchitis, predict.bronchialAsthma, predict.gtd, predict.ulcer, predict.kidneyDiseases,
          predict.thyroidDisease, predict.height, predict.weight, predict.waist, predict.hip, predict.age, predict.meanSBP, predict.meadDBP, predict.heartRate, predict.cholesterol, predict.glucose, predict.creatinine, predict.uricAcid, predict.dDimer, predict.crp, predict.fibrinogen, predict.insulin, predict.probnp]
    );
  }

  @override
  Future<Predict> get(int id) async {
    Database db = await database;

    var n = await db.rawQuery('SELECT * FROM predicts WHERE id = $id');

    return predictFromMap(n.single);
  }

  @override
  Future<List<Predict>> getAll() async {
    Database db = await database;

    var notes = await db.rawQuery('SELECT * FROM predicts');

    return notes.isNotEmpty ? notes.map((e) => predictFromMap(e)).toList() : [];
  }

  @override
  Future<void> update(Predict predict) async {
    Database db = await database;

    return await db.update('predicts', predictToMap(predict), where: 'id = ?', whereArgs: [predict.id]);
  }

  @override
  Future<void> delete(int id) async {
    Database db = await database;

    return await db.delete('predicts', where: 'id = ?', whereArgs: [id]);
  }

}