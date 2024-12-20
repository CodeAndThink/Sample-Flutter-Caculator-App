import 'package:caculator_app/common/views/custom_switch_button.dart';
import 'package:caculator_app/configs/configs.dart';
import 'package:caculator_app/model/enum/enum.dart';
import 'package:caculator_app/views/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
      value: !context.watch<HomeViewModel>().isDarkMode,
      inactiveImage: 'assets/icons/moon.svg',
      activieImage: 'assets/icons/sun.svg',
      onChanged: (newValue) {
        Provider.of<HomeViewModel>(context, listen: false).changeTheme();
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
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.07,
            child: TextField(
              controller: _operationController,
              maxLines: 1,
              decoration: const InputDecoration(border: InputBorder.none),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: context.watch<HomeViewModel>().isDarkMode
                      ? Configs.operatorColorDarkMode
                      : Configs.operatorColorLightMode),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.14,
            child: TextField(
              controller: _resultController,
              maxLines: 1,
              decoration: const InputDecoration(border: InputBorder.none),
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.right,
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
          // 'C', '+/-', '%', '/'
          Row(
            children: [
              _subActionButton(
                context,
                operationToDisplaySymbol(Operation.reset),
              ),
              const SizedBox(width: 16),
              _iconButton(
                  context,
                  operationToDisplaySymbol(Operation.negation),
                  (context.read<HomeViewModel>().isDarkMode
                      ? Configs.subActionButtonColorDarkMode
                      : Configs.subActionButtonColorLightMode),
                  null),
              const SizedBox(width: 16),
              _subActionButton(
                context,
                operationToDisplaySymbol(Operation.persentage),
              ),
              const SizedBox(width: 16),
              _textButton(context, operationToDisplaySymbol(Operation.divide),
                  Configs.actionButtonColor, Colors.white),
            ],
          ),

          const SizedBox(height: 16),

          // '7', '8', '9', 'x'
          Row(
            children: [
              _numberButton(context, '7'),
              const SizedBox(width: 16),
              _numberButton(context, '8'),
              const SizedBox(width: 16),
              _numberButton(context, '9'),
              const SizedBox(width: 16),
              _operatorButton(
                  context, operationToDisplaySymbol(Operation.multiply)),
            ],
          ),

          const SizedBox(height: 16),

          // '4', '5', '6', '-'
          Row(
            children: [
              _numberButton(context, '4'),
              const SizedBox(width: 16),
              _numberButton(context, '5'),
              const SizedBox(width: 16),
              _numberButton(context, '6'),
              const SizedBox(width: 16),
              _operatorButton(
                  context, operationToDisplaySymbol(Operation.subtract)),
            ],
          ),

          const SizedBox(height: 16),

          // '1', '2', '3', '+'
          Row(
            children: [
              _numberButton(context, '1'),
              const SizedBox(width: 16),
              _numberButton(context, '2'),
              const SizedBox(width: 16),
              _numberButton(context, '3'),
              const SizedBox(width: 16),
              _operatorButton(context, operationToDisplaySymbol(Operation.add)),
            ],
          ),

          const SizedBox(height: 16),

          // '0', '.', '<', '='
          Row(
            children: [
              _textButton(
                  context, operationToDisplaySymbol(Operation.dot), null, null),
              const SizedBox(width: 16),
              _numberButton(context, '0'),
              const SizedBox(width: 16),
              _iconButton(context, operationToDisplaySymbol(Operation.delete),
                  null, null),
              const SizedBox(width: 16),
              _operatorButton(
                  context, operationToDisplaySymbol(Operation.equal)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _subActionButton(BuildContext context, String operator) {
    return _textButton(
        context,
        operator,
        (context.read<HomeViewModel>().isDarkMode
            ? Configs.subActionButtonColorDarkMode
            : Configs.subActionButtonColorLightMode),
        null);
  }

  Widget _numberButton(BuildContext context, String number) {
    return _textButton(context, number, null, null);
  }

  Widget _operatorButton(BuildContext context, String operator) {
    return _textButton(
        context, operator, Configs.actionButtonColor, Colors.white);
  }

  Widget _textButton(BuildContext context, String number,
      Color? backgroundColor, Color? textColor) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    return Expanded(
      child: SizedBox(
        height: screenHeight > screenWidth ? screenHeight * 0.09 : 72,
        child: ElevatedButton(
          onPressed: () {
            if (number == operationToDisplaySymbol(Operation.reset)) {
              _operationController.text = '0';
              _resultController.text = '0';
            } else if (number == operationToDisplaySymbol(Operation.equal)) {
              try {
                final result = _operationController.text;
                _resultController.text =
                    context.read<HomeViewModel>().evaluateExpression(result);
              } catch (e) {
                _resultController.text = 'Error';
              }
            } else {
              if (_operationController.text == '0') {
                if (number != operationToDisplaySymbol(Operation.dot)) {
                  _operationController.text = number;
                } else {
                  _operationController.text += number;
                }
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
              backgroundColor: WidgetStatePropertyAll(backgroundColor ??
                  (context.read<HomeViewModel>().isDarkMode
                      ? Configs.numberColorDarkMode
                      : Configs.numberColorLightMode))),
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
      Color? backgroundColor, Color? iconColor) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;
    return Expanded(
      child: SizedBox(
        height: screenHeight > screenWidth ? screenHeight * 0.09 : 72,
        child: ElevatedButton(
          onPressed: () {
            if (iconPath == operationToDisplaySymbol(Operation.delete)) {
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
              backgroundColor: WidgetStatePropertyAll(backgroundColor ??
                  (context.read<HomeViewModel>().isDarkMode
                      ? Configs.numberColorDarkMode
                      : Configs.numberColorLightMode))),
          child: SvgPicture.asset(
            iconPath,
            height: 26,
            width: 26,
            colorFilter: iconColor != null
                ? ColorFilter.mode(iconColor, BlendMode.srcIn)
                : ColorFilter.mode(
                    Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
