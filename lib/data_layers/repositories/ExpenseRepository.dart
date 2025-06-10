import 'package:expense_manager/data_layers/services/ExpenseServices.dart';
import 'package:expense_manager/models/expense_model.dart';

abstract class ExpenseRepository {
  List<ExpenseModel> loadData();
  void add(ExpenseModel expense);
  void delete(ExpenseModel expense);
}

class ExpenseRepositoryImpl extends ExpenseRepository {
  ExpenseRepositoryImpl({required this.expenseServices});

  final ExpenseServices expenseServices;

  @override
  void add(ExpenseModel expense) {
    expenseServices.add(expense);
  }

  @override
  void delete(ExpenseModel expense) {
    expenseServices.delete(expense);
  }

  @override
  List<ExpenseModel> loadData() {
    return expenseServices.loadData();
  }
}