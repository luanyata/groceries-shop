import 'package:flutter/material.dart';

class AnimatedConfirmButton extends StatefulWidget {
  final Widget child;
  final Widget toggledChild;
  final VoidCallback onPressed;
  final Color color;
  final Duration duration;

  const AnimatedConfirmButton({
    super.key,
    required this.child,
    required this.toggledChild,
    required this.onPressed,
    required this.color,
    this.duration = const Duration(seconds: 1),
  });

  @override
  State<AnimatedConfirmButton> createState() => _AnimatedConfirmButtonState();
}

class _AnimatedConfirmButtonState extends State<AnimatedConfirmButton> {
  bool _isToggled = false;

  void _handlePress() {
    if (_isToggled) return;

    widget.onPressed();

    setState(() {
      _isToggled = true;
    });

    Future.delayed(widget.duration, () {
      if (mounted) {
        setState(() {
          _isToggled = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _handlePress,
      color: widget.color,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _isToggled ? widget.toggledChild : widget.child,
      ),
    );
  }
}
