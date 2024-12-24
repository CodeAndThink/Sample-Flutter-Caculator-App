import 'package:caculator_app/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTooltip extends StatefulWidget {
  const CustomTooltip({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final String data;

  @override
  CustomTooltipState createState() => CustomTooltipState();
}

class CustomTooltipState extends State<CustomTooltip> {
  OverlayEntry? _overlayEntry;

  void _showTooltip() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _hideTooltip,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy - 30,
            child: SizedBox(
                height: 40,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        )),
                        backgroundColor: const WidgetStatePropertyAll(
                            Configs.operatorColorDarkMode)),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: widget.data));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đã copy!')),
                      );
                      _hideTooltip();
                    },
                    child: const Text("Copy"))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showTooltip(),
      child: widget.child,
    );
  }
}
