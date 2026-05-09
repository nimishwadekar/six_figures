// View helpers for Income list rows (subtitle from category and tag).

import '../models/income.dart';

String? incomeEffectivePaymentTag(Income income) {
  final t = income.tag.trim();
  if (t.isEmpty || t.toLowerCase() == 'general') {
    return null;
  }
  return t;
}

String? incomeEntrySubtitle(Income income) {
  final pay = incomeEffectivePaymentTag(income);
  if (income.name.trim().isEmpty) {
    return pay;
  }
  if (pay != null) {
    return '${income.category} • $pay';
  }
  return income.category;
}
