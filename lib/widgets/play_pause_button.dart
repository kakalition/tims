import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tims/interfaces/i_clock_component.dart';
import 'package:tims/viewmodels/main_viewmodel.dart';

import '../constants.dart';

class PlayPauseButton extends StatefulWidget implements IClockComponent {
  const PlayPauseButton({Key? key, required viewmodel}) : 
		_viewmodel = viewmodel,
	  super(key: key);
	
	final dynamic _viewmodel;

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton>
    with TickerProviderStateMixin {
  final MainVM _mainViewmodel = Get.find<MainVM>();

  late AnimationController _playPauseButtonController;
  late AnimationController _playPauseIconController;
  late AnimationController _revealButtonController;

  late Animation<double> _playPauseButtonAnimation;
  late Animation<Offset> _revealButtonAnimation;

  @override
  void initState() {
    super.initState();

    // Controller Initialization
    _playPauseButtonController = AnimationController(vsync: this)
      ..duration = const Duration(milliseconds: 150);
    _playPauseIconController = AnimationController(vsync: this)
      ..duration = const Duration(milliseconds: 75);
    _revealButtonController = AnimationController(vsync: this)
      ..duration = const Duration(milliseconds: 200);

    // Initialize Widget Animation;
    _playPauseButtonAnimation = Tween<double>(begin: 1, end: 1.05)
				.chain(CurveTween(curve: Curves.easeOut))
        .animate(_playPauseButtonController)
      ..addListener(() {
        setState(() {});
      });
    _revealButtonAnimation = Tween<Offset>(
            begin: Offset.zero,
            end: Offset(0, _mainViewmodel.revealLengthFactor))
				.chain(CurveTween(curve: Curves.easeOut))
        .animate(_revealButtonController)
      ..addListener(() {
        setState(() {});
      });
  }

	Future<void> tapButton() async {
      if (!widget._viewmodel.getClockActiveStatus()) {
        widget._viewmodel.playClock();
      } else {
        widget._viewmodel.stopClock();
      }

      // Button forward animation
      await _playPauseButtonController.forward();

      if (_playPauseIconController.isCompleted) {
				_playPauseIconController.reverse();
      } else if (_playPauseIconController.isDismissed) {
				_playPauseIconController.forward();
      }

      // Reveal animation
      _revealButtonController.forward();

      // Button reverse animation
      await _playPauseButtonController.reverse();

	}
	
	Future<void> holdButton() async {
      await _playPauseButtonController.forward();
	}

	Future<void> cancelButton() async {
      await _playPauseButtonController.reverse();
	}

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Restart Button
        Transform.translate(
          offset: _revealButtonAnimation.value,
          child: Material(
            borderRadius:
                BorderRadius.circular(_mainViewmodel.restartButtonSize),
            child: InkWell(
              onTap: () async {
                await widget._viewmodel.restartClock();
                // Animate Play Icon and Reverse Reveal
                _playPauseButtonController.reverse();
                _playPauseIconController.reverse();
                _revealButtonController.reverse();
              },
              borderRadius:
                  BorderRadius.circular(_mainViewmodel.restartButtonSize),
              child: Container(
                height: _mainViewmodel.restartButtonSize,
                width: _mainViewmodel.restartButtonSize,
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: whiteColorDarkTheme),
                  borderRadius: BorderRadius.circular(
                    _mainViewmodel.restartButtonSize,
                  ),
                ),
                child: Icon(
                  Icons.replay,
                  color: whiteColorDarkTheme,
                  size: _mainViewmodel.restartIconSize,
                ),
              ),
            ),
          ),
        ),
        // Play/Stop Button
        Transform.scale(
          scale: _playPauseButtonAnimation.value,
          child: Material(
            borderRadius: BorderRadius.circular(_mainViewmodel.playButtonSize),
            child: InkWell(
              onTap: () {
								tapButton();
              },
              onTapDown: (TapDownDetails details) {
								holdButton();
              },
              onTapCancel: () {
								cancelButton();
              },
              borderRadius:
                  BorderRadius.circular(_mainViewmodel.playButtonSize),
              child: Container(
                height: _mainViewmodel.playButtonSize,
                width: _mainViewmodel.playButtonSize,
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: whiteColorDarkTheme),
                  borderRadius: BorderRadius.circular(
                    _mainViewmodel.playButtonSize,
                  ),
                ),
                child: Center(
                  child: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: _playPauseIconController,
                    color: whiteColorDarkTheme,
                    size: _mainViewmodel.playIconSize,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
