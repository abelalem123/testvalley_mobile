import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:testvalleychatapp/constansts.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  TextEditingController _messageController = TextEditingController();

  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    getChannel(channelUrl);
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

  List<BaseMessage> allMessages = [];
  void getChannel(String Url) async {
    try {
      setState(() {
        isLoading = true;
      });
      await SendbirdChat.connect(channelUrl);

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
                                  decoration: InputDecoration(
                                    border: InputBorder
                                        .none, // Remove the underline
                                  ),
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
