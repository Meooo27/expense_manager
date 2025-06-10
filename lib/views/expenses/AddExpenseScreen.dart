import 'package:expense_manager/models/category_model.dart';
import 'package:expense_manager/views/OpenDatePicker.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/view_models/ExpenseViewModel.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key, required this.onSavedData});

  final Function() onSavedData;

  @override
  State<StatefulWidget> createState() {
    return _AddExpenseScreen();
  }
}

class _AddExpenseScreen extends State<AddExpenseScreen> {
  final ExpenseViewModel _viewModel = ExpenseViewModel(() {});
  DateTime dateTime = DateTime.now();
  late OpenDatePicker openDatePicker;
  Category dropdownValue = Category.housing;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    openDatePicker = OpenDatePicker(
      selectedDate: dateTime,
      onDateChanged: (selectedDate) {
        setState(() {
          dateTime = selectedDate;
        });
      },
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _unfocusTextField() {
    FocusScope.of(context).unfocus();
  }

  void _saveData() {
    bool isValid = _viewModel.validateData(
      titleController.text,
      amountController.text,
    );
    if (isValid) {
      _viewModel.saveData(
        titleController.text,
        double.parse(amountController.text),
        dropdownValue,
        dateTime,
      );
      Navigator.pop(context);
      widget.onSavedData();
    } else {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              spacing: 16.0,
              children: [
                Text(
                  'Add Expense',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                TextField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    prefixText: 'đ ',
                    labelText: 'Amount',
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          underline: Container(),
                          menuMaxHeight: 200.0,
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          items:
                              Category.values
                                  .map(
                                    (item) => DropdownMenuItem(
                                      value: item,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image(
                                            image: item.icon,
                                            width: 24.0,
                                            height: 24.0,
                                          ),
                                          const SizedBox(width: 8.0),
                                          Flexible(
                                            child: Text(
                                              item.title,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (Category? value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    openDatePicker,
                  ],
                ),
                SizedBox(height: 32.0),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: _saveData,
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.blue),
                        ),
                        child: Text('Save', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
