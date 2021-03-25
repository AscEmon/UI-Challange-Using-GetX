import 'dart:convert';
import 'package:Uparjon/Model/CategoryModel.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://app.ringersoft.com/api/ringersoftfoodapp/test-category/2?fbclid=IwAR3OfylOShIlzWs7pQEt5kLSyBfQhLrjhlWcbA4P6GIr-GUj0WDQaDgjTd0';

class MyApiClient {
  final http.Client httpClient;
  MyApiClient({@required this.httpClient});

//Category Api Calling
  getAll() async {
    try {
      var response = await httpClient.get(baseUrl,);
       print("This is StatusCode in APIPROVIDER:: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Done category");
         String jsonResponseString=response.body;
         print(response.body);
         return categoryModelFromJson(jsonResponseString);
      } else
        print('Please check your internet Connnection');
    } catch (_) {}
  }


}
