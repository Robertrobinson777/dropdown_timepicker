<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->


## Dropdown TimePicker 
[![Pub](https://img.shields.io/badge/pub-v0.0.1-green)](https://pub.dev/packages/dropdown_timepicker)

A Dropdown Time picker for Flutter with customizable options.

## Features

<p float="left">

<img src="https://raw.githubusercontent.com/Robertrobinson777/dropdown_date_picker/main/SCR-12.png" alt="Main View" width="200"/>
<img src="https://raw.githubusercontent.com/Robertrobinson777/dropdown_date_picker/main/SCR-24.png" alt="monthview" width="200"/>
<img src="https://raw.githubusercontent.com/Robertrobinson777/dropdown_date_picker/main/SCR-24error.png" alt="dateview" width="200"/>
</p>

## Getting started

```dart
DropdownTimePicker()
```

## Usage

For more [Example](https://github.com/Robertrobinson777/dropdown_timepicker/tree/master/example)

```dart
   DropdownTimePicker(
                // inputDecoration: InputDecoration(
                //     enabledBorder: const OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.grey, width: 1.0),
                //     ),
                //     helperText: '',
                //     contentPadding: const EdgeInsets.all(8),
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10))), // optional
                isDropdownHideUnderline: true, // optional
                isFormValidator: true, // optional

                width: 10, // optional
                // is24format: true,
                selectedAmPm: _selectedAmPm, // optional
                selectedMins: _selectedMins, // optional
                selectedHours: _selectedHours, // optional
                onChangedAmPm: (value) {
                  _selectedAmPm = value!;
                  print('onChangedAmPm: $value');
                },
                onChangedMins: (value) {
                  _selectedMins = int.parse(value!);
                  print('onChangedMins $value');
                },
                onChangedHours: (value) {
                  _selectedHours = int.parse(value!);
                  print('onChangedHours: $value');
                },
                //boxDecoration: BoxDecoration(
                // border: Border.all(color: Colors.grey, width: 1.0)), // optional

                // hintTextStyle: TextStyle(color: Colors.grey), // optional
              ),
```

## GitHub source code

If you're interested on the code (feel free to modify it anyway you want), you can find it here: [https://github.com/Robertrobinson777/dropdown_timepicker](https://github.com/Robertrobinson777/dropdown_timepicker)

## Support

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/robertrobinsonr)
