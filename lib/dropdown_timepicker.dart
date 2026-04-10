import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'list_time.dart';

/// A configurable dropdown-based time picker for Flutter forms.
///
/// The widget supports both 12-hour and 24-hour layouts and can show or hide
/// the hours, minutes, and AM/PM selectors independently.
class DropdownTimePicker extends StatefulWidget {
  /// Creates a dropdown-based time picker.
  const DropdownTimePicker({
    super.key,
    this.textStyle,
    this.boxDecoration,
    this.inputDecoration,
    this.icon,
    this.startHours,
    this.endHours,
    this.width = 12.0,
    this.onChangedAmPm,
    this.onChangedMins,
    this.onChangedHours,
    this.isDropdownHideUnderline = false,
    this.errorAmPm = 'Please select AM/PM',
    this.errorMins = 'Please select minutes',
    this.errorHours = 'Please select hours',
    this.hintMins = 'Mins',
    this.hintAmPm = 'AM/PM',
    this.hintHours = 'Hours',
    this.hintTextStyle,
    this.isFormValidator = false,
    this.isExpanded = true,
    this.selectedAmPm,
    this.selectedMins,
    this.selectedHours,
    this.is24format = false,
    this.showAmPm = true,
    this.showMins = true,
    this.showHours = true,
    this.minFlex = 2,
    this.ampmFlex = 1,
    this.hourFlex = 2,
  });

  /// Text style used by dropdown items and selected values.
  final TextStyle? textStyle;

  /// Decoration applied around each dropdown container.
  final BoxDecoration? boxDecoration;

  /// Input decoration applied to each dropdown form field.
  final InputDecoration? inputDecoration;

  /// Optional dropdown icon.
  final Icon? icon;

  /// Inclusive starting hour for the hours dropdown.
  ///
  /// In 12-hour mode valid values are `1..12`.
  /// In 24-hour mode valid values are `0..23`.
  final int? startHours;

  /// Inclusive ending hour for the hours dropdown.
  ///
  /// In 12-hour mode valid values are `1..12`.
  /// In 24-hour mode valid values are `0..23`.
  final int? endHours;

  /// Horizontal spacing between visible dropdowns.
  final double width;

  /// Called when the AM/PM dropdown changes.
  final ValueChanged<String?>? onChangedAmPm;

  /// Called when the minutes dropdown changes.
  final ValueChanged<String?>? onChangedMins;

  /// Called when the hours dropdown changes.
  final ValueChanged<String?>? onChangedHours;

  /// Validation message shown when AM/PM is required.
  final String errorAmPm;

  /// Validation message shown when minutes are required.
  final String errorMins;

  /// Validation message shown when hours are required.
  final String errorHours;

  /// Hint shown for the minutes dropdown.
  final String hintMins;

  /// Hint shown for the hours dropdown.
  final String hintHours;

  /// Hint shown for the AM/PM dropdown.
  final String hintAmPm;

  /// Hint text style for each dropdown.
  final TextStyle? hintTextStyle;

  /// Whether validators should require visible dropdowns to have a value.
  final bool isFormValidator;

  /// Whether dropdowns should take up the available width.
  final bool isExpanded;

  /// Initial or externally controlled AM/PM value.
  final String? selectedAmPm;

  /// Initial or externally controlled minutes value.
  final int? selectedMins;

  /// Initial or externally controlled hours value.
  final int? selectedHours;

  /// Whether the underline should be hidden.
  final bool isDropdownHideUnderline;

  /// Whether the hours dropdown should be visible.
  final bool showHours;

  /// Whether the minutes dropdown should be visible.
  final bool showMins;

  /// Whether the AM/PM dropdown should be visible in 12-hour mode.
  final bool showAmPm;

  /// Flex for the minutes dropdown.
  final int minFlex;

  /// Flex for the AM/PM dropdown.
  final int ampmFlex;

  /// Flex for the hours dropdown.
  final int hourFlex;

