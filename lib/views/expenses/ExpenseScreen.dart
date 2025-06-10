import 'package:expense_manager/models/expense_model.dart';
import 'package:expense_manager/views/expenses/AddExpenseScreen.dart';
import 'package:expense_manager/view_models/ExpenseViewModel.dart';
import 'package:flutter/material.dart';

import 'ExpenseBarChart.dart';
import 'ListAddedExpense.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpenseScreen();
  }
}

class _ExpenseScreen extends State<ExpenseScreen> {
  late final ExpenseViewModel _viewModel;
  List<ExpenseModel> arr = [];

  @override
  void initState() {
    super.initState();
    _viewModel = ExpenseViewModel(() {
      setState(() {
        arr = _viewModel.getData;
      });
    });
    arr = _viewModel.getData;
  }

  void showBottomSheet() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(maxWidth: double.infinity),
      builder:
          (builder) => AddExpenseScreen(
            onSavedData: () {
              setState(() {
                arr = _viewModel.getData;
              });
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Expense Manager',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body:
          width < 600
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 32.0),
                  SizedBox(height: 200.0, child: BarChartExpense(arr)),
                  SizedBox(height: 8.0),
                  Text('Expense Chart', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 24.0),
                  Expanded(child: ListAddedExpense(arr, _viewModel)),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              0.0,
                              32.0,
                              0.0,
                              0.0,
                            ),
                            child: BarChartExpense(arr),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Expense Chart',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                  Expanded(child: ListAddedExpense(arr, _viewModel)),
                ],
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: showBottomSheet,
        backgroundColor: Colors.white,
        child: Image.asset(
          'assets/images/ic_add.png',
          width: 24.0,
          height: 24.0,
        ),
      ),
    );
  }
}
