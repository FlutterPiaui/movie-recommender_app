extension DurationFormatting on int {
  String toHoursMinutesFromMinutes() {
    if (this <= 0) return 'Invalid duration';

    final hours = this ~/ 60;
    final minutes = this % 60;

    if (hours > 0 && minutes > 0) {
      return '${hours}h ${minutes}m';
    } else if (hours > 0) {
      return '${hours}h';
    } else {
      return '${minutes}m';
    }
  }
}
