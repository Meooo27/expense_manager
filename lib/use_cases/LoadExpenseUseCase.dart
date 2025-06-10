import 'package:expense_manager/data_layers/repositories/ExpenseRepository.dart';
import 'package:expense_manager/models/expense_model.dart';

abstract class LoadExpenseUseCase {
  List<ExpenseModel> loadData();
}

class LoadExpenseUseCaseImpl extends LoadExpenseUseCase {
  LoadExpenseUseCaseImpl({required this.repository});

  final ExpenseRepository repository;

  @override
  List<ExpenseModel> loadData() {
    return repository.loadData();
  }
}
