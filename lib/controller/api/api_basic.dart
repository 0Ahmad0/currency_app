import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart';

import 'package:http/http.dart' as http;
class ApiBasic{
  var headers={
    "Accept":"application/json",
    "Content-Type":"application/json",

  };
  Future<Map<String,dynamic>> postB(
      {required String url,Map<String,String>headers=const{},String token="", body=const{}, bool isToken=true, onValue=onValue,onError=onError}) async{
    this.headers.addAll(headers);
    this.headers["token"]=token;
    return await post(
      Uri.parse( url)
      ,headers: this.headers,
      body: jsonEncode(body),
    ).then(onValue).catchError(onError);
  }
  Future<Map<String,dynamic>> multiRequest(
      {required String url,Map<String,String>headers=const{}, List<MultipartFile> listFileobj=const[],String token="",Map<String,String> body=const{}, bool isToken=true, onValue=onValue,onError=onError,String typeRequest='GET'}) async{
    this.headers.addAll(headers);
    this.headers["token"]=token;

    var request = http.MultipartRequest(
        typeRequest, Uri.parse(url));
    request.headers.addAll(this.headers);
   // request.fields['body'] = jsonEncode(body);
    request.fields.addAll(body);
    //request.files.addAll(listFileobj);

    var result=await request.send().then((value) async => onValue(await http.Response.fromStream(value)));

    return result!=null?result:error();
  }
  Future<Map<String,dynamic>> deleteB(
      {required String url,Map<String,String> headers=const{},String token="", body=const{}, bool isToken=true, onValue=onValue,onError=onError}) async{
    this.headers.addAll(headers);
    this.headers["token"]=token;
    return await delete(
      Uri.parse( url)
      ,headers: this.headers,
      body: jsonEncode(body),
    ).then(onValue).catchError(onError);
  }
  Future<Map<String,dynamic>> getB(
      {required String url,Map<String,String> headers=const{},String token="",bool isToken=true, onValue=onValue,onError=onError}) async{
    this.headers.addAll(headers);
    this.headers["token"]=token;
    return await get(
      Uri.parse( url)
      ,headers: this.headers
    ).then(onValue).catchError(onError);
  }
  static Future<Map<String,dynamic>> onValue(http.Response response)async{
    var result;
    final Map<String,dynamic> responseData= json.decode(response.body);
    if(response.statusCode==200||response.statusCode==201||response.statusCode==202){

      result ={
        'status':true,
        'message':"Successful Request",
        'data':responseData["body"]!=null?responseData["body"]:responseData
      };
    }
    else {
      result ={
        'status':false,
        'message':responseData["msg"]!=null?responseData["msg"]:'UnSuccessful Request',
        'data':responseData
      };
    }
    return result;
  }
  static onError(error){

    return {
      'status':false,
      'message':"Unsuccessful Request",
      'data':error==null?"":error
    };
  }
  static error(){

    return {
      'status':false,
      'message':"Unsuccessful Request",
      //'data':error==null?"":error
    };
  }
}