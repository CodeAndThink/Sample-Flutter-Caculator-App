import 'package:caculator_app/common/views/custom_switch_button.dart';
import 'package:caculator_app/configs/configs.dart';
import 'package:caculator_app/model/enum/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDark = false;
  final TextEditingController _operationController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _operationController.text = '0';
    _resultController.text = '0';
  }

  @override
  void dispose() {
    _operationController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _appBar(context),
              const SizedBox(height: 55),
              _resultArea(context),
              _numberPad(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Center(
        child: CustomSwitchButton(
      value: isDark,
      inactiveImage: 'assets/icons/moon.svg',
      activieImage: 'assets/icons/sun.svg',
      onChanged: (newValue) {
        setState(() {
          isDark = newValue;
        });
      },
    ));
  }

  Widget _resultArea(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    return Container(
      height: screenHeight * 0.21,
      width: screenWidth - 32,
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.09,
            child: TextField(
              controller: _operationController,
              maxLines: 1,
              decoration: const InputDecoration(border: InputBorder.none),
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.12,
            child: TextField(
              controller: _resultController,
              maxLines: 1,
              decoration: const InputDecoration(border: InputBorder.none),
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }

  Widget _numberPad(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              _textButton(context, operationToDisplaySymbol(Operation.reset),
                  Configs.subActionButtonColor, Colors.white),
              const SizedBox(width: 16),
              _iconButton(context, operationToDisplaySymbol(Operation.negation),
                  Configs.subActionButtonColor, Colors.white),
              const SizedBox(width: 16),
              _textButton(
                  context,
                  operationToDisplaySymbol(Operation.persentage),
                  Configs.subActionButtonColor,
                  Colors.white),
              const SizedBox(width: 16),
              _textButton(context, operationToDisplaySymbol(Operation.divide),
                  Configs.actionButtonColor, Colors.white),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _textButton(
                  context, '7', Theme.of(context).colorScheme.primary, null),
              const SizedBox(width: 16),
              _textButton(
                  context, '8', Theme.of(context).colorScheme.primary, null),
              const SizedBox(width: 16),
              _textButton(
                  context, '9', Theme.of(context).colorScheme.primary, null),
              const SizedBox(width: 16),
              _textButton(context, operationToDisplaySymbol(Operation.multiply),
                  Configs.actionButtonColor, Colors.white),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _textButton(
                  context, '4', Theme.of(context).colorScheme.primary, null),
              const SizedBox(width: 16),
              _textButton(
                  context, '5', Theme.of(context).colorScheme.primary, null),
              const SizedBox(width: 16),
              _textButton(
                  context, '6', Theme.of(context).colorScheme.primary, null),
              const SizedBox(width: 16),
              _textButton(context, operationToDisplaySymbol(Operation.subtract),
                  Configs.actionButtonColor, Colors.white),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _textButton(
                  context, '1', Theme.of(context).colorScheme.primary, null),
              const SizedBox(width: 16),
              _textButton(
                  context, '2', Theme.of(context).colorScheme.primary, null),
              const SizedBox(width: 16),
              _textButton(
                  context, '3', Theme.of(context).colorScheme.primary, null),
              const SizedBox(width: 16),
              _textButton(context, operationToDisplaySymbol(Operation.add),
                  Configs.actionButtonColor, Colors.white),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _textButton(context, operationToDisplaySymbol(Operation.dot),
                  Theme.of(context).colorScheme.primary, null),
              const SizedBox(width: 16),
              _textButton(
                  context, '0', Theme.of(context).colorScheme.primary, null),
              const SizedBox(width: 16),
              _iconButton(context, operationToDisplaySymbol(Operation.delete),
                  Theme.of(context).colorScheme.primary, null),
              const SizedBox(width: 16),
              _textButton(context, operationToDisplaySymbol(Operation.equal),
                  Configs.actionButtonColor, Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textButton(BuildContext context, String number, Color backgroundColor,
      Color? textColor) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    return Expanded(
      child: SizedBox(
        height: screenHeight > screenWidth ? screenHeight * 0.09 : 72,
        child: ElevatedButton(
          onPressed: () {
            if (number == 'C') {
              _operationController.text = '0';
              _resultController.text = '0';
            } else if (number == '=') {
              try {
                final result = eval(_operationController.text);
                _resultController.text = result.toString();
              } catch (e) {
                _resultController.text = 'Error';
              }
            } else {
              if (_operationController.text == '0') {
                _operationController.text = number;
              } else {
                _operationController.text += number;
              }
            }
          },
          style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              )),
              backgroundColor: WidgetStatePropertyAll(backgroundColor)),
          child: Text(number,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: textColor)),
        ),
      ),
    );
  }

  Widget _iconButton(BuildContext context, String iconPath,
      Color backgroundColor, Color? iconColor) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    return Expanded(
      child: SizedBox(
        height: screenHeight > screenWidth ? screenHeight * 0.09 : 72,
        child: ElevatedButton(
          onPressed: () {
            if (iconPath == 'assets/icons/delete.svg') {
              if (_operationController.text.length > 1) {
                _operationController.text = _operationController.text
                    .substring(0, _operationController.text.length - 1);
              } else {
                _operationController.text = '0';
              }
            } else {
              _operationController.text += iconPath;
            }
          },
          style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              )),
              backgroundColor: WidgetStatePropertyAll(backgroundColor)),
          child: SvgPicture.asset(
            iconPath,
            height: 26,
            width: 26,
            colorFilter: iconColor != null
                ? ColorFilter.mode(iconColor, BlendMode.srcIn)
                : null,
          ),
        ),
      ),
    );
  }

  eval(String text) {
    return text;
  }
}
