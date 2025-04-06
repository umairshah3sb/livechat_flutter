import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:livechat/model/message_model.dart';
import 'package:livechat/model/user_model.dart';
import 'package:livechat/screen/chat/controller/chatController.dart';
import 'package:livechat/screen/chat/widget/my_text_message.dart';
import 'package:livechat/screen/chat/widget/other_text_message.dart';
import 'package:livechat/utils/constant.dart';
import 'package:livechat/utils/exporter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ConversationScreen extends StatefulWidget {
  String userId;
  ConversationScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  ChatController controller = Get.put(ChatController());
  TextEditingController messageController = TextEditingController();
  List<String?> picPaths = [];
  String messageType = 'text';
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future<void> getUser() async {
    controller.userId = widget.userId;
    getChat();
    await controller.getUser();
  }

  Future<void> getChat() async {
    await controller.getChat();
  }

  Future<void> sendMessage() async {
    if (messageController.text.trim().isNotEmpty) {
      Timer(Duration(milliseconds: 300), () {
        messageController.text = '';
        picPaths = [];
        setState(() {});
      });
      List<String> paths = [];
      if (picPaths.isNotEmpty) {
        for (var path in picPaths) {
          paths.add(path!);
        }
      }
      await controller.sendMessage(
        recId: controller.userId,
        message: messageController.text.trim(),
        messageType: messageType,
        files: paths,
      );
      getChat();
    }
  }

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null) {
      picPaths = result.paths;
      messageType = 'image';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ChatController>(builder: (chatController) {
          return chatController.isLoading
              ? loadingSpinner()
              : chatController.recProfile == null
                  ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            size: 40,
                            color: black,
                          ),
                          gap(w: 10),
                          Text(
                            'Error',
                            style: TextStyle(
                              fontSize: 18,
                              color: black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        chatBar(chatController.recProfile!),
                        Expanded(
                          child: ScrollablePositionedList.builder(
                            padding: spacOnly(bottom: 30),
                            itemCount: controller.chat.length,
                            initialScrollIndex: (controller.chat.length - 1),
                            itemBuilder: (context, i) {
                              return controller.MessageWidgetType(
                                  controller.chat[i]);
                            },
                            itemScrollController: itemScrollController,
                            scrollOffsetController: scrollOffsetController,
                            itemPositionsListener: itemPositionsListener,
                            scrollOffsetListener: scrollOffsetListener,
                          ),
                        ),
                        picPaths.isNotEmpty
                            ? Row(
                                children: picPaths.map((pic) {
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    margin: spacing(h: 3),
                                    child: ClipRRect(
                                      borderRadius: circularRadius(8),
                                      child: Image.file(
                                        File(pic!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )
                            : gap(),
                        Container(
                          margin: spacing(h: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return ChatMediaOption();
                                    },
                                  );
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 1,
                                      color: black,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: glassShadow,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 30,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: spacing(h: 7),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 1,
                                      color: black,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: glassShadow,
                                  ),
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: InputDecoration(
                                      hintText: 'Type a message',
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      contentPadding: spacOnly(
                                        top: 0,
                                        left: 15,
                                        right: 20,
                                      ),
                                    ),
                                    maxLines:
                                        messageController.text.length > 150
                                            ? 4
                                            : null,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  sendMessage();
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      width: 1,
                                      color: black,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: glassShadow,
                                  ),
                                  child: Icon(
                                    Icons.send,
                                    size: 30,
                                    color: black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        gap(h: 15),
                      ],
                    );
        }),
      ),
    );
  }

  Container chatBar(UserModel recProfile) {
    return Container(
      padding: spacing(h: 10, v: 5),
      decoration: BoxDecoration(
        color: white,
        borderRadius: radiusOnly(
          topLeft: 10,
          topRight: 10,
          bottomLeft: 10,
        ),
        boxShadow: glassShadow,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: black,
            ),
          ),
          gap(w: 10),
          CircleAvatar(
            radius: 20,
            foregroundImage: NetworkImage(
              recProfile.avatar != null
                  ? recProfile.avatar!
                  : recProfile.profilePhotoUrl!,
            ),
          ),
          gap(w: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recProfile.username,
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  color: black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Online',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Spacer(),
          Icon(
            BootstrapIcons.camera_video,
            color: black,
            size: 24,
          ),
          gap(w: 15),
          Icon(
            Icons.call_outlined,
            color: black,
            size: 24,
          ),
          gap(w: 15),
          Icon(
            Icons.more_vert,
            color: black,
            size: 24,
          ),
          gap(w: 15),
        ],
      ),
    );
  }

  Container ChatMediaOption() {
    return Container(
      height: Get.height * 0.25,
      padding: spacOnly(top: 25),
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        borderRadius: radiusOnly(
          topLeft: 10,
          topRight: 10,
          bottomLeft: 10,
        ),
        boxShadow: shadow,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          MediaOptionItem(
              icon: Icons.image,
              title: 'Image',
              onTap: () {
                pop();
                pickImage();
              }),
          MediaOptionItem(
            icon: BootstrapIcons.camera_video,
            title: 'Video',
          ),
          MediaOptionItem(
            icon: Icons.attachment_outlined,
            title: 'Attachment',
          ),
          MediaOptionItem(
            icon: Icons.location_on,
            title: 'Location',
          ),
          MediaOptionItem(
            icon: Icons.headphones,
            title: 'Audio',
          ),
          MediaOptionItem(
            icon: Icons.file_open,
            title: 'Document',
          ),
        ],
      ),
    );
  }

  Widget MediaOptionItem({
    required IconData icon,
    required String title,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: spacing(h: 10, v: 5),
        child: Column(
          children: [
            Container(
              padding: spacing(h: 7, v: 7),
              decoration: BoxDecoration(
                color: white,
                borderRadius: radiusOnly(
                  topLeft: 10,
                  topRight: 10,
                  bottomLeft: 10,
                ),
                boxShadow: glassShadow,
              ),
              child: Icon(
                icon,
                size: 30,
              ),
            ),
            gap(h: 10),
            Text(
              title,
              style: GoogleFonts.manrope(
                fontSize: 12,
                color: black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
