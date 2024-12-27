import 'package:caculator_app/configs/configs.dart';
import 'package:caculator_app/views/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
                        backgroundColor: WidgetStatePropertyAll(
                            context.read<HomeViewModel>().isDarkMode
                                ? Configs.subActionButtonColorDarkMode
                                : Configs.subActionButtonColorLightMode)),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: widget.data));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                          'Copied!',
                          style: TextStyle(color: Colors.white),
                        )),
                      );
                      _hideTooltip();
                    },
                    child: Text("Copy",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary)))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showTooltip(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            splashColor:
                Theme.of(context).colorScheme.secondary.withOpacity(0.10),
            highlightColor:
                Theme.of(context).colorScheme.secondary.withOpacity(0.05),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
