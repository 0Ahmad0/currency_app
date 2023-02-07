import 'package:currency_app/model/models.dart';
import 'package:http/http.dart';

import 'dart:io' as io;

import '../../app_url/app_url.dart';
import '../api_basic.dart';
class CurrencyApi extends ApiBasic{
  String _apikey='LVatZDWxy9m971LGc3YU732QmAvtGSAV';
  Future<Map<String,dynamic>> convertCurrency(
      {required Convert convert}) async{
    String url='?to=${convert.to}&from=${convert.from}&amount=${convert.amount}';
    final result= await getB(url: '${AppUrl.convertCurrency}${url}',headers: {'apikey':_apikey});
   // final result= await multiRequest(url: AppUrl.convertCurrency,headers: {'apikey':_apikey}, body:convert.toJson());
    return result;
  }
  Future<Map<String,dynamic>> timeframeCurrency(
      {required TimeFrame timeFrame}) async{
    String url='?start_date=${timeFrame.startDate}&end_date=${timeFrame.endDate}';
    final result= await getB(url: '${AppUrl.timeframeCurrency}${url}',headers: {'apikey':_apikey});
   return result;
  }

  // createFile({required MultipartFile fileobj, required String token, required int groupId}) async{
  //   File file =File.get();
  //   file.groupId=groupId;
  //   return await multiRequest(url: AppUrl.createFile, listFileobj: [fileobj],token: token,body: file.toJsonFile());
  // }




}