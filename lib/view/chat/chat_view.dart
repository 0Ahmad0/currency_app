import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_app/view/resourse/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/chat_provider.dart';
import '../../controller/provider/process_provider.dart';
import '../../controller/provider/profile_provider.dart';
import '../../model/models.dart';
import '../../model/utils/const.dart';
import 'widgets/chat_room.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  var getChats;
  late ProfileProvider profileProvider;
  late ChatProvider chatProvider;
  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    getChatsFun();
    super.initState();
  }

  getChatsFun() async {
    getChats = chatProvider.fetchChatsStream(profileProvider.user.id);

    return getChats;
  }
  @override
  Widget build(BuildContext context) {
    chatProvider = Provider.of<ChatProvider>(context);
    return StreamBuilder<QuerySnapshot>(
      //prints the messages to the screen0
        stream: getChats,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return
              Const.SHOWLOADINGINDECATOR();

          }
          else if (snapshot.connectionState ==
              ConnectionState.active) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              Const.SHOWLOADINGINDECATOR();
              if(snapshot.data!.docs!.length>0){
                chatProvider.chats=Chats.fromJson(snapshot.data!.docs!);
              }

              return ListView.separated(
                itemCount: chatProvider.chats.listChat.length,
                itemBuilder: (ctx,index)=> ChatItem(
                  chatProvider: chatProvider,
                  index: index,
                  name: (profileProvider.user.id.contains(chatProvider.chats.listChat[index].listIdUser[0]))
                      ?chatProvider.chats.listChat[index].listIdUser[1]
                      :chatProvider.chats.listChat[index].listIdUser[0],//"${index+10*2/3} Alwaseem",
                  img: AssetsManager.logoIMG,
                  lastMSG: chatProvider.chats.listChat[index].id,//'last message',
                ),
                separatorBuilder: (BuildContext context, int index)=>Divider(
                  color: Theme.of(context).primaryColor,
                ),
              );
              /// }));
            } else {
              return const Text('Empty data');
            }
          }
          else {
            return Text('State: ${snapshot.connectionState}');
          }
        });
  }
}

class ChatItem extends StatelessWidget {
  final String? img;
  final String name;
  final String lastMSG;
  final int index;
  late ProcessProvider processProvider;
  final ChatProvider chatProvider;
   ChatItem({super.key, this.img, required this.name, required this.index, required this.lastMSG, required  this.chatProvider});
  @override
  Widget build(BuildContext context) {
    processProvider= Provider.of<ProcessProvider>(context);
    return ListTile(
      onTap: (){
        chatProvider.chat= chatProvider.chats.listChat[index];
        Get.to(()=>
            ChatRoom(name: name,));},
      leading: CircleAvatar(
        backgroundImage: AssetImage(img??AssetsManager.logoIMG),

      ),
      title: fetchName(context,name),
      subtitle: fetchLastMessage(context,lastMSG),
    );
  }
  fetchName(BuildContext context,String idUser){
    return processProvider.widgetNameUser(context, idUser: idUser);
  }
  fetchLastMessage(BuildContext context,String idChat){
    return ChatProvider().widgetLastMessage(context, idChat: idChat);
  }
}

