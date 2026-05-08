// View-model helpers for displaying Expense rows: derive the visible
// payment tag (filtering out the placeholder "General") and compose the
// list-row subtitle from category and payment tag.

import '../models/expense.dart';

String? effectivePaymentTag(Expense expense) {
  final t = expense.tag.trim();
  if (t.isEmpty || t.toLowerCase() == 'general') {
    return null;
  }
  return t;
}

String? entrySubtitle(Expense expense) {
  final pay = effectivePaymentTag(expense);
  if (expense.name.trim().isEmpty) {
    return pay;
  }
  if (pay != null) {
    return '${expense.category} • $pay';
  }
  return expense.category;
}
