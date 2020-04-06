import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:ncov19infor/models/models.dart';

class ApiClient{
  static const baseUrl =  'https://thevirustracker.com/free-api';
  Dio _dio;
  ApiClient(){
    BaseOptions options = BaseOptions(
      receiveTimeout: 10000,
      connectTimeout: 10000,
      baseUrl: baseUrl,
    );
    _dio = Dio(options);
  }

  Future<GeneralModel> getGeneralData () async{
    final url = '$baseUrl?global=stats';

    try{
      final response = await _dio.get(url);
//      GeneralModel  generalMode= GeneralModel.fromJson(response.data);
//      print(generalMode.results);
      return GeneralModel.fromJson(response.data);

    }on DioError catch(e){
      print(e.error);
      throw e.error;
    }
  }

  Future<http.Response> getcountryNews(String countryCode) async {
    final url = '$baseUrl?countryNewsTotal=$countryCode';
    return await http.get(url);
  }


  Future<CountryTimelineModel> getCountryTimeline(String countryCode) async{
    final url = '$baseUrl?countryTimeline=$countryCode';
    try{
      final response = await _dio.get(url);
      //print(response.data);

//      CountryTimelineModel countryTimelineModel=
//      print(countryTimelineModel.timelineitems[0].listTimeLine);

      return CountryTimelineModel.fromJson(response.data);


    } on DioError catch(e){
      print(e.error);
      throw e.error;
    }
  }

  Future<CountryStatsModel> getCountryStatModel(String countryCode) async{
    final url = '$baseUrl?countryTotal=$countryCode';

    try {
      final repsone = await _dio.get(url);
//      CountryStatsModel countryStatsModel  =
//      print(countryStatsModel);
      return CountryStatsModel.fromJson(repsone.data);;

    } on DioError catch (e){
      print(e.error);
      throw e.error;
    }
  }
  Future<AllCountryModel> getAllCountryModel() async{
    final url = '$baseUrl?countryTotals=ALL';
    try {
      final respone = await _dio.get(url);
      return AllCountryModel.fromJson(respone.data);
    }on DioError catch(e){
      print(e.error);
      throw e.error;
    }
  }

}