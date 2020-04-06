class CountryTimelineModel {
  List<Countrytimelinedata> countrytimelinedata;
  List<Timelineitems> timelineitems;

  CountryTimelineModel({this.countrytimelinedata, this.timelineitems});

  CountryTimelineModel.fromJson(Map<String, dynamic> json) {
    if (json['countrytimelinedata'] != null) {
      countrytimelinedata = new List<Countrytimelinedata>();
      json['countrytimelinedata'].forEach((v) { countrytimelinedata.add(new Countrytimelinedata.fromJson(v)); });
    }
    if (json['timelineitems'] != null) {
      timelineitems = new List<Timelineitems>();
      json['timelineitems'].forEach((v) { timelineitems.add(new Timelineitems.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countrytimelinedata != null) {
      data['countrytimelinedata'] = this.countrytimelinedata.map((v) => v.toJson()).toList();
    }
    if (this.timelineitems != null) {
      data['timelineitems'] = this.timelineitems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countrytimelinedata {
  InfoTimeline info;

  Countrytimelinedata({this.info});

  Countrytimelinedata.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new InfoTimeline.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    return data;
  }
}

class InfoTimeline {
  int ourid;
  String title;
  String code;
  String source;

  InfoTimeline({this.ourid, this.title, this.code, this.source});

  InfoTimeline.fromJson(Map<String, dynamic> json) {
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

class Timelineitems {

  String stat;
  List<TimeLine> listTimeLine = [];

  Timelineitems.fromJson( Map<String, dynamic> json) {

    json.forEach((key, value) {
      if (key  == 'stat'){

      }else{
        
        var arrayTime  = key.split('/');
        
        listTimeLine.add(
          
          
            TimeLine.fromjson( DateTime( arrayTime[2] == '20' ? 2020 : 2019,
              int.parse(arrayTime[0]),int.parse(arrayTime[1]) ) , value)
        );
      }
    });
  }
  void toJson(){
  }
}



class TimeLine {
  final DateTime time;
  final int new_daily_cases;
  final int new_daily_deaths;
  final int total_cases;
  final int total_recoveries;
  final int total_deaths;

  TimeLine({this.time, this.new_daily_cases, this.total_cases,
    this.new_daily_deaths, this.total_deaths, this.total_recoveries
  });

  TimeLine.fromjson(DateTime time, Map<String, dynamic> json)
      : time =  time,
        new_daily_cases = json['new_daily_cases'],
        new_daily_deaths = json['new_daily_deaths'],
        total_cases = json['total_cases'],
        total_recoveries = json['total_recoveries'],
        total_deaths = json['total_deaths'];
      



}