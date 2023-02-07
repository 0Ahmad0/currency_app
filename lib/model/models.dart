import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


//advance
class Advance {
  static bool theme = false;
  static bool language = false;
  static bool isRegisterKEY = false;
  static bool isLogined = false;
  static String token = "";
  static String uid = "";
  static String avatarImage = "";
}
//user
class User {
  String id;
  String uid;
  String name;
  String photoUrl;
  String email;
  String phoneNumber;
  String password;
  String typeUser;
  String description;

  String gender;
  bool active;
  DateTime dateBirth;
  List<String> tokens;
  List<String> favourite;

  String location;
  String latitude;
  String longitude;
  String amount;
  double distanceKm;
  User({
    required this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.typeUser,
    required this.photoUrl,
    required this.gender,
    required this.dateBirth,
    this.description = "",
    this.longitude = "0",
    this.latitude = "0",
    this.amount = "0",
    this.location = "",
    this.distanceKm = 0,

    this.active = false,
    this.tokens = const[],
    this.favourite = const[],
  });

  factory User.fromJson(json) {
    List<String> listTemp=[];
    for (String temp in json['favourite']) {
      listTemp.add(temp);
    }
    //print(json);
    return User(
        id: json['id'],
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        typeUser: json["typeUser"],
        photoUrl: json["photoUrl"],
        gender: json["gender"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        amount: json["amount"],
        location: json["location"],
        favourite: listTemp,

        active: json["active"],
        dateBirth: json["dateBirth"].toDate(),
       // tokens: json["tokens"],
        description: (json["description"] != null) ? json["description"] : "");
  }
  factory User.init(){
    return User(id: "", uid: '', name: '', email: '', phoneNumber: '', password: '', typeUser: '', photoUrl: "", gender: "", dateBirth: DateTime.now());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
        'typeUser': typeUser,
        'gender': gender,
        'dateBirth':Timestamp.fromDate(dateBirth),

        'favourite': favourite,
        'location': location,
        'longitude': longitude,
        'latitude': latitude,
        'amount': amount,
        'photoUrl': photoUrl,
        'description': description,
        'active': active,
        'tokens': tokens,
      };
}
//users
class Users {
  List<User> users;

  //DateTime date;

  Users({required this.users});

  factory Users.fromJson(json) {
    List<User> tempUsers = [];

    for (int i = 0; i < json.length; i++) {
      User tempUser = User.fromJson(json[i]);
      tempUser.id = json[i].id;
      tempUsers.add(tempUser);
    }
    return Users(users: tempUsers);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> tempUsers = [];
    for (User user in users) {
      tempUsers.add(user.toJson());
    }
    return {
      'users': tempUsers,
    };
  }
}

//dateDay
class DateDay {
  String id;
  TimeOfDay? from;
  TimeOfDay? to;
  DateDay({
     this.id="",
    required this.from,
    required this.to,
  });

  factory DateDay.fromJson(json) {
    return DateDay(
        id: json['id'],
        from: (json["from"]==null)?json["from"]: TimeOfDay.fromDateTime(json["from"].toDate()),
        to: (json["to"]==null)?json["to"]:TimeOfDay.fromDateTime(json["to"].toDate()),);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'from': (from==null)?from:DateTime(2000,1,1,from!.hour,from!.minute),
   // 'from': (from==null)?from:DateTime.fromMillisecondsSinceEpoch(((from!.hour-3)*60+from!.minute)*60000),
    'to': (to==null)?to:DateTime(2000,1,1,to!.hour,to!.minute),
  };
}
//dateLawyer
class DateLawyer {
  String id;
  String idLawyer;
  Map<String,dynamic> dateDays;
  DateLawyer({
    this.id="",
    required this.dateDays,
    required this.idLawyer,
  });

  factory DateLawyer.fromJson(json) {
    Map<String,dynamic> temp={};
    for(var element in json['dateDays'].keys){
      temp[element]=DateDay.fromJson(json['dateDays'][element]);
    }
    return DateLawyer(
      id: json['id'],
        idLawyer: json['idLawyer'],
    dateDays: temp);
  }

  Map<String, dynamic> toJson() {
    Map<String,dynamic> temp={};
    for(var element in dateDays.keys){
      temp[element]=dateDays[element].toJson();
    }
    return {
    'id': id,
    'idLawyer': idLawyer,
    'dateDays': temp,
  };
  }
}
//DateLawyers
class DateLawyers {
  List<DateLawyer> listDateLawyer;

  //DateTime date;

  DateLawyers({required this.listDateLawyer});

  factory DateLawyers.fromJson(json) {
    List<DateLawyer> temp = [];
    for (int i = 0; i < json.length; i++) {
      DateLawyer tempElement = DateLawyer.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return DateLawyers(listDateLawyer: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in listDateLawyer) {
      temp.add(element.toJson());
    }
    return {
      'listDateLawyer': temp,
    };
  }
}

//Internship
class Internship {
  String id;
  String idLawyer;
  String internshipOpportunity;
  String price;
  Internship({
    this.id="",
    required this.internshipOpportunity,
    required this.idLawyer,
    required this.price,
  });

  factory Internship.fromJson(json) {

    return Internship(
        id: json['id'],
        idLawyer: json['idLawyer'],
        internshipOpportunity: json['internshipOpportunity'],
        price: json['price']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idLawyer': idLawyer,
      'internshipOpportunity': internshipOpportunity,
      'price': price,
    };
  }
}
//Internships
class Internships {
  List<Internship> listInternship;

  //DateTime date;

  Internships({required this.listInternship});

  factory Internships.fromJson(json) {
    List<Internship> temp = [];
    for (int i = 0; i < json.length; i++) {
      Internship tempElement = Internship.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return Internships(listInternship: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in listInternship) {
      temp.add(element.toJson());
    }
    return {
      'listInternship': temp,
    };
  }
}


//DateO
class DateO {
  String id;
  String idLawyer;
  String idUser;
  String specialtyLawyer;
  String subjectConsultation;
  DateTime dateTime;
  bool notificationLawyer;
  bool notificationUser;
  DateO({
    this.id="",
    required this.idUser,
    required this.idLawyer,
    required this.specialtyLawyer,
    required this.subjectConsultation,
     this.notificationLawyer=false,
     this.notificationUser=false,
    required this.dateTime,
  });

  factory DateO.fromJson(json) {

    return DateO(
        id: json['id'],
        idUser: json['idUser'],
        idLawyer: json['idLawyer'],
        specialtyLawyer: json['specialtyLawyer'],
        subjectConsultation: json['subjectConsultation'],
    notificationLawyer: json['notificationLawyer'],
        notificationUser: json['notificationUser'],
        dateTime: json['dateTime'].toDate());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idUser': idUser,
      'idLawyer': idLawyer,
      'specialtyLawyer': specialtyLawyer,
      'subjectConsultation': subjectConsultation,
      'notificationLawyer': notificationLawyer,
      'notificationUser': notificationUser,
      'dateTime': dateTime,
    };
  }
  factory DateO.init(){
    return DateO(idUser: "", idLawyer: "", specialtyLawyer: "", subjectConsultation: "", dateTime: DateTime.now());
  }
}

//DateOs
class DateOs {
  List<DateO> listDateO;

  //DateTime date;

  DateOs({required this.listDateO});

  factory DateOs.fromJson(json) {
    List<DateO> temp = [];
    for (int i = 0; i < json.length; i++) {
      DateO tempElement = DateO.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return DateOs(listDateO: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in listDateO) {
      temp.add(element.toJson());
    }
    return {
      'listDateO': temp,
    };
  }
}
//Message
class Message {
  String id;
  // bool checkSend;
  // int index;
  String textMessage;
  // int sizeFile;
  // String url;
  // String urlTempPhoto;
  // String localUrl;
  // String typeMessage;
  String senderId;
  String receiveId;
  // String replayId;
  DateTime sendingTime;
  // List deleteUserMessage;
  Message(
      {this.id="",
       // this.index=-1,
        // this.sizeFile=0,
        // this.checkSend=true,
        required this.textMessage,
        // this.url="",
        // this.urlTempPhoto="",
        // this.localUrl="",
        // required this.replayId,
        // required this.typeMessage,
        required this.senderId,
        required this.receiveId,
        // required this.deleteUserMessage,
        required this.sendingTime});
  factory Message.fromJson( json){
    // List<String> tempDeleteUserMessage = [];
    // for(String user in json["deleteUserMessage"]){
    //   tempDeleteUserMessage.add(user);
    // }
    // String tempUrl="";
    // if(!json["typeMessage"].contains(ChatMessageType.text.name)){
    //   tempUrl=json["url"];
    // }
    // String tempLocalUrl="";
    // if(json.data().containsKey("localUrl")){
    //   tempLocalUrl=json["localUrl"];
    // }
    // int tempSizeFile=0;
    // if(json.data().containsKey("sizeFile")){
    //   tempSizeFile=json["sizeFile"];
    // }
    // String tempUrlTempPhoto="";
    // if(json.data().containsKey("urlTempPhoto")){
    //   tempUrlTempPhoto=json["urlTempPhoto"];
    // }
    return Message(
        // url: tempUrl,
        // localUrl: tempLocalUrl,
        textMessage: json["textMessage"],
       // typeMessage: json["typeMessage"],
        sendingTime: (json["sendingTime"].runtimeType.toString().contains('DateTime'))?json["sendingTime"]:json["sendingTime"].toDate(),
        senderId: json["senderId"],
        receiveId: json["receiveId"],
        // deleteUserMessage: tempDeleteUserMessage,
        // urlTempPhoto: tempUrlTempPhoto,
        // sizeFile: tempSizeFile,
       // replayId: json["replayId"]
    );
  }
  Map<String,dynamic> toJson() {
    // List tempDeleteUserMessage = [];
    // for(String user in deleteUserMessage){
    //   tempDeleteUserMessage.add(user);
    // }
    return {
      'textMessage': textMessage,
    //  'typeMessage': typeMessage,
      'senderId': senderId,
      'receiveId': receiveId,
      'sendingTime': sendingTime,
      // 'deleteUserMessage': tempDeleteUserMessage,
      // 'urlTempPhoto': urlTempPhoto,
      // 'sizeFile': sizeFile,
      // 'replayId': replayId,
      // 'url': url,
      // 'localUrl': localUrl,
    };
  }
  factory Message.init(){
    return Message(textMessage: '', senderId: '', receiveId: '', sendingTime: DateTime.now());
  }
}
//Messages
class Messages {
  List<Message> listMessage;



  Messages({required this.listMessage});

  factory Messages.fromJson(json) {
    List<Message> temp = [];
    for (int i = 1; i < json.length; i++) {
      Message tempElement = Message.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return Messages(listMessage: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in listMessage) {
      temp.add(element.toJson());
    }
    return {
      'listMessage': temp,
    };
  }
}
//Chat
class Chat {
  String id;
  List<Message> messages;
  List<String> listIdUser;
  DateTime date;

  Chat({
     this.id='',
    required this.messages,
     required this.listIdUser,
    required this.date,
  });
  factory Chat.fromJson( json){
    List<Message> listTemp = [];
    // for(int i=1;i<json['messages'].length;i++){
    //   Message tempMessage=Message.fromJson(json['messages'][i]);
    //   tempMessage.id=json['messages'][i].id;
    //   listTemp.add(tempMessage);
    // }
    List<String> listTemp2=[];
    for(String temp in json['listIdUser'])
       listTemp2.add(temp);
    return Chat(
        id: json['id'],
        listIdUser: listTemp2,
        messages: listTemp,//json["messages"],
        date: json["date"].toDate(),
    );
  }

  Map<String,dynamic> toJson(){
    List<Map<String,dynamic>> listTemp = [];
    for(Message message in messages){
      listTemp.add(message.toJson());
    }
    return {
      'id':id,
      'date':date,
     // 'messages':listTemp,
      'listIdUser':listIdUser,
    };
  }
  factory Chat.init(){
    return Chat(messages: [], listIdUser: [], date: DateTime.now());
  }
}

//Chats
class Chats {
  List<Chat> listChat;

  //DateTime date;

  Chats({required this.listChat});

  factory Chats.fromJson(json) {
    List<Chat> temp = [];
    for (int i = 0; i < json.length; i++) {
      Chat tempElement = Chat.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return Chats(listChat: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in listChat) {
      temp.add(element.toJson());
    }
    return {
      'listChat': temp,
    };
  }
}



//Convert
class Convert {
  String from;
  String to;
  double amount;
  Convert({
   required this.from,
   required this.to,
   required this.amount,
  });

  factory Convert.fromJson(json) {
    return Convert(
      from: json['from'],
      to: json["to"],
      amount: json["amount"].toDouble(),
       );
  }
  factory Convert.init(){
    return Convert(from: '',to: '',amount: 0);
  }

  Map<String, String> toJson() => {
    'from': from,
    'to': to,
    'amount': amount.toString(),
  };
}
//InfoConvert
class InfoConvert {
  DateTime timestamp;
  double quote;
  InfoConvert({
    required this.timestamp,
    required this.quote,
  });

  factory InfoConvert.fromJson(json) {
    return InfoConvert(
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
      quote: json["quote"],
    );
  }
  factory InfoConvert.init(){
    return InfoConvert(timestamp: DateTime.now(),quote: 0);
  }

  Map<String, dynamic> toJson() => {
    'timestamp': Timestamp.fromDate(timestamp),
    'quote': quote,
  };
}
//CurrencyConvert
class CurrencyConvert {
  Convert convert;
  InfoConvert infoConvert;
  double result;
  CurrencyConvert({
    required this.convert,
    required this.infoConvert,
    required this.result,
  });

  factory CurrencyConvert.fromJson(json) {
    return CurrencyConvert(
      convert: Convert.fromJson(json['query']),
      infoConvert: InfoConvert.fromJson(json['info']),
      result: json["result"],
    );
  }
  factory CurrencyConvert.init(){
    return CurrencyConvert(convert: Convert.init(), infoConvert: InfoConvert.init(), result: 0);
  }

  Map<String, dynamic> toJson() => {
    'query':convert.toJson(),
    'info': infoConvert.toJson(),
    'result': result,
  };
}


//TimeFrame
class TimeFrame {
  String startDate;
  String endDate;
  String source;
  double maxValue;
  Map<String,dynamic> quotes;
  Map<String,dynamic> chart;
  TimeFrame({
    required this.startDate,
    required this.endDate,
     this.source='',
     this.maxValue=0,
     this.quotes=const{},
     this.chart=const{},
  });

  factory TimeFrame.fromJson(json) {
    return TimeFrame(
      startDate: json["start_date"],
      endDate: json["end_date"],
      source: json["source"],
      quotes: json["quotes"],
    );
  }
  factory TimeFrame.init(){
    return TimeFrame(startDate: '', endDate: '');
  }

  Map<String, dynamic> toJson() => {
    'start_date': startDate,
    'end_date': endDate,
    'source': source,
    'quotes': quotes,
  };
}

/*
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys
flutter build apk --split-per-abi
temp@gmail.com   123456
 */
