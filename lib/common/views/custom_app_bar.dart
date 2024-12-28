import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      required this.title,
      required this.rightButtonAction,
      this.enableRightButton = false});
  final String title;
  final VoidCallback rightButtonAction;
  final bool enableRightButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          enableRightButton
              ? IconButton(
                  onPressed: rightButtonAction,
                  icon: const Icon(Icons.add),
                )
              : const SizedBox(
                  width: 48,
                )
        ],
      ),
    );
  }
}
