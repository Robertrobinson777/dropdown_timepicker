/// List of hours in 12-hour format.
final List<int> listHours =
    List<int>.unmodifiable(List<int>.generate(12, (int index) => index + 1));

/// List of hours in 24-hour format.
final List<int> list24Hours =
    List<int>.unmodifiable(List<int>.generate(24, (int index) => index));

/// List of minutes.
final List<int> listMins =
    List<int>.unmodifiable(List<int>.generate(60, (int index) => index));

/// List of seconds.
final List<int> seconds =
    List<int>.unmodifiable(List<int>.generate(60, (int index) => index));

/// List of milliseconds.
final List<int> milliseconds =
    List<int>.unmodifiable(List<int>.generate(1000, (int index) => index));

/// List of microseconds.
final List<int> microseconds =
    List<int>.unmodifiable(List<int>.generate(1000, (int index) => index));

/// List of nanoseconds.
final List<int> nanoseconds =
    List<int>.unmodifiable(List<int>.generate(1000, (int index) => index));

/// AM/PM values for 12-hour mode.
const List<String> listAmPm = <String>['AM', 'PM'];
