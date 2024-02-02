import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  TextEditingController _messageController = TextEditingController();
  String appId = 'BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF';
  String channelUrl =
      'sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211';

  final Color secondaryColor = Color(0xFF666666);

  final timestamp = 9223372036854775807;

  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    getChannel(
        'sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211');
    _scrollController = ScrollController();

    super.initState();
  }

  bool isSendingLoading = false;
  void sendMessage(String message, String url) async {
    try {
      setState(() {
        isSendingLoading = true;
      });
      final channel = await OpenChannel.getChannel(url);
      await channel.enter();
      await channel
          .sendUserMessage(UserMessageCreateParams(message: '쿠팡이 또 ...'));

      setState(() {
        _messageController.text = '';
        chatList.add(MessageCard(
            name: 'name',
            message: message,
            myMessage: true,
            day: 1,
            online: 2,
            isPhoto: false));
        isSendingLoading = false;
      });
    } catch (e) {}
  }

  bool isTyping = false;
  List<MessageCard> chatList = [
    MessageCard(
      day: 3,
      name: '목이길어슬픈기린',
      message: '오늘 저녁 식사 같이 하실 여성분? 제가 삽니다',
      myMessage: false,
      online: 1,
      isPhoto: true,
      isBlue: true,
      photoUrl: 'assets/image2.png',
    ),
    MessageCard(
      name: '일림안놓고는못살음',
      message: '저 형 또 시작이네',
      myMessage: false,
      day: 3,
      online: 1,
      isPhoto: false,
      isBlue: true,
    ),
    MessageCard(
        name: '',
        message: 'ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ',
        myMessage: true,
        day: 0,
        online: 1,
        isPhoto: false),
    MessageCard(
      name: '목이길어슬픈기린',
      message: '너 T발 C야?',
      myMessage: false,
      day: 2,
      online: 1,
      isPhoto: true,
      photoUrl: 'assets/image2.png',
    ),
    MessageCard(
      name: '유령랜덤닉',
      message: '근데 다 강남 사시는 거에요?',
      myMessage: false,
      day: 1,
      online: 1,
      isPhoto: false,
      isBlue: false,
    ),
    MessageCard(
      name: "장난하지말고",
      message: "아뇨 직장이 강남이에요",
      myMessage: false,
      day: 1,
      online: 1,
      isPhoto: false,
      isBlue: true,
    ),
    MessageCard(
      name: '쿠팡',
      message: '쿠팡 로켓 써보세요!',
      myMessage: false,
      day: 1,
      online: 1,
      isPhoto: true,
      photoUrl: 'assets/image1.png',
    ),
    MessageCard(
        name: '',
        message: '쿠팡이 또 ...',
        myMessage: true,
        day: 1,
        online: 1,
        isPhoto: false),
    MessageCard(
      name: '썸보내줘',
      message: '썸 좀 보내주세요 다이아님들',
      myMessage: false,
      day: 1,
      online: 1,
      isPhoto: false,
      isBlue: true,
    )
  ];
  List<BaseMessage> allMessages = [];
  void getChannel(String Url) async {
    try {
      setState(() {
        isLoading = true;
      });
      await SendbirdChat.connect(
          'sendbird_desk_agent_id_414406bd-ddc2-4484-b086-06701e8dc55d');

      final channel = await OpenChannel.getChannel(Url);
      await channel.enter();

      final query = PreviousMessageListQuery(
        channelType: channel.channelType,
        channelUrl: channel.channelUrl,
      );

      final messages = await query.next();

      setState(() {
        isLoading = false;
      });
      messages.forEach((element) {
        chatList.add(MessageCard(
            name: 'name',
            message: element.message,
            myMessage: true,
            day: 1,
            online: 1,
            isPhoto: false));
      });
      allMessages = messages;
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // getChannel(
    //     'sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211');
    Future.delayed(Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5.h,
        backgroundColor: Colors.black,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        title: Center(
          child: Text(
            '강남스팟',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          Icon(
            Icons.menu,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.8,
                    width: double.infinity,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: chatList.length,
                            itemBuilder: (context, index) {
                              return chatList[index];
                            })),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 6.h,
                          width: 85.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: secondaryColor)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  style: TextStyle(color: Colors.grey),
                                  decoration: InputDecoration(),
                                  controller: _messageController,
                                  onChanged: (value) {
                                    setState(() {
                                      isTyping = true;
                                    });
                                  },
                                ),
                              ),
                              // Spacer(),
                              GestureDetector(
                                onTap: () {
                                  sendMessage(
                                      _messageController.text, channelUrl);
                                },
                                child: Container(
                                  height: 24,
                                  width: 24,
                                  child: isSendingLoading
                                      ? CircularProgressIndicator(
                                          color: Colors.grey,
                                        )
                                      : Center(
                                          child: Icon(
                                            Icons.arrow_upward,
                                            color: Colors.black,
                                            size: 15,
                                          ),
                                        ),
                                  decoration: BoxDecoration(
                                      color: isTyping
                                          ? Color(0xFFFF006B)
                                          : secondaryColor,
                                      shape: BoxShape.circle),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class MessageCard extends StatelessWidget {
  final String name;
  final String message;
  final bool myMessage;
  final int day;
  final int online;
  final bool isPhoto;
  final isBlue;
  final photoUrl;

  MessageCard(
      {super.key,
      required this.name,
      required this.message,
      required this.myMessage,
      required this.day,
      required this.online,
      required this.isPhoto,
      this.isBlue,
      this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: myMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: !myMessage
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isPhoto)
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover, image: AssetImage(photoUrl))),
                    ),
                  if (!isPhoto)
                    Container(
                      height: 32,
                      width: 32,
                      child: Center(child: Text('👻')),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: isBlue ? Colors.blue : Colors.red)),
                    ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                    // height: 96,
                    // width: 280,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        color: Color(0xFF1A1A1A)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              name,
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.circle,
                              color: Color(0xFF46F9F5),
                              size: 10,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          constraints: BoxConstraints(maxWidth: 55.w),
                          child: Text(
                            message,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        '$day분 전',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )
                ],
              )
            : Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  message,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    gradient: LinearGradient(
                        colors: [Color(0xFFFF006B), Color(0xFFFF4593)])),
              ),
      ),
    );
  }
}
