import 'dart:io';
import 'package:med_predict_lib_prototype/models/predict.dart';
import 'database.dart' as predictDatabase;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../abstracts/converter_entry_to_database.dart';

class AnalogDBDriver extends predictDatabase.Database<Predict> with ConverterPredictToDatabase {

  //singleton
  AnalogDBDriver._();
  static final AnalogDBDriver db = AnalogDBDriver._();

  Database _db;

  Future get database async {
    if (_db == null) {
      _db = await _init();
    }
    return _db;
  }

  Future<Database> _init() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    String path = p.join(docsDir.path, 'predicts1.db');
    Database db = await openDatabase(path, version: 1, onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS Analyzes ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
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
              'probnp INTEGER'
              ')'
        );
        await db.execute(
            'CREATE TABLE IF NOT EXISTS Foods ('
                'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
                'meat INTEGER,'
                'fish INTEGER,'
                'vegetables INTEGER,'
                'sweet INTEGER,'
                'milk INTEGER,'
                'curd INTEGER,'
                'cheese INTEGER'
                ')');
        await db.execute(
            'CREATE TABLE IF NOT EXISTS Diseases ('
                'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
                'osteochondrosis INTEGER,'
                'chronic_bronchitis INTEGER,'
                'bronchial_asthma INTEGER,'
                'diabetes_relatives INTEGER,'
                'gtd INTEGER,'
                'ulcer INTEGER,'
                'kidney_diseases INTEGER,'
                'thyroid_disease INTEGER'
                ')');
        await db.execute(
            'CREATE TABLE IF NOT EXISTS Characteristics ('
                'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
                'waist REAL,'
                'hip REAL,'
                'weight REAL,'
                'height REAL,'
                'sex INTEGER,'
                'age INTEGER'
                ')');
        await db.execute(
            'CREATE TABLE IF NOT EXISTS Habits ('
                'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
                'smoke INTEGER,'
                'phys_activity INTEGER,'
                'sleep_duration INTEGER,'
                'asleep_rate INTEGER,'
                'sleep_resist INTEGER'
                ')');
        await db.execute(
            'CREATE TABLE IF NOT EXISTS Humans ('
                'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
                'diseases_id INTEGER,'
                'analyz_id INTEGER,'
                'food_id INTEGER,'
                'characteristic_id INTEGER,'
                'habit_id INTEGER,'
                'FOREIGN KEY (diseases_id) REFERENCES Diseases(id),'
                'FOREIGN KEY (analyz_id) REFERENCES Analyzes(id),'
                'FOREIGN KEY (food_id) REFERENCES Foods(id),'
                'FOREIGN KEY (characteristic_id) REFERENCES Characteristics(id),'
                'FOREIGN KEY (habit_id) REFERENCES Habits(id)'
                ')');
      },
    );
    return db;
  }

  @override
  Future<void> create(Predict predict) async {
    Database db = await database;

    db.rawInsert('INSERT INTO Analyzes (mean_sbp, mead_dbp, heart_rate, cholesterol, glucose,'
        'creatinine, uric_acid, d_dimer, crp, fibrinogen, insulin, probnp) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [predict.meanSBP, predict.meadDBP, predict.heartRate, predict.cholesterol, predict.glucose, predict.creatinine,
          predict.uricAcid, predict.dDimer, predict.crp, predict.fibrinogen, predict.insulin, predict.probnp]);

    db.rawInsert('INSERT INTO Foods (meat, fish, vegetables, sweet, milk,'
        'curd, cheese) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [predict.meat, predict.fish, predict.vegetables, predict.sweet, predict.milk, predict.curd, predict.cheese]);

    db.rawInsert('INSERT INTO Diseases (osteochondrosis, chronic_bronchitis, bronchial_asthma, diabetes_relatives, gtd,'
        'ulcer, kidney_diseases, thyroid_disease) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        [predict.osteochondrosis, predict.chronicBronchitis, predict.bronchialAsthma, predict.diabetesRelatives, predict.gtd, predict.ulcer, predict.kidneyDiseases, predict.thyroidDisease]);

    db.rawInsert('INSERT INTO Characteristics (waist, hip, weight, height, sex,'
        'age) VALUES (?, ?, ?, ?, ?, ?)',
        [predict.waist, predict.hip, predict.weight, predict.height, predict.sex, predict.age]);

    db.rawInsert('INSERT INTO Habits (smoke, phys_activity, sleep_duration, asleep_rate, sleep_resist) VALUES (?, ?, ?, ?, ?)',
        [predict.smoke, predict.physActivity, predict.sleepDuration, predict.asleepRate, predict.sleepResist]);

    var maxAnalyzesId = await db.rawQuery('SELECT MAX(id) AS id FROM Analyzes');

    int id = maxAnalyzesId.first['id'];

    await db.rawInsert('INSERT INTO Humans (diseases_id, analyz_id, food_id, characteristic_id, habit_id) VALUES (?, ?, ?, ?, ?)',
        [id, id, id, id, id]);

  }

  @override
  Future<Predict> get(int id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<Predict>> getAll() async {
    Database db = await database;

    var list = await db.rawQuery('SELECT * FROM Humans AS H '
        'LEFT JOIN Diseases AS D ON (H.diseases_id = D.id) '
        'LEFT JOIN Analyzes AS A ON (H.analyz_id = A.id) '
        'LEFT JOIN Foods AS F ON (H.food_id = F.id) '
        'LEFT JOIN Characteristics AS C ON (H.characteristic_id = C.id) '
        'LEFT JOIN Habits AS Ha ON (H.habit_id = Ha.id)');

    return list.isNotEmpty ? list.map((e) => predictFromMap(e)).toList() : [];
  }

  @override
  Future<void> update(Predict element) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int id) async {
    Database db = await database;

    await db.delete('Humans', where: 'id = ?', whereArgs: [id]);
    await db.delete('Diseases', where: 'id = ?', whereArgs: [id]);
    await db.delete('Analyzes', where: 'id = ?', whereArgs: [id]);
    await db.delete('Foods', where: 'id = ?', whereArgs: [id]);
    await db.delete('Characteristics', where: 'id = ?', whereArgs: [id]);
    await db.delete('Habits', where: 'id = ?', whereArgs: [id]);
  }

}