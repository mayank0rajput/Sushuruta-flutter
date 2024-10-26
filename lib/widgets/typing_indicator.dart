import 'package:flutter/material.dart';
import 'dart:math';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({
    super.key,
    this.showIndicator = false,
    this.bubbleColor =
    const Color(0xFFE5E5EA), // Light gray (receiver's bubble)
    this.flashingCircleDarkColor = const Color(0xFFF), // Darker gray for dots
    this.flashingCircleBrightColor =
        Colors.grey, // Bright white for flashing dots
  });

  final bool showIndicator;
  final Color bubbleColor;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _appearanceController;
  late AnimationController _repeatingController;

  final List<Interval> _dotIntervals = const [
    Interval(0.25, 0.8),
    Interval(0.35, 0.9),
    Interval(0.45, 1.0),
  ];

  @override
  void initState() {
    super.initState();

    _appearanceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _repeatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    if (widget.showIndicator) {
      _showIndicator();
    }
  }

  @override
  void didUpdateWidget(TypingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.showIndicator != oldWidget.showIndicator) {
      if (widget.showIndicator) {
        _showIndicator();
      } else {
        _hideIndicator();
      }
    }
  }

  @override
  void dispose() {
    _appearanceController.dispose();
    _repeatingController.dispose();
    super.dispose();
  }

  void _showIndicator() {
    _appearanceController.forward();
    _repeatingController.repeat();
  }

  void _hideIndicator() {
    _appearanceController.reverse();
    _repeatingController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 0, 5),
      child: AnimatedBuilder(
        animation: _appearanceController,
        builder: (context, child) {
          return Opacity(
            opacity: widget.showIndicator ? 1.0 : 0.0,
            child: child,
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 75, // Similar to iMessage bubble
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(5), // Left bottom corner rounded
                ),
                color: widget.bubbleColor, // Receiver's chat bubble color
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlashingCircle(
                    index: 0,
                    repeatingController: _repeatingController,
                    dotIntervals: _dotIntervals,
                    flashingCircleDarkColor: widget.flashingCircleDarkColor,
                    flashingCircleBrightColor: widget.flashingCircleBrightColor,
                  ),
                  FlashingCircle(
                    index: 1,
                    repeatingController: _repeatingController,
                    dotIntervals: _dotIntervals,
                    flashingCircleDarkColor: widget.flashingCircleDarkColor,
                    flashingCircleBrightColor: widget.flashingCircleBrightColor,
                  ),
                  FlashingCircle(
                    index: 2,
                    repeatingController: _repeatingController,
                    dotIntervals: _dotIntervals,
                    flashingCircleDarkColor: widget.flashingCircleDarkColor,
                    flashingCircleBrightColor: widget.flashingCircleBrightColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlashingCircle extends StatelessWidget {
  const FlashingCircle({
    super.key,
    required this.index,
    required this.repeatingController,
    required this.dotIntervals,
    required this.flashingCircleBrightColor,
    required this.flashingCircleDarkColor,
  });

  final int index;
  final AnimationController repeatingController;
  final List<Interval> dotIntervals;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: repeatingController,
      builder: (context, child) {
        final circleFlashPercent = dotIntervals[index].transform(
          repeatingController.value,
        );
        final circleColorPercent = sin(pi * circleFlashPercent);

        return Container(
          width: 10, // Small dot size for iMessage-style bubbles
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.lerp(
              flashingCircleDarkColor,
              flashingCircleBrightColor,
              circleColorPercent,
            ),
          ),
        );
      },
    );
  }
}
