import 'package:flutter/cupertino.dart';

enum Category {
  housing('Housing'),
  healthCare('Health care'),
  insurance('Insurance'),
  transportation('Transportation'),
  entertainment('Entertainment'),
  clothing('Clothing'),
  personal('personal'),
  gifts('Gifts'),
  savings('Savings'),
  schoolFees('School Fees');
  const Category(this._title);
  final String _title;

  String get title {
    return _title;
  }

  AssetImage get icon {
    switch (this) {
      case Category.housing:
        return const AssetImage('assets/images/housing.png');
      case Category.healthCare:
        return const AssetImage('assets/images/health_care.png');
      case Category.insurance:
        return const AssetImage('assets/images/insurance.png');
      case Category.transportation:
        return const AssetImage('assets/images/transportation.png');
      case Category.entertainment:
        return const AssetImage('assets/images/entertainment.png');
      case Category.clothing:
        return const AssetImage('assets/images/clothing.png');
      case Category.personal:
        return const AssetImage('assets/images/personal.png');
      case Category.gifts:
        return const AssetImage('assets/images/gifts.png');
      case Category.savings:
        return const AssetImage('assets/images/saving.png');
      case Category.schoolFees:
        return const AssetImage('assets/images/tuition_fees.png');
    }
  }
}
