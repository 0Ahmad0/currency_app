
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_app/translations/locale_keys.g.dart';
import 'package:currency_app/view/resourse/assets_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/provider/chat_provider.dart';
import '../../../controller/provider/process_provider.dart';
import '../../../controller/provider/profile_provider.dart';
import '../../../model/models.dart';
import '../../../model/utils/app_sizer.dart';
import '../../../model/utils/const.dart';
import '../../resourse/color_manager.dart';
import '../../resourse/style_manager.dart';
import '../../resourse/values_manager.dart';
import 'dart:ui' as ui;
class ChatRoom extends StatefulWidget {
  ChatRoom({super.key, required this.name});
  final String name;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  var getChat;
  late ProfileProvider profileProvider;
  late ChatProvider chatProvider;
  late ProcessProvider processProvider;
  final textController=TextEditingController();
  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    getChatFun();
    super.initState();
  }

  getChatFun() async {
    getChat = chatProvider.fetchChatStream( idChat: chatProvider.chat.id);

    return getChat;
  }
  @override
  Widget build(BuildContext context) {
    chatProvider = Provider.of<ChatProvider>(context);
    processProvider = Provider.of<ProcessProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: GestureDetector(
        onTap: () {},
        child: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: ListTile(
            onTap: () {
              // Get.to(() => GroupSettingView(),
              //     transition: Transition.cupertinoDialog);
            },
            leading: Image.asset(
              AssetsManager.logoIMG,
              width: AppSize.s40,
              height: AppSize.s40,
            ),
            title: Text(
              processProvider.fetchLocalNameUser(idUser:widget.name),
              // "Alwasem ",
              // "Alwasem ",
              style: getBoldStyle(
                color: ColorManager.lightGray,
              ),
            ),
          ),
        ),
      )),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          StreamBuilder<QuerySnapshot>(
            //prints the messages to the screen0
              stream: getChat,
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
                    if(snapshot.data!.docs!.length>1){
                      chatProvider.chat.messages=Messages.fromJson(snapshot.data!.docs!).listMessage;
                    }
                    return  ListView.builder(
                      padding: const EdgeInsets.only(
                        bottom: AppPadding.p60,
                        left: AppPadding.p12,
                        right: AppPadding.p12,
                      ),
                      itemCount: chatProvider.chat.messages.length,
                      itemBuilder: (context, index) {
                        return MessageFile(
                          chatProvider: chatProvider,
                          index: index,
                        );
                      },
                    );
                    /// }));
                  } else {
                    return const Text('Empty data');
                  }
                }
                else {
                  return Text('State: ${snapshot.connectionState}');
                }
              }),
          Container(
            padding: const EdgeInsets.all(AppPadding.p8),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                      color: ColorManager.black.withOpacity(.3),
                      blurRadius: AppSize.s4)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: TextField(
                  controller: textController,
                  style: getRegularStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 15.sp
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: tr(LocaleKeys.type_here)
                  ),
                )),
                IconButton(
                    onPressed: () {
                      if(textController.text.trim().isNotEmpty){
                        chatProvider.addMessage(context, idChat: chatProvider.chat.id,
                            message: Message(textMessage: textController.text, senderId: profileProvider.user.id, receiveId: widget.name, sendingTime: DateTime.now()));
                        textController.clear();

                      }
                    },
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).cardColor,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MessageFile extends StatelessWidget {
  MessageFile({super.key, required this.index, required this.chatProvider});
  final ChatProvider chatProvider;
  late ProfileProvider profileProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    ProcessProvider processProvider = Provider.of<ProcessProvider>(context);
    bool checkSendMe=profileProvider.checkMeByIdUSer(idUser: chatProvider.chat.messages[index].senderId);

    return GestureDetector(
      onLongPress: () {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: "AppStrings.areYouSure",
          desc: "AppStrings.deleteThisMessage",
          btnCancelOnPress: () {

          },
          btnOkOnPress: () {
            chatProvider.deleteMessage(context, idChat: chatProvider.chat.id, message: chatProvider.chat.messages[index]);

          },
        )..show();
      },
      child: Container(
        // padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
        margin: EdgeInsets.only(
          top: AppMargin.m10,
          bottom: AppMargin.m10,
          left: checkSendMe? 0 : AppSizer.getW(context) / 5,
          right: !checkSendMe ? 0 : AppSizer.getW(context) / 5,
        ),
        decoration: BoxDecoration(
            color:
            checkSendMe ? ColorManager.thirdlyColor
                    : Theme.of(context).cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s14),
              topRight: Radius.circular(AppSize.s14),
              bottomLeft: Radius.circular(checkSendMe? 0 : AppSize.s14),
              bottomRight: Radius.circular(!checkSendMe ? 0 : AppSize.s14),
            ),
            boxShadow: [
              BoxShadow(
                  color: ColorManager.black.withOpacity(.5),
                  blurRadius: AppSize.s8)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p10
              ),
              child: Row(
                mainAxisAlignment: !checkSendMe
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Text(
                    checkSendMe?profileProvider.user.name:processProvider.fetchLocalNameUser(idUser: chatProvider.chat.messages[index].senderId),
                    //"Ahmad Alhariri",
                    style: getRegularStyle(
                        color: !checkSendMe?Colors.black:Theme.of(context).cardColor
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            ListTile(
                title: Text(chatProvider.chat.messages[index].textMessage)

            )
          ],
        ),
      ),
    );
  }
}
