class AllCountryModel {
  List<Sitedata> sitedata;
  List<Countryitems> countryitems;

  AllCountryModel({this.sitedata, this.countryitems});

  AllCountryModel.fromJson(Map<String, dynamic> json) {
    if (json['sitedata'] != null) {
      sitedata = new List<Sitedata>();
      json['sitedata'].forEach((v) { sitedata.add(new Sitedata.fromJson(v)); });
    }
    if (json['countryitems'] != null) {
      countryitems = new List<Countryitems>();
      json['countryitems'].forEach((v) { countryitems.add(new Countryitems.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sitedata != null) {
      data['sitedata'] = this.sitedata.map((v) => v.toJson()).toList();
    }
    if (this.countryitems != null) {
//      data['countryitems'] = this.countryitems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sitedata {
  InfoAllCountry info;

  Sitedata({this.info});

  Sitedata.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new InfoAllCountry.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    return data;
  }
}

class InfoAllCountry {
  String source;

  InfoAllCountry({this.source});

  InfoAllCountry.fromJson(Map<String, dynamic> json) {
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    return data;
  }
}

class Countryitems{

  String stat;
  List<Country> listCountry = [];

  Countryitems.fromJson(Map<String, dynamic> json){
    json.forEach((key, value) {
      if ( key != 'stat'){
       listCountry.add(Country.fromJson(value));
      }
    });

  }

}

class Country {
  final int ourid;
  final String title;
  final String code;
  final String source;
  final int totalCases;
  final int totalRecovered;
  final int totalUnresolved;
  final int totalDeaths;
  final int totalNewCasesToday;
  final int totalNewDeathsToday;
  final int totalActiveCases;
  final int totalSeriousCases;

  Country({this.ourid, this.title, this.code, this.source, this.totalCases,
    this.totalRecovered, this.totalUnresolved, this.totalDeaths, this.totalNewCasesToday,
    this.totalNewDeathsToday, this.totalActiveCases,this.totalSeriousCases
  });

  Country.fromJson(Map<String, dynamic> json)
      :ourid = json['ourid'],
        title = json['title'],
        code = json['code'],
        source = json['source'],
        totalCases = json['total_cases'],
        totalRecovered = json['total_recovered'],
        totalUnresolved = json['total_unresolved'],
        totalDeaths = json['total_deaths'],
        totalNewCasesToday = json['total_new_cases_today'],
        totalNewDeathsToday = json['total_new_deaths_today'],
        totalActiveCases = json['total_active_cases'],
        totalSeriousCases = json['total_serious_cases'];



}
