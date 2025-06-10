import 'package:expense_manager/models/category_model.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ExpenseModel {
  ExpenseModel(this.title, this._dateTime, this.category, this._money);

  final String _id = uuid.v4();
  final String title;
  final DateTime _dateTime;
  final Category category;
  final double _money;

  String get id {
    return _id;
  }

  String get dateTime {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(_dateTime);
  }

  String get money {
    MoneyFormatter moneyFormatter = MoneyFormatter(amount: _money);
    return moneyFormatter.output.compactNonSymbol;
  }
}