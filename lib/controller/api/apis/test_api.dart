
import 'dart:io';

import 'package:http/http.dart';


import '../../app_url/app_url.dart';
import '../api_basic.dart';

class TestApi extends ApiBasic{

  Future<Map<String,dynamic>> load() async{
    final result= await getB(url: AppUrl.load);
    return result;
  }

  //  testFile(MultipartFile fileobj) async{
  //   File file =File.get();
  //   file.groupId=1;
  //   await multiRequest(url: AppUrl.createFile, listFileobj: [fileobj],token: "1",body: file.toJsonFile());
  //
  // }
}