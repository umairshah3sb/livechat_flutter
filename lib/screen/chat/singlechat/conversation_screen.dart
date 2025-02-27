import 'package:livechat/utils/exporter.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
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
                      foregroundImage: AssetImage('assets/img/profile.jpeg'),
                    ),
                    gap(w: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'The Code Pie',
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
              ),
              Expanded(
                child: SingleChildScrollView(
                  reverse: false,
                  padding: spacOnly(bottom: 20),
                  child: Column(
                    children: List.generate(
                      15,
                      (i) {
                        return i.isEven ? MyMessage() : OtherMessage();
                      },
                    ),
                  ),
                ),
              ),
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
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: black,
                              fontWeight: FontWeight.w700,
                            ),
                            contentPadding: spacOnly(top: 0, left: 15),
                          ),
                        ),
                      ),
                    ),
                    Container(
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
                  ],
                ),
              ),
              gap(h: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget OtherMessage() {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          Container(
            width: Get.width * 0.75,
            padding: spacing(h: 10, v: 10),
            margin: spacOnly(
              left: 10,
              top: 5,
              bottom: 5,
            ),
            decoration: BoxDecoration(
              color: black,
              borderRadius: radiusOnly(
                topLeft: 10,
                topRight: 10,
                bottomRight: 10,
              ),
              boxShadow: glassShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The Code Pie',
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    color: white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                gap(h: 5),
                Text(
                  'We cannot solve problems with the kind of thinking we employed when we came up with them',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '12:12 pm',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      color: white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget MyMessage() {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerRight,
      child: Stack(
        children: [
          Container(
            width: Get.width * 0.75,
            padding: spacing(h: 10, v: 10),
            margin: spacOnly(
              right: 25,
              top: 5,
              bottom: 5,
            ),
            decoration: BoxDecoration(
              color: white,
              borderRadius: radiusOnly(
                topLeft: 10,
                topRight: 10,
                bottomLeft: 10,
              ),
              boxShadow: glassShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You',
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    color: black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                gap(h: 5),
                Text(
                  'We cannot solve problems with the kind of thinking we employed when we came up with them',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '12:12 pm',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      color: black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 5,
            bottom: 0,
            child: Icon(
              Icons.done,
              color: black,
              size: 20,
            ),
          )
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
          ),
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
  }) {
    return Container(
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
    );
  }
}
