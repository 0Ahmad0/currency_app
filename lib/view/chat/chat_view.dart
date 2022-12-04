import 'package:currency_app/view/resourse/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'widgets/chat_room.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      itemBuilder: (ctx,index)=> ChatItem(
        index: index,
        name: "${index+10*2/3} Alwaseem",
        img: AssetsManager.logoIMG,
        lastMSG: 'last message',
      ),
      separatorBuilder: (BuildContext context, int index)=>Divider(
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final String? img;
  final String name;
  final String lastMSG;
  final int index;

  const ChatItem({super.key, this.img, required this.name, required this.index, required this.lastMSG});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()=>Get.to(()=>ChatRoom()),
      leading: CircleAvatar(
        backgroundImage: AssetImage(img??AssetsManager.logoIMG),

      ),
      title: Text(name),
      subtitle: Text(lastMSG),
    );
  }
}

