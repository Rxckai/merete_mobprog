const List<String> _months = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December',
];

/// 100000 -> 100K, 1500 -> 1.5K, 2300000 -> 2.3M
String formatCount(int n) {
  if (n >= 1000000) {
    return '${(n / 1000000).toStringAsFixed(n % 1000000 == 0 ? 0 : 1)}M';
  }
  if (n >= 1000) {
    return '${(n / 1000).toStringAsFixed(n % 1000 == 0 ? 0 : 1)}K';
  }
  return n.toString();
}

/// Facebook-style post date:
///  - under an hour  -> "15m"
///  - under a day    -> "5h"
///  - under a week   -> "3d"
///  - this year      -> "October 11"
///  - older          -> "December 18, 2025"
String formatPostDate(DateTime date, {DateTime? now}) {
  final current = now ?? DateTime.now();
  final diff = current.difference(date);

  if (!diff.isNegative) {
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m';
    if (diff.inDays < 1) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
  }

  final monthDay = '${_months[date.month - 1]} ${date.day}';
  return date.year == current.year ? monthDay : '$monthDay, ${date.year}';
}

/// Notification time: "5m ago", "2h ago", "3d ago", or a date.
String formatNotificationTime(DateTime date, {DateTime? now}) {
  final formatted = formatPostDate(date, now: now);
  final isRelative = RegExp(r'^\d+[mhd]$').hasMatch(formatted);
  return isRelative ? '$formatted ago' : formatted;
}
