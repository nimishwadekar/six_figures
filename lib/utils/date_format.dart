// Date formatting helpers: ISO-like yyyy-MM-dd output and the long
// human-readable header used above each day's expense group
// (e.g. "Friday, 9th May").

String formatDate(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}-$month-$day';
}

String _dayOrdinalSuffix(int d) {
  if (d >= 11 && d <= 13) {
    return 'th';
  }
  switch (d % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

String dayHeaderLabel(DateTime day) {
  const weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  const monthsShort = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  return '${weekdays[day.weekday - 1]}, '
      '${day.day}${_dayOrdinalSuffix(day.day)} ${monthsShort[day.month - 1]}';
}
