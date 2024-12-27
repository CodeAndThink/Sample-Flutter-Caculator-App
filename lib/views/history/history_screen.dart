import 'package:caculator_app/common/views/custom_app_bar.dart';
import 'package:caculator_app/manager/data_manager.dart';
import 'package:caculator_app/views/history/history_view_model.dart';
import 'package:caculator_app/views/history/item/history_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HistoryViewModel(DataManager.shared),
      builder: (context, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(title: 'History', rightButtonAction: () {}),
              Consumer<HistoryViewModel>(builder: (context, vm, child) {
                if (vm.historyOperation.isEmpty) {
                  return const Center(
                    child: Text('No data available!'),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: vm.historyOperation.length,
                        itemBuilder: (context, index) {
                          return HistoryItem(data: vm.historyOperation[index]);
                        }),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
