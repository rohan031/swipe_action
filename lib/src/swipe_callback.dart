import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe_callback/swipe_callback.dart';

class SwipeCallback extends StatefulWidget {
  const SwipeCallback({
    super.key,
    required this.onSwipeSuccess,
    required this.child,
    this.swipeDirection = SwipeDirection.right,
    this.threshold = 100,
  });

  /// callback to run when swipe is successfully completed
  final VoidCallback onSwipeSuccess;
  final Widget child;
  final SwipeDirection swipeDirection;

  /// amount the widget should be swiped to make swipe a success
  /// swipe widget should be above this threshold to trigger onSwipeSuccess at end
  /// default value is 100
  final double threshold;

  @override
  State<SwipeCallback> createState() => _SwipeCallbackState();
}

class _SwipeCallbackState extends State<SwipeCallback>
    with SingleTickerProviderStateMixin {
  /// initial position of widget when swipe is first triggered
  double start = 0;

  /// when user is dragging the widget, the offset by which the widget should move in x-axis
  double offsetX = 0;

  bool dragging = false;

  /// used to determine if swipe is cancelled or not.
  bool shouldCallOnEnd = false;

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    controller.addListener(updateOffsetX);
  }

  void updateOffsetX() {
    setState(() {
      offsetX = animation.value;
    });
  }

  void handleCrossThreshold() {
    if (shouldCallOnEnd) return;
    shouldCallOnEnd = true;
    HapticFeedback.vibrate();
  }

  bool isInvalidOffsetX(double offsetX) {
    if (widget.swipeDirection == SwipeDirection.left) {
      return offsetX > 0;
    }
    return offsetX < 0;
  }

  void onDragEnd() {
    if (shouldCallOnEnd) {
      widget.onSwipeSuccess();
    }

    dragging = false;
    shouldCallOnEnd = false;

    start = 0;

    animation = Tween<double>(begin: offsetX, end: 0).animate(controller);
    controller.forward(from: 0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(offsetX, 0),
      child: GestureDetector(
        onHorizontalDragStart: (details) {
          controller.stop();
          start = details.localPosition.dx;
          dragging = true;
        },
        onHorizontalDragUpdate: (details) {
          if (!dragging) return;

          offsetX = details.localPosition.dx;
          offsetX -= start;

          if (isInvalidOffsetX(offsetX)) offsetX = 0;
          setState(() {});

          if (offsetX.abs() > widget.threshold) {
            handleCrossThreshold();
          } else {
            shouldCallOnEnd = false;
          }
        },
        onHorizontalDragEnd: (details) {
          onDragEnd();
        },
        child: widget.child,
      ),
    );
  }
}
