import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flare_flutter/flare_controls.dart';
import '../screens/settings_page.dart';

enum AnimationToPlay {
  HometoSettings,
  Home,
  SettingtoHome,
  HometoGps,
  Hometoabout,
  Settingtogps,
  Settingtoabout,
  GpstoSetting,
  GpstoHome,
  GpstoAbout,
  AbouttoHome,
  AbouttoSetting,
  AboutoGps
}

class SmartFlareAnimation extends StatefulWidget {
  final Function gotoPage;

  SmartFlareAnimation(this.gotoPage);
  @override
  _SmartFlareAnimationState createState() => _SmartFlareAnimationState();
}

class _SmartFlareAnimationState extends State<SmartFlareAnimation> {
  bool insettings=false;
  double posx = 0.0;
  double posy = 100.0;
  void onTapDown(BuildContext context, TapDownDetails details) {
    print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
    });
  }

  final FlareControls animationControls = FlareControls();

  String _getAnimationName(AnimationToPlay animationToPlay) {
    switch (animationToPlay) {
      case AnimationToPlay.HometoSettings:
        return '0_1';
      case AnimationToPlay.Home:
        return '_0';
      case AnimationToPlay.SettingtoHome:
        return '1_0';
      case AnimationToPlay.HometoGps:
        return '0_2';
      case AnimationToPlay.Hometoabout:
        return '0_3';
      case AnimationToPlay.Settingtogps:
        return '1_2';
      case AnimationToPlay.Settingtoabout:
        return '1_3';
      case AnimationToPlay.GpstoAbout:
        return '2_3';
      case AnimationToPlay.GpstoSetting:
        return '2_1';
      case AnimationToPlay.GpstoHome:
        return '2_0';
      case AnimationToPlay.AboutoGps:
        return '3_2';
      case AnimationToPlay.AbouttoSetting:
        return '3_1';
      case AnimationToPlay.AbouttoHome:
        return '3_0';
        break;
      default:
        return '_0';
    }
  }

  void _setAnimationToPlay(AnimationToPlay animation) {
    animationControls.play(_getAnimationName(animation));
  }

  double lastTouched = 0.0;

  @override
  Widget build(BuildContext context) {
    double animationWidth = MediaQuery.of(context).size.width;
    double animationHeight = 100;

    return Container(
      height: animationHeight,
      width: animationWidth,
      child: GestureDetector(
        onTapDown: (TapDownDetails details) => onTapDown(context, details),
        onTapUp: (tapInfo) {
          var localTouchPosition = (context.findRenderObject() as RenderBox)
              .globalToLocal(tapInfo.globalPosition);

          var settingsTouched = localTouchPosition.dx > animationWidth / 4 &&
              localTouchPosition.dx < animationWidth / 2;

          var gpsTouched = localTouchPosition.dx > animationWidth / 2 &&
              localTouchPosition.dx < (animationWidth / 4) * 3;
          var aboutTouched = localTouchPosition.dx > (animationWidth / 4) * 3 &&
              localTouchPosition.dx < animationWidth;

          var homeTouched = localTouchPosition.dx < animationWidth / 4;

          if (settingsTouched && lastTouched < animationWidth / 4) {
            print('home to settings');
            _setAnimationToPlay(AnimationToPlay.HometoSettings);
            widget.gotoPage(1);
            insettings=true;
          } else if (gpsTouched && lastTouched < animationWidth / 4) {
            print('home to gps');
            _setAnimationToPlay(AnimationToPlay.HometoGps);
            widget.gotoPage(2);
          } else if (aboutTouched && lastTouched < animationWidth / 4) {
            print('home to about');
            _setAnimationToPlay(AnimationToPlay.Hometoabout);
            widget.gotoPage(3);
          } else if (homeTouched &&
              lastTouched > animationWidth / 4 &&
              lastTouched < animationWidth / 2) {
            print('setting to home');
            _setAnimationToPlay(AnimationToPlay.SettingtoHome);
            widget.gotoPage(0);
          } else if (gpsTouched &&
              lastTouched > animationWidth / 4 &&
              lastTouched < animationWidth / 2) {
            print('setting to gps');
            _setAnimationToPlay(AnimationToPlay.Settingtogps);
            widget.gotoPage(2);
          } else if (aboutTouched &&
              lastTouched > animationWidth / 4 &&
              lastTouched < animationWidth / 2) {
            print('setting to about');
            _setAnimationToPlay(AnimationToPlay.Settingtoabout);
            widget.gotoPage(3);
          } else if (homeTouched &&
              lastTouched > animationWidth / 2 &&
              lastTouched < (animationWidth / 4) * 3) {
            print('gps to home');
            _setAnimationToPlay(AnimationToPlay.GpstoHome);
            widget.gotoPage(0);
          } else if (settingsTouched &&
              lastTouched > animationWidth / 2 &&
              lastTouched < (animationWidth / 4) * 3) {
            print('gps to settings');
            _setAnimationToPlay(AnimationToPlay.GpstoSetting);
            widget.gotoPage(1);
            insettings=true;
          } else if (aboutTouched &&
              lastTouched > animationWidth / 2 &&
              lastTouched < (animationWidth / 4) * 3) {
            print('gps to about');
            _setAnimationToPlay(AnimationToPlay.GpstoAbout);
            widget.gotoPage(3);
          } else if (homeTouched &&
              lastTouched > (animationWidth / 4) * 3 &&
              lastTouched < animationWidth) {
            print('about to home');
            _setAnimationToPlay(AnimationToPlay.AbouttoHome);
            widget.gotoPage(0);
          } else if (settingsTouched &&
              lastTouched > (animationWidth / 4) * 3 &&
              lastTouched < animationWidth) {
            print('about to setting');
            _setAnimationToPlay(AnimationToPlay.AbouttoSetting);
            widget.gotoPage(1);
            insettings=true;
          } else if (gpsTouched &&
              lastTouched > (animationWidth / 4) * 3 &&
              lastTouched < animationWidth) {
            print('about to gps');
            _setAnimationToPlay(AnimationToPlay.AboutoGps);
            widget.gotoPage(2);
          }

          final RenderBox box = context.findRenderObject();
          final Offset localOffset = box.globalToLocal(tapInfo.globalPosition);
          lastTouched = localOffset.dx;
        },
        child: Provider.of<AppStateNotifier>(context,).isDarkMode?
        FlareActor(
          
          'assets/nav_bar1.flr',
          controller: animationControls,
          
          animation: insettings?'0_1':'_0',
        ):FlareActor(
          'assets/nav_bar2.flr',
          controller: animationControls,
          
          animation: insettings?'0_1':'_0',
        ),
      ),
    );
  }
}
