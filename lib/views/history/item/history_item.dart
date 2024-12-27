import 'package:caculator_app/model/model/operation.dart';
import 'package:flutter/material.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key, required this.data});
  final Operation data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
          padding: const EdgeInsets.all(6),
          child: Text(
            '${data.operationString} = ${data.operationResult}',
            textAlign: TextAlign.end, style: Theme.of(context).textTheme.headlineSmall,
          )),
    );
  }
}
