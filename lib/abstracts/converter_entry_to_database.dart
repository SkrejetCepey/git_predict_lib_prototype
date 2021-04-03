import '../models/predict.dart';

mixin ConverterPredictToDatabase {

  Predict predictFromMap(Map map) => Predict(
      id: map['id'],
      sex: map['sex'],
      meat: map['meat'],
      fish: map['fish'],
      vegetables: map['vegetables'],
      sweet: map['sweet'],
      milk: map['milk'],
      curd: map['curd'],
      cheese: map['cheese'],
      physActivity: map['phys_activity'],
      smoke: map['smoke'],
      sleepDuration: map['sleep_duration'],
      asleepRate: map['asleep_rate'],
      sleepResist: map['sleep_resist'],
      diabetesRelatives: map['diabetes_relatives'],
      osteochondrosis: map['osteochondrosis'],
      chronicBronchitis: map['chronic_bronchitis'],
      bronchialAsthma: map['bronchial_asthma'],
      gtd: map['gtd'],
      ulcer: map['ulcer'],
      kidneyDiseases: map['kidney_diseases'],
      thyroidDisease: map['thyroid_disease'],
      height: map['height'],
      weight: map['weight'],
      waist: map['waist'],
      hip: map['hip'],
      age: map['age'],
      meanSBP: map['mean_sbp'],
      meadDBP: map['mead_dbp'],
      heartRate: map['heart_rate'],
      cholesterol: map['cholesterol'],
      glucose: map['glucose'],
      creatinine: map['creatinine'],
      uricAcid: map['uric_acid'],
      dDimer: map['d_dimer'],
      crp: map['crp'],
      fibrinogen: map['fibrinogen'],
      insulin: map['insulin'],
      probnp: map['probnp']
  );

  Map<String, dynamic> predictToMap(Predict predict) => <String, dynamic>{
    'id' : predict.id,
    'sex' : predict.sex,
    'meat' : predict.meat,
    'fish' : predict.fish,
    'vegetables' : predict.vegetables,
    'sweet' : predict.sweet,
    'milk' : predict.milk,
    'curd' : predict.curd,
    'cheese' : predict.cheese,
    'phys_activity' : predict.physActivity,
    'smoke' : predict.smoke,
    'sleep_duration' : predict.sleepDuration,
    'asleep_rate' : predict.asleepRate,
    'sleep_resist' : predict.sleepResist,
    'diabetes_relatives' : predict.diabetesRelatives,
    'osteochondrosis' : predict.osteochondrosis,
    'chronic_bronchitis' : predict.chronicBronchitis,
    'bronchial_asthma' : predict.bronchialAsthma,
    'gtd' : predict.gtd,
    'ulcer' : predict.ulcer,
    'kidney_diseases' : predict.kidneyDiseases,
    'thyroid_disease' : predict.thyroidDisease,
    'height' : predict.height,
    'weight' : predict.weight,
    'waist' : predict.waist,
    'hip' : predict.hip,
    'age' : predict.age,
    'mean_sbp' : predict.meanSBP,
    'mead_dbp' : predict.meadDBP,
    'heart_rate' : predict.heartRate,
    'cholesterol' : predict.cholesterol,
    'glucose' : predict.glucose,
    'creatinine' : predict.creatinine,
    'uric_acid' : predict.uricAcid,
    'd_dimer' : predict.dDimer,
    'crp' : predict.crp,
    'fibrinogen' : predict.fibrinogen,
    'insulin' : predict.insulin,
    'probnp' : predict.probnp
  };
}