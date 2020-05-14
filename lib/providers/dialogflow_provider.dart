import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dialogflowtopicos/models/fullfillment_model.dart';
import 'package:dialogflowtopicos/models/meta_data_model.dart';

class DialogflowProvider{

  final String _url = 'https://api.dialogflow.com/v1/query?v=20150910';

  //En esta parte ponele tu api key
  final headers = {
  'Authorization': 'Bearer <API_KEY>',
  'Content-Type': 'text/plain'
  };

  Future<http.Response> _cargarDatos(String datos) async{

   final resp = await http.post(_url,
       headers: headers,
       body: jsonEncode({
     "contexts": [
       "shop"
     ],
     "lang": "es",
     "query": datos,
     "sessionId": "12345",
     "timezone": "America/Barbados"
   }));

    return resp;
  }

  Future<String> getIntentName(String datos) async {
    final resp = await _cargarDatos(datos);
    final decodedData = json.decode(resp.body);
    final metadata =new Metadata.fromJson(decodedData['result']['metadata']) ;
    return metadata.intentName;
  }

  Future<String> getBotMessage(String datos) async {
    final resp = await _cargarDatos(datos);
    final decodedData = json.decode(resp.body);
    final fulfillment =new Fulfillment.fromJson(decodedData['result']['fulfillment']) ;
    return fulfillment.speech;
  }


}