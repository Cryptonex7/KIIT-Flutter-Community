import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flare_flutter/flare_controls.dart';

 
class AppStateNotifier extends ChangeNotifier {
  //
  bool isDarkMode = false;
 
  void updateTheme(bool val) {
    this.isDarkMode = val;
    notifyListeners();
  }
}

enum AnimationToPlay { DayIdle, NightIdle, DayToNight, NightToDay }

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FlareControls animationControls = FlareControls();

  String _getAnimationName(AnimationToPlay animationToPlay) {
    switch (animationToPlay) {
      case AnimationToPlay.DayIdle:
        return 'day_idle';
      case AnimationToPlay.NightIdle:
        return 'night_idle';
      case AnimationToPlay.DayToNight:
        return 'switch_night';
      case AnimationToPlay.NightToDay:
        return 'switch_day';
        break;
      default:
        return 'day_idle';
    }
  }

  void _setAnimationToPlay(AnimationToPlay animation) {
    animationControls.play(_getAnimationName(animation));
  }

  double lastTouched = 0.0;
  @override
  Widget build(BuildContext context) {
    double animationHeight = 75;
    double animationWidth = MediaQuery.of(context).size.width;
    return Column(
        children: <Widget>[
          Text('Switch Theme:',style:Theme.of(context).textTheme.title),
          SizedBox(height:20),
          Container(
      height: animationHeight,
      width: animationWidth,
      child: 
          GestureDetector(
            onTapUp: (tapInfo) {
              var localTouchPosition = (context.findRenderObject() as RenderBox)
                  .globalToLocal(tapInfo.globalPosition);
              var dayTouched = localTouchPosition.dx > animationWidth / 2;
              var nightTouched = localTouchPosition.dx < animationWidth / 2;

              if (dayTouched && (lastTouched < animationWidth / 2||lastTouched==0.0)) {
                print('night to day');
                _setAnimationToPlay(AnimationToPlay.NightToDay);
                Provider.of<AppStateNotifier>(context,listen: false).updateTheme(false);
                 _setAnimationToPlay(AnimationToPlay.DayIdle);

              } else if (dayTouched && lastTouched > animationWidth / 2) {
                print('dayidle');
                _setAnimationToPlay(AnimationToPlay.DayIdle);
                Provider.of<AppStateNotifier>(context,listen: false).updateTheme(false);
              } else if (nightTouched && (lastTouched > animationWidth / 2||lastTouched==0.0)) {
                print('day to night');
                _setAnimationToPlay(AnimationToPlay.DayToNight);
                Provider.of<AppStateNotifier>(context,listen: false).updateTheme(true);
                _setAnimationToPlay(AnimationToPlay.NightIdle);
              } else if (dayTouched && lastTouched < animationWidth / 2) {
                print('nightidle');
                _setAnimationToPlay(AnimationToPlay.NightIdle);
                Provider.of<AppStateNotifier>(context,listen: false).updateTheme(true);
              }
              final RenderBox box = context.findRenderObject();
              final Offset localOffset =
                  box.globalToLocal(tapInfo.globalPosition);
              lastTouched = localOffset.dx;
            },
            child: FlareActor(
              'assets/switch_daytime.flr',
              fit: BoxFit.contain,
              animation: Provider.of<AppStateNotifier>(context).isDarkMode?'night_idle':'day_idle',
              controller: animationControls,
            ),
          ))
        ],
      
    );
  }
}
