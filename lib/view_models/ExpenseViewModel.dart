import 'dart:ffi';

import 'package:expense_manager/data_layers/repositories/ExpenseRepository.dart';
import 'package:expense_manager/data_layers/services/ExpenseServices.dart';
import 'package:expense_manager/models/expense_model.dart';
import 'package:expense_manager/use_cases/LoadExpenseUseCase.dart';

import '../models/category_model.dart';
import '../use_cases/AddExpenseUseCase.dart';
import '../use_cases/DeleteExpenseUseCase.dart';

class ExpenseViewModel {
  late final ExpenseServices _expenseServices;
  late final ExpenseRepository _expenseRepository;
  late final LoadExpenseUseCase _loadExpenseUseCase;
  late final AddExpenseUseCase _addExpenseUseCase;
  late final DeleteExpenseUseCase _deleteExpenseUseCase;

  List<ExpenseModel> arr = [];

  Function() onDataChanged;

  ExpenseViewModel(this.onDataChanged) {
    _expenseServices = ExpenseServices();
    _expenseRepository = ExpenseRepositoryImpl(expenseServices: _expenseServices);
    _loadExpenseUseCase = LoadExpenseUseCaseImpl(repository: _expenseRepository);
    _addExpenseUseCase = AddExpenseUseCaseImpl(repository: _expenseRepository);
    _deleteExpenseUseCase = DeleteExpenseUseCaseImpl(repository: _expenseRepository);
  }

  List<ExpenseModel> get getData {
    return _loadExpenseUseCase.loadData();
  }

  bool validateData(String? title, String? amount) {
    return !(title == null || title.isEmpty || amount == null || amount.isEmpty);
  }

  void saveData(String title, double amount, Category category, DateTime dateTime) {
    ExpenseModel expenseModel = ExpenseModel(title, dateTime, category, amount);
    _addExpenseUseCase.add(expenseModel);
    onDataChanged();
  }

  void saveData2(ExpenseModel expense) {
    _addExpenseUseCase.add(expense);
    onDataChanged();
  }

  void deleteData(ExpenseModel expense) {
    _deleteExpenseUseCase.delete(expense);
    onDataChanged();
  }
}