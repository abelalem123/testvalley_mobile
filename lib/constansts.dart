import 'dart:ui';

import 'package:testvalleychatapp/homepage.dart';

String appId = 'BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF';
String channelUrl =
    'sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211';
final Color secondaryColor = Color(0xFF666666);
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
