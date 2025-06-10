import 'package:flutter/material.dart';

import '../../models/expense_model.dart';
import '../../view_models/ExpenseViewModel.dart';

class ListAddedExpense extends StatefulWidget {
  const ListAddedExpense(this.arr, this.viewModel, {super.key});

  final ExpenseViewModel viewModel;
  final List<ExpenseModel> arr;

  @override
  State<StatefulWidget> createState() {
    return _ListAddedExpenseState();
  }
}

class _ListAddedExpenseState extends State<ListAddedExpense> {
  void _onRemovedListItemAt(int index) {
    ExpenseModel expenseModel = widget.arr[index];
    widget.viewModel.deleteData(expenseModel);
    setState(() {
      widget.arr.remove(expenseModel);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text('${expenseModel.title} deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            widget.viewModel.saveData2(expenseModel);
            setState(() {
              if (index >= widget.arr.length) {
                widget.arr.add(expenseModel);
              } else {
                widget.arr.insert(index, expenseModel);
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: widget.arr.length,
        itemBuilder:
            (context, index) => Dismissible(
          key: ValueKey(widget.arr[index]),
          onDismissed: (_) {
            _onRemovedListItemAt(index);
          },
          child: Card(
            margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.arr[index].title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.arr[index].money}đ',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Row(
                        children: [
                          Image(
                            image: widget.arr[index].category.icon,
                            width: 32.0,
                            height: 32.0,
                          ),
                          const SizedBox(width: 12.0),
                          Text(widget.arr[index].dateTime),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}