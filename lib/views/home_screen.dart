import 'package:caculator_app/common/views/custom_switch_button.dart';
import 'package:caculator_app/common/views/custom_tooltip.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appBar(context),
            const Spacer(),
            _resultArea(context),
            _numberPad(context),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Center(
        child: CustomSwitchButton(
      value: !context.watch<HomeViewModel>().isDarkMode,
      inactiveImage: getGlobaleAssets(GlobalAssets.moonIcon),
      activieImage: getGlobaleAssets(GlobalAssets.sunIcon),
      onChanged: (newValue) {
        Provider.of<HomeViewModel>(context, listen: false).changeTheme();
      },
    ));
  }

  Widget _resultArea(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    return Container(
      width: screenWidth - 32,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Selector<HomeViewModel, String>(
              builder: (context, data, child) {
                return FittedBox(
                  child: Text(
                    data,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: context.watch<HomeViewModel>().isDarkMode
                            ? Configs.operatorColorDarkMode
                            : Configs.operatorColorLightMode,
                        height: 0),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                  ),
                );
              },
              selector: (context, viewmodel) => viewmodel.operationString),
          CustomTooltip(
            data: context.read<HomeViewModel>().operationResult,
            child: Selector<HomeViewModel, String>(
                builder: (context, data, child) {
                  return FittedBox(
                    child: Text(
                      data,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(height: 0),
                      textAlign: TextAlign.right,
                      maxLines: 2,
                    ),
                  );
                },
                selector: (context, viewmodel) => viewmodel.operationResult),
          ),
        ],
      ),
    );
  }

  Widget _numberPad(BuildContext context) {
    // Number pad map
    // ['C', '+/-', '%' , '/']
    // ['7',  '8' , '9' , 'x']
    // ['4',  '5' , '6' , '-']
    // ['1',  '2' , '3' , '+']
    // ['.',  '0' ,'DEL', '=']

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 'C', '+/-', '%', '/'
          Row(
            children: [
              // 'C'
              _subActionButton(
                context,
                operationToDisplaySymbol(Operation.reset),
              ),
              const SizedBox(width: 16),
              // '+/-'
              _iconButton(
                  context,
                  operationToDisplaySymbol(Operation.negation),
                  (context.read<HomeViewModel>().isDarkMode
                      ? Configs.subActionButtonColorDarkMode
                      : Configs.subActionButtonColorLightMode),
                  null),
              const SizedBox(width: 16),
              // '%'
              _subActionButton(
                context,
                operationToDisplaySymbol(Operation.persentage),
              ),
              const SizedBox(width: 16),
              // '/'
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
    return Expanded(
      child: SizedBox(
        height: screenHeight * 0.09,
        child: ElevatedButton(
          onPressed: () {
            if (number == operationToDisplaySymbol(Operation.reset)) {
              Provider.of<HomeViewModel>(context, listen: false).resetAction();
            } else if (number == operationToDisplaySymbol(Operation.equal)) {
              Provider.of<HomeViewModel>(context, listen: false)
                  .equalAction();
            } else {
              Provider.of<HomeViewModel>(context, listen: false)
                  .insertOperationAction(number);
              Provider.of<HomeViewModel>(context, listen: false)
                  .calculationAction();
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
                      : Configs.numberColorLightMode)),
              elevation: WidgetStateProperty.all(0)),
          child: Text(
            number,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: textColor, height: 0),
          ),
        ),
      ),
    );
  }

  Widget _iconButton(BuildContext context, String iconPath,
      Color? backgroundColor, Color? iconColor) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    return Expanded(
      child: SizedBox(
        height: screenHeight * 0.09,
        child: ElevatedButton(
          onPressed: () {
            if (iconPath == operationToDisplaySymbol(Operation.delete)) {
              Provider.of<HomeViewModel>(context, listen: false).deleteAction();
            } else if (iconPath ==
                operationToDisplaySymbol(Operation.negation)) {
              Provider.of<HomeViewModel>(context, listen: false).negateAction();
            } else {
              Provider.of<HomeViewModel>(context, listen: false)
                  .insertOperationAction(iconPath);
            }
            Provider.of<HomeViewModel>(context, listen: false)
                .calculationAction();
          },
          style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              )),
              backgroundColor: WidgetStatePropertyAll(backgroundColor ??
                  (context.read<HomeViewModel>().isDarkMode
                      ? Configs.numberColorDarkMode
                      : Configs.numberColorLightMode)),
              elevation: WidgetStateProperty.all(0)),
          child: SvgPicture.asset(
            iconPath,
            height: 26,
            width: 26,
            colorFilter: iconColor != null
                ? ColorFilter.mode(iconColor, BlendMode.srcIn)
                : ColorFilter.mode(
                    Theme.of(context).colorScheme.secondary,
                    BlendMode.srcIn,
                  ),
          ),
        ),
      ),
    );
  }
}
