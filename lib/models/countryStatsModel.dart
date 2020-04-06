class CountryStatsModel {
  List<Countrydata> countrydata;
  String stat;

  CountryStatsModel({this.countrydata, this.stat});

  CountryStatsModel.fromJson(Map<String, dynamic> json) {
    if (json['countrydata'] != null) {
      countrydata = new List<Countrydata>();
      json['countrydata'].forEach((v) {
        countrydata.add(new Countrydata.fromJson(v));
      });
    }
    stat = json['stat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countrydata != null) {
      data['countrydata'] = this.countrydata.map((v) => v.toJson()).toList();
    }
    data['stat'] = this.stat;
    return data;
  }
}

class Countrydata {
  Info info;
  int totalCases;
  int totalRecovered;
  int totalUnresolved;
  int totalDeaths;
  int totalNewCasesToday;
  int totalNewDeathsToday;
  int totalActiveCases;
  int totalSeriousCases;
  int totalDangerRank;

  Countrydata(
      {this.info,
        this.totalCases,
        this.totalRecovered,
        this.totalUnresolved,
        this.totalDeaths,
        this.totalNewCasesToday,
        this.totalNewDeathsToday,
        this.totalActiveCases,
        this.totalSeriousCases,
        this.totalDangerRank});

  Countrydata.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    totalCases = json['total_cases'];
    totalRecovered = json['total_recovered'];
    totalUnresolved = json['total_unresolved'];
    totalDeaths = json['total_deaths'];
    totalNewCasesToday = json['total_new_cases_today'];
    totalNewDeathsToday = json['total_new_deaths_today'];
    totalActiveCases = json['total_active_cases'];
    totalSeriousCases = json['total_serious_cases'];
    totalDangerRank = json['total_danger_rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    data['total_cases'] = this.totalCases;
    data['total_recovered'] = this.totalRecovered;
    data['total_unresolved'] = this.totalUnresolved;
    data['total_deaths'] = this.totalDeaths;
    data['total_new_cases_today'] = this.totalNewCasesToday;
    data['total_new_deaths_today'] = this.totalNewDeathsToday;
    data['total_active_cases'] = this.totalActiveCases;
    data['total_serious_cases'] = this.totalSeriousCases;
    data['total_danger_rank'] = this.totalDangerRank;
    return data;
  }
}

class Info {
  int ourid;
  String title;
  String code;
  String source;

  Info({this.ourid, this.title, this.code, this.source});

  Info.fromJson(Map<String, dynamic> json) {
    ourid = json['ourid'];
    title = json['title'];
    code = json['code'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ourid'] = this.ourid;
    data['title'] = this.title;
    data['code'] = this.code;
    data['source'] = this.source;
    return data;
  }
}