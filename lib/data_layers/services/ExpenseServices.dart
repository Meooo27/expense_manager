import 'package:expense_manager/models/expense_model.dart';
import 'package:expense_manager/models/category_model.dart';

List<ExpenseModel> expenses = [
  ExpenseModel("Housing", DateTime.now(), Category.housing, 100_000_000.0),
  ExpenseModel("Clothing", DateTime.now(), Category.clothing, 2000.0),
  ExpenseModel("Health Care", DateTime.now(), Category.healthCare, 3000.0),
  ExpenseModel("Health Care", DateTime.now(), Category.healthCare, 5200.0),
  ExpenseModel("Health Care", DateTime.now(), Category.healthCare, 13579.0),
];

class ExpenseServices {
  List<ExpenseModel> loadData() {
    return expenses.reversed.toList();
  }

  void add(ExpenseModel expense) {
    expenses.add(expense);
  }

  void delete(ExpenseModel expense) {
    expenses.removeWhere((e) => e.id == expense.id);
  }
}