import 'package:caculator_app/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSwitchButton extends StatefulWidget {
  final bool value;
  final String inactiveImage;
  final String activieImage;
  final ValueChanged<bool> onChanged;

  const CustomSwitchButton({
    super.key,
    required this.value,
    required this.inactiveImage,
    required this.activieImage,
    required this.onChanged,
  });

  @override
  CustomSwitchButtonState createState() => CustomSwitchButtonState();
}

class CustomSwitchButtonState extends State<CustomSwitchButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    if (widget.value) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(CustomSwitchButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      widget.value ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: 72.0,
        height: 32.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: widget.value
              ? Configs.activeTrackColor
              : Configs.inactiveTrackColor,
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Positioned(
              left: 4.0,
              child: FadeTransition(
                opacity: Tween<double>(
                  begin: widget.value ? 1.0 : 0.0,
                  end: widget.value ? 1.0 : 0.0,
                ).animate(_controller),
                child: SvgPicture.asset(widget.activieImage,
                    width: 24, height: 24),
              ),
            ),
            Positioned(
              right: 4.0,
              child: FadeTransition(
                opacity: Tween<double>(
                  begin: widget.value ? 0.0 : 1.0,
                  end: widget.value ? 0.0 : 1.0,
                ).animate(_controller),
                child: SvgPicture.asset(widget.inactiveImage,
                    width: 24, height: 24),
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  left: 4.0 + (_controller.value * 40.0),
                  child: Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.value
                          ? Configs.activeThumbColor
                          : Configs.inactiveThumbColor,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