  /// Whether the widget uses a 24-hour clock.
  final bool is24format;

  @override
  State<DropdownTimePicker> createState() => _DropdownTimePickerState();
}

class _DropdownTimePickerState extends State<DropdownTimePicker> {
  late List<int> _hourOptions;
  late String _ampmSelVal;
  late String _minSelVal;
  late String _hourSelVal;

  @override
  void initState() {
    super.initState();
    _hourOptions = _buildHourOptions();
    _ampmSelVal = _sanitizeAmPm(widget.selectedAmPm);
    _minSelVal = _sanitizeIntSelection(widget.selectedMins, listMins);
    _hourSelVal = _sanitizeIntSelection(widget.selectedHours, _hourOptions);
  }

  @override
  void didUpdateWidget(covariant DropdownTimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    final shouldRefreshHours = oldWidget.is24format != widget.is24format ||
        oldWidget.startHours != widget.startHours ||
        oldWidget.endHours != widget.endHours;

    if (shouldRefreshHours) {
      _hourOptions = _buildHourOptions();
      if (!_isValidIntSelection(_hourSelVal, _hourOptions)) {
        _hourSelVal = _sanitizeIntSelection(widget.selectedHours, _hourOptions);
      }
    }

    if (oldWidget.selectedHours != widget.selectedHours) {
      _hourSelVal = _sanitizeIntSelection(widget.selectedHours, _hourOptions);
    }

    if (oldWidget.selectedMins != widget.selectedMins) {
      _minSelVal = _sanitizeIntSelection(widget.selectedMins, listMins);
    }

    if (shouldRefreshHours || oldWidget.selectedAmPm != widget.selectedAmPm) {
      _ampmSelVal = _sanitizeAmPm(widget.selectedAmPm);
    }
  }

  List<int> _buildHourOptions() {
    final minimumHour = widget.is24format ? 0 : 1;
    final maximumHour = widget.is24format ? 23 : 12;

    final start =
        _clamp(widget.startHours ?? minimumHour, minimumHour, maximumHour);
    final end =
        _clamp(widget.endHours ?? maximumHour, minimumHour, maximumHour);
    final rangeStart = math.min(start, end);
    final rangeEnd = math.max(start, end);

    return List<int>.unmodifiable(
      List<int>.generate(
          rangeEnd - rangeStart + 1, (index) => rangeStart + index),
    );
  }

  int _clamp(int value, int min, int max) {
    return value.clamp(min, max).toInt();
  }

  String _sanitizeAmPm(String? value) {
    if (widget.is24format) {
      return '';
    }

    final normalized = value?.trim().toUpperCase();
    return normalized != null && listAmPm.contains(normalized)
        ? normalized
        : '';
  }

  String _sanitizeIntSelection(int? value, List<int> options) {
    if (value == null || !options.contains(value)) {
      return '';
    }

    return value.toString();
  }

  bool _isValidIntSelection(String value, List<int> options) {
    final parsedValue = int.tryParse(value);
    return parsedValue != null && options.contains(parsedValue);
  }

  void _updateMins(String? value) {
    setState(() {
      _minSelVal = value ?? '';
    });
    widget.onChangedMins?.call(value);
  }

  void _updateAmPm(String? value) {
    setState(() {
      _ampmSelVal = value ?? '';
    });
    widget.onChangedAmPm?.call(value);
  }

  void _updateHours(String? value) {
    setState(() {
      _hourSelVal = value ?? '';
    });
    widget.onChangedHours?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final dropdowns = <Widget>[
      if (widget.showHours)
        Expanded(
          flex: math.max(widget.hourFlex, 1),
          child: _wrapDropdown(
            child: _buildHoursDropdown(),
          ),
        ),
      if (widget.showMins)
        Expanded(
          flex: math.max(widget.minFlex, 1),
          child: _wrapDropdown(
            child: _buildMinsDropdown(),
          ),
        ),
      if (widget.showAmPm && !widget.is24format)
        Expanded(
          flex: math.max(widget.ampmFlex, 1),
          child: _wrapDropdown(
            child: _buildAmPmDropdown(),
          ),
        ),
    ];

    return Row(
      children: _addSpacingBetweenDropdowns(dropdowns),
    );
  }

