import 'package:expense_manager/data_layers/repositories/ExpenseRepository.dart';
import 'package:expense_manager/models/expense_model.dart';

abstract class DeleteExpenseUseCase {
  void delete(ExpenseModel expense);
}

class DeleteExpenseUseCaseImpl extends DeleteExpenseUseCase {
  DeleteExpenseUseCaseImpl({required this.repository});

  final ExpenseRepository repository;

  @override
  void delete(ExpenseModel expense) {
    repository.delete(expense);
  }
}
