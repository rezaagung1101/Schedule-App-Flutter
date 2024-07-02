class Helper {
  String getDayName(int day) {
    switch (day) {
      case 0:
        return 'Sunday';
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      default:
        return 'Invalid day';
    }
  }

  String getDayCountFormat(int day) {
    int dayIndex = day + 1;
    switch (dayIndex) {
      case 1:
        return '${dayIndex}st';
      case 2:
        return '${dayIndex}nd';
      case 3:
        return '${dayIndex}rd';
      default:
        return '${dayIndex}th';
    }
  }
}