  List<Widget> _addSpacingBetweenDropdowns(List<Widget> dropdowns) {
    final spacedDropdowns = <Widget>[];
    final spacing = widget.width < 0 ? 0.0 : widget.width;

    for (var index = 0; index < dropdowns.length; index++) {
      if (index > 0) {
        spacedDropdowns.add(SizedBox(width: spacing));
      }
      spacedDropdowns.add(dropdowns[index]);
    }

    return spacedDropdowns;
  }

  Widget _wrapDropdown({required Widget child}) {
    final dropdown = widget.isDropdownHideUnderline
        ? DropdownButtonHideUnderline(child: child)
        : child;

    return Container(
      decoration: widget.boxDecoration ?? const BoxDecoration(),
      child: dropdown,
    );
  }

  DropdownButtonFormField<String> _buildMinsDropdown() {
    return DropdownButtonFormField<String>(
      key: ValueKey<String>('dropdown_timepicker.mins.$_minSelVal'),
      decoration: _dropdownDecoration,
      initialValue: _minSelVal.isEmpty ? null : _minSelVal,
      isExpanded: widget.isExpanded,
      hint: Text(widget.hintMins, style: widget.hintTextStyle),
      icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
      onChanged: _updateMins,
      validator: (value) {
        if (!widget.isFormValidator || !widget.showMins) {
          return null;
        }
        return value == null ? widget.errorMins : null;
      },
      items: listMins
          .map(
            (item) => DropdownMenuItem<String>(
              value: item.toString(),
              child: Text(item.toString(), style: _defaultTextStyle),
            ),
          )
          .toList(),
    );
  }

  DropdownButtonFormField<String> _buildHoursDropdown() {
    return DropdownButtonFormField<String>(
      key: ValueKey<String>('dropdown_timepicker.hours.$_hourSelVal'),
      decoration: _dropdownDecoration,
      initialValue: _hourSelVal.isEmpty ? null : _hourSelVal,
      hint: Text(widget.hintHours, style: widget.hintTextStyle),
      isExpanded: widget.isExpanded,
      icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
      onChanged: _updateHours,
      validator: (value) {
        if (!widget.isFormValidator || !widget.showHours) {
          return null;
        }
        return value == null ? widget.errorHours : null;
      },
      items: _hourOptions
          .map(
            (item) => DropdownMenuItem<String>(
              value: item.toString(),
              child: Text(item.toString(), style: _defaultTextStyle),
            ),
          )
          .toList(),
    );
  }

  DropdownButtonFormField<String> _buildAmPmDropdown() {
    return DropdownButtonFormField<String>(
      key: ValueKey<String>('dropdown_timepicker.ampm.$_ampmSelVal'),
      decoration: _dropdownDecoration,
      initialValue: _ampmSelVal.isEmpty ? null : _ampmSelVal,
      hint: Text(widget.hintAmPm, style: widget.hintTextStyle),
      isExpanded: widget.isExpanded,
      icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
      onChanged: _updateAmPm,
      validator: (value) {
        if (!widget.isFormValidator || !widget.showAmPm || widget.is24format) {
          return null;
        }
        return value == null ? widget.errorAmPm : null;
      },
      items: listAmPm
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: _defaultTextStyle),
            ),
          )
          .toList(),
    );
  }

  TextStyle get _defaultTextStyle {
    return widget.textStyle ??
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        );
  }

  InputDecoration? get _dropdownDecoration {
    if (widget.inputDecoration != null) {
      return widget.inputDecoration;
    }

    if (!widget.isDropdownHideUnderline) {
      return null;
    }

    return const InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
    );
  }
}
