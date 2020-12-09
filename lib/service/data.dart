import 'dart:convert';
import 'dart:io';
import 'package:covidapi_app/model/covid_data_model.dart';
import 'package:http/http.dart' as http;

class Data {
  var baseUrl = 'https://covid-api.mmediagroup.fr/v1/cases';

  //down here is take data from Json data using List method
  Future<CovidDataModel> getData(String countryName) async {
    try {
      http.Response response = await http.get(baseUrl);
      var results = response.body;
      var decodeData = jsonDecode(results);
      var constModel = jsonDecode(results)[countryName]['All'];
      var deaths = constModel['deaths'];
      CovidDataModel covidDataModel = new CovidDataModel(
          countryName: countryName,
          confirmed: constModel['confirmed'],
          recovered: constModel['recovered'],
          updateTime: constModel['updated'],
          deaths: constModel['deaths'],
          location: constModel['location']);
      return covidDataModel;
    } catch (e) {
      print(e);
    }
  }

  // down here is how to take data from JSON data of Map format
  Future<List> getCountry() async {
    http.Response response = await http.get(baseUrl);
    var results = response.body;
    var decode = jsonDecode(results);
    Map<String, dynamic> map = Map.from(decode);
    var list = map.values.toList();
    var listName = map.keys.toList();
    print(listName);
    return listName;
  }
}
