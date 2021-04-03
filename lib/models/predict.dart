class Predict {

  int id;
  int sex;
  int meat;
  int fish;
  int vegetables;
  int sweet;
  int milk;
  int curd;
  int cheese;
  int physActivity;
  int smoke;
  int sleepDuration;
  int asleepRate;
  int sleepResist;
  int diabetesRelatives;
  int osteochondrosis;
  int chronicBronchitis;
  int bronchialAsthma;
  int gtd;
  int ulcer;
  int kidneyDiseases;
  int thyroidDisease;
  num height;
  double weight;
  num waist;
  num hip;
  int age;
  int meanSBP;
  int meadDBP;
  num heartRate;
  num cholesterol;
  num glucose;
  num creatinine;
  num uricAcid;
  num dDimer;
  num crp;
  num fibrinogen;
  num insulin;
  num probnp;

  Predict.fromList(List<dynamic> list) {
    list = list.join(' ').replaceAll(' ', '.').split(';');
    print(list);

    this.sex = int.tryParse(list[0]);
    this.meat = int.tryParse(list[1]);
    this.fish = int.tryParse(list[2]);
    this.vegetables = int.tryParse(list[3]);
    this.sweet = int.tryParse(list[4]);
    this.milk = num.tryParse(list[5]);
    this.curd = int.tryParse(list[6]);
    this.cheese = int.tryParse(list[7]);

    this.physActivity = int.tryParse(list[8]);
    this.smoke = int.tryParse(list[9]);
    this.sleepDuration = int.tryParse(list[10]);
    this.asleepRate = int.tryParse(list[11]);
    this.sleepResist = int.tryParse(list[12]);
    this.diabetesRelatives = int.tryParse(list[13]);
    this.osteochondrosis = int.tryParse(list[14]);
    this.chronicBronchitis = int.tryParse(list[15]);
    this.bronchialAsthma = int.tryParse(list[16]);
    this.gtd = int.tryParse(list[17]);
    this.ulcer = int.tryParse(list[18]);
    this.kidneyDiseases = int.tryParse(list[19]);
    this.thyroidDisease = int.tryParse(list[20]);
    this.height = num.tryParse(list[21]);

    this.weight = double.tryParse(list[22]);
    this.waist = num.tryParse(list[23]);
    this.hip = num.tryParse(list[24]);
    this.age = int.tryParse(list[25]);
    this.meanSBP = int.tryParse(list[26]);
    this.meadDBP = int.tryParse(list[27]);
    this.heartRate = num.tryParse(list[28]);
    this.cholesterol = num.tryParse(list[29]);
    this.glucose = num.tryParse(list[30]);
    this.creatinine = num.tryParse(list[31]);
    this.uricAcid = num.tryParse(list[32]);
    this.dDimer = num.tryParse(list[33]);
    this.crp = num.tryParse(list[34]);
    this.fibrinogen = num.tryParse(list[35]);
    this.insulin = num.tryParse(list[36]);
    this.probnp = num.tryParse(list[37]);

  }

  Predict({this.id,
    this.sex,
    this.meat,
    this.fish,
    this.vegetables,
    this.sweet,
    this.curd,
    this.cheese, this.physActivity, this.smoke, this.sleepDuration, this.asleepRate, this.sleepResist, this.diabetesRelatives,
    this.osteochondrosis, this.chronicBronchitis, this.bronchialAsthma, this.gtd, this.ulcer, this.kidneyDiseases, this.thyroidDisease, this.height,
    this.weight, this.waist, this.hip, this.age, this.meanSBP, this.meadDBP, this.heartRate, this.cholesterol, this.glucose, this.creatinine, this.uricAcid, this.dDimer, this.crp, this.fibrinogen, this.insulin, this.probnp, this.milk});

}