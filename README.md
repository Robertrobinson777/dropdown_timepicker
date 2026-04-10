# Dropdown TimePicker

[![Pub Version](https://img.shields.io/badge/pub-1.0.0-brightgreen)](https://pub.dev/packages/dropdown_timepicker)

`dropdown_timepicker` is a dropdown-based time picker for Flutter forms. It supports 12-hour and 24-hour layouts, optional field visibility, custom styling, and built-in validation.

## Highlights

- 12-hour and 24-hour time selection
- Configurable hour range with `startHours` and `endHours`
- Optional hours, minutes, and AM/PM dropdowns
- Safe handling of invalid initial values
- Form validation support with custom error messages
- Example app included in the repository

## Preview

<p float="left">
  <img src="https://raw.githubusercontent.com/Robertrobinson777/dropdown_timepicker/main/SCR-12.png" alt="12-hour dropdown time picker" width="200"/>
  <img src="https://raw.githubusercontent.com/Robertrobinson777/dropdown_timepicker/main/SCR-24.png" alt="24-hour dropdown time picker" width="200"/>
  <img src="https://raw.githubusercontent.com/Robertrobinson777/dropdown_timepicker/main/SCR-24error.png" alt="Dropdown time picker validation" width="200"/>
</p>

## Installation

Add the package to `pubspec.yaml`:

```yaml
dependencies:
  dropdown_timepicker: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Basic Usage

```dart
DropdownTimePicker(
  onChangedHours: (value) {
    debugPrint('Hours: $value');
  },
  onChangedMins: (value) {
    debugPrint('Minutes: $value');
  },
  onChangedAmPm: (value) {
    debugPrint('AM/PM: $value');
  },
)
```

## Example With Validation

```dart
final formKey = GlobalKey<FormState>();

Form(
  key: formKey,
  child: DropdownTimePicker(
    isFormValidator: true,
    isDropdownHideUnderline: true,
    selectedHours: 9,
    selectedMins: 30,
    selectedAmPm: 'AM',
    onChangedHours: (value) {
      debugPrint('Hours: $value');
    },
    onChangedMins: (value) {
      debugPrint('Minutes: $value');
    },
    onChangedAmPm: (value) {
      debugPrint('AM/PM: $value');
    },
  ),
)
```

## Common Configurations

### 24-hour mode

```dart
const DropdownTimePicker(
  is24format: true,
  selectedHours: 18,
  selectedMins: 45,
)
```

### Limit the available hours

```dart
const DropdownTimePicker(
  startHours: 9,
  endHours: 17,
)
```

### Hide specific selectors

```dart
const DropdownTimePicker(
  showAmPm: false,
  showMins: false,
)
```

## Notes

- In 12-hour mode, valid hour values are `1..12`.
- In 24-hour mode, valid hour values are `0..23`.
- Invalid initial values are ignored instead of causing runtime issues.
- `showAmPm` is ignored automatically when `is24format` is `true`.

## Example App

The example project lives in the repository at [example](https://github.com/Robertrobinson777/dropdown_timepicker/tree/main/example).

## Source and Support

- Repository: [github.com/Robertrobinson777/dropdown_timepicker](https://github.com/Robertrobinson777/dropdown_timepicker)
- Issues: [github.com/Robertrobinson777/dropdown_timepicker/issues](https://github.com/Robertrobinson777/dropdown_timepicker/issues)
- Web demo: [timepicker.robertrobinson.in](https://timepicker.robertrobinson.in/)
- Support: [Buy Me a Coffee](https://www.buymeacoffee.com/robertrobinsonr)
