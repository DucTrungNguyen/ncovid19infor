import 'package:ncov19infor/models/models.dart';
import 'package:flutter/material.dart';
import 'package:ncov19infor/repositories/repositories.dart';

class ApiRepositories{


  final ApiClient apiClient;
  ApiRepositories({@required this.apiClient}) : assert ( apiClient != null);

  Future<GeneralModel> getGeneralData() async{
    return apiClient.getGeneralData();
  }

  Future<List<TimeLine>> getCountryTimeline(String countryCode) async {
    final CountryTimelineModel  countryTimelineModel =await apiClient.getCountryTimeline(countryCode);

    return countryTimelineModel.timelineitems[0].listTimeLine;
//    return apiClient.getCountryTimeline(countryCode);
  }

  Future<Country> getCountryStatModel(String countryCode) async{

    CountryStatsModel countryStatsModel= await apiClient.getCountryStatModel(countryCode);

    Country country = Country(
      title: countryStatsModel.countrydata[0].info.title,
      ourid: countryStatsModel.countrydata[0].info.ourid,
      code: countryStatsModel.countrydata[0].info.code,
      source: countryStatsModel.countrydata[0].info.source,
      totalActiveCases: countryStatsModel.countrydata[0].totalActiveCases,
      totalCases: countryStatsModel.countrydata[0].totalCases,
      totalDeaths: countryStatsModel.countrydata[0].totalDeaths,
      totalNewCasesToday: countryStatsModel.countrydata[0].totalNewCasesToday,
      totalNewDeathsToday: countryStatsModel.countrydata[0].totalNewDeathsToday,
      totalRecovered: countryStatsModel.countrydata[0].totalRecovered,
      totalSeriousCases: countryStatsModel.countrydata[0].totalSeriousCases,
      totalUnresolved: countryStatsModel.countrydata[0].totalUnresolved

    );
    return country;

  }

  Future<AllCountryModel> getAllCountry () async {
    return apiClient.getAllCountryModel();
  }




}