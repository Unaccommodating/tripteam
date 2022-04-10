// ignore_for_file: prefer_const_declarations

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///COLORS
const Color Blue = Color(0xFF002550);
const Color White = Colors.white;
const Color Red = Color(0xFFFF0000);
const Color Grey = Color(0xFFF1F2F6);
const Color Black = Colors.black;

///ICON MENU
final Widget iconMenuTickets = SvgPicture.asset('image/menu/MenuTickets.svg', allowDrawingOutsideViewBox: true, color: White);
final Widget iconMenuActivity = SvgPicture.asset('image/menu/MenuActivity.svg', allowDrawingOutsideViewBox: true, color: White);
final Widget iconMenuExcursion = SvgPicture.asset('image/menu/MenuExcursion.svg', allowDrawingOutsideViewBox: true, color: White);
final Widget iconMenuExcursionActiv = SvgPicture.asset('image/menu/MenuExcursionActiv.svg', allowDrawingOutsideViewBox: true, color: White);
final Widget iconMMenuProfilActiv = SvgPicture.asset('image/menu/MenuProfilActiv.svg', allowDrawingOutsideViewBox: true, color: White);
final Widget iconMenuProfil = SvgPicture.asset('image/menu/MenuProfil.svg', allowDrawingOutsideViewBox: true, color: White);

///ICON
final Widget iconPassword = SvgPicture.asset('image/icon/password.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: White);
final Widget iconEmail = SvgPicture.asset('image/icon/email.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: White);
final Widget iconShow = SvgPicture.asset('image/icon/show.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: Blue);
final Widget iconHide = SvgPicture.asset('image/icon/hide.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: Blue);
final Widget iconSetting = SvgPicture.asset('image/icon/setting.svg', height: 20, width: 20, allowDrawingOutsideViewBox: true, color: Blue);
final Widget iconKey = SvgPicture.asset('image/icon/key.svg', height: 20, width: 20, allowDrawingOutsideViewBox: true, color: Blue);


final Widget iconLightning = SvgPicture.asset('image/icon/lightning.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: Red);
final Widget iconConfirmation = SvgPicture.asset('image/icon/confirmation.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true);

final Widget iconSettings = SvgPicture.asset('image/icon/settings.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: White);
final Widget iconAdd = SvgPicture.asset('image/icon/add.svg', height: 20, width: 20, allowDrawingOutsideViewBox: true, color: White);
final Widget iconExcursion = SvgPicture.asset('image/icon/myExcursion.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: White);
final Widget iconExit = SvgPicture.asset('image/icon/exit.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: White);
final Widget iconFavoriteLi = SvgPicture.asset('image/icon/favorite.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true,color: White,);
final Widget iconPersonWhite = SvgPicture.asset('image/icon/person.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: White);
final Widget iconPasswordWhite = SvgPicture.asset('image/icon/password.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: White);
final Widget iconEmailWhite = SvgPicture.asset('image/icon/email.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: White);
final Widget iconPhone = SvgPicture.asset('image/icon/phone.svg', height: 25, width: 25, allowDrawingOutsideViewBox: true, color: White);

final Widget iconReverse = SvgPicture.asset('image/icon/reverse.svg', height: 40, width: 40, allowDrawingOutsideViewBox: true);
final Widget iconHandbook = SvgPicture.asset('image/icon/handbook.svg', height: 30, width: 30, allowDrawingOutsideViewBox: true,color: White,);
final Widget iconFavoriteRed = SvgPicture.asset('image/icon/favorite.svg', height: 30, width: 30, allowDrawingOutsideViewBox: true,color: Red,);
final Widget iconFavoriteWhite = SvgPicture.asset('image/icon/favorite.svg', height: 30, width: 30, allowDrawingOutsideViewBox: true,color: White,);
final Widget iconArrow = SvgPicture.asset('image/icon/arrow.svg', allowDrawingOutsideViewBox: true, color: White);
final Widget iconArrowBottom = SvgPicture.asset('image/icon/arrowBottom.svg', height: 15, width: 15, allowDrawingOutsideViewBox: true);
final Widget iconArrowBottomWhite = SvgPicture.asset('image/icon/arrowBottom.svg', height: 15, width: 15, allowDrawingOutsideViewBox: true,color: White);
final Widget iconMagnifier = SvgPicture.asset('image/icon/magnifier.svg', height: 5, width: 5,allowDrawingOutsideViewBox: true, color: White);
final Widget iconDate = SvgPicture.asset('image/icon/date.svg', height: 25, width: 25,allowDrawingOutsideViewBox: true);
final Widget iconDateWhite = SvgPicture.asset('image/icon/date.svg', height: 20, width: 20,allowDrawingOutsideViewBox: true,color: White);
final Widget iconTime = SvgPicture.asset('image/icon/time.svg', height: 20, width: 20,allowDrawingOutsideViewBox: true,color: White);
final Widget iconLocation = SvgPicture.asset('image/icon/location.svg', height: 15, width: 15,allowDrawingOutsideViewBox: true);
final Widget iconRuble = SvgPicture.asset('image/icon/ruble.svg', height: 15, width: 15,allowDrawingOutsideViewBox: true);

final Widget iconVK = SvgPicture.asset('image/icon/vk.svg', height: 80, width: 80, allowDrawingOutsideViewBox: true, color: Color(0xFF5181B8));
final Widget iconInstagram = SvgPicture.asset('image/icon/instagram.svg', height: 80, width: 80, allowDrawingOutsideViewBox: true, color: Color(0xFFf23b70));
final Widget iconTelegram = SvgPicture.asset('image/icon/telegram.svg', height: 80, width: 80, allowDrawingOutsideViewBox: true, color: Color(0xFF34aadf));
final Widget iconGoogle = SvgPicture.asset('image/icon/google.svg', height: 80, width: 80, allowDrawingOutsideViewBox: true, color: Color(0xFFEB4335));
final Widget iconWhatsapp = SvgPicture.asset('image/icon/whatsapp.svg', height: 80, width: 80, allowDrawingOutsideViewBox: true, color: Color(0xFF4de35d));
final Widget iconFacebook = SvgPicture.asset('image/icon/facebook.svg', height: 80, width: 80, allowDrawingOutsideViewBox: true, color: Color(0xFF3C5A9A));

///IMAGES
const String iLoading = "image/illiustration/iLoading.png";
const String iErrorNet = "image/illiustration/iErrorNet.png";
const String iProfil = "image/illiustration/iPerson.png";

///DAFAULT IMAGES
const String avatarDef = "image/defoult/avatar.png";
const String excursionDef = "image/defoult/excursion.png";

///STYLE TEXT
const FontWeight Bold = FontWeight.w900;
const FontWeight SemiBold = FontWeight.w800;
const FontWeight Medium = FontWeight.w500;
const FontWeight Regular = FontWeight.w400;
const FontWeight Light = FontWeight.w200;
