import 'package:expense_manager/data_layers/repositories/ExpenseRepository.dart';
import 'package:expense_manager/models/expense_model.dart';

abstract class AddExpenseUseCase {
  void add(ExpenseModel expense);
}

class AddExpenseUseCaseImpl extends AddExpenseUseCase {
  AddExpenseUseCaseImpl({required this.repository});

  final ExpenseRepository repository;

  @override
  void add(ExpenseModel expense) {
    repository.add(expense);
  }
}
