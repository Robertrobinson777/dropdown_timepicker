library dropdown_timepicker;

import 'package:flutter/material.dart';

import 'list_time.dart';

class DropdownTimePicker extends StatefulWidget {
  ///DropDown select text style
  final TextStyle? textStyle;

  ///DropDown container box decoration
  final BoxDecoration? boxDecoration;

  ///InputDecoration for DropDown
  final InputDecoration? inputDecoration;

  ///DropDown expand icon
  final Icon? icon;

  ///Start hour for date picker
  ///Default is 1900
  final int? startHours;

  ///End hour for date picker
  ///Default is Current hour
  final int? endHours;

  ///width between each drop down
  ///Default is 12.0
  final double width;

  ///Return selected Am/Pm
  ValueChanged<String?>? onChangedAmPm;

  ///Return selected Mins
  ValueChanged<String?>? onChangedMins;

  ///Return selected Hours
  ValueChanged<String?>? onChangedHours;

  ///Error message for Date
  String errorAmPm;

  ///Error message for Mins
  String errorMins;

  ///Error message for Hours
  String errorHours;

  ///Hint for Mins drop down
  ///Default is "Mins"
  String hintMins;

  ///Hint for Hours drop down
  ///Default is "Hours"
  String hintHours;

  ///Hint for AmPm drop down
  ///Default is "AmPm"
  String hintAmPm;

  ///Hint Textstyle for drop down
  TextStyle? hintTextStyle;

  ///Is Form validator enabled
  ///Default is false
  final bool isFormValidator;

  ///Is Expanded for dropdown
  ///Default is true
  final bool isExpanded;

  ///Selected AmPm between am and pm
  final String? selectedAmPm;

  ///Selected Mins between 0 to 60
  final int? selectedMins;

  ///Selected Hours between 0 and 12
  final int? selectedHours;

  ///Default [isDropdownHideUnderline] = false. Wrap with DropdownHideUnderline for the dropdown to hide the underline.
  final bool isDropdownHideUnderline;

  /// default true
  bool showHours;
  bool showMins;
  bool showAmPm;

  /// min expanded flex
  int minFlex;

  /// ampm expanded flex
  int ampmFlex;

  /// hour expanded flex
  int hourFlex;

  /// is 24 format
  bool is24format;

  DropdownTimePicker(
      {super.key,
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
      this.errorAmPm = 'Please select ampm',
      this.errorMins = 'Please select min',
      this.errorHours = 'Please select hour',
      this.hintMins = 'Mins',
      this.hintAmPm = 'AmPm',
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
      this.hourFlex = 2});

  @override
  State<DropdownTimePicker> createState() => _DropdownTimePickerState();
}

class _DropdownTimePickerState extends State<DropdownTimePicker> {
  var ampmSelVal = '';
  var minSelVal = '';
  var hourSelVal = '';
  int ampmsIn = 32;
  List<int> listOfHours = [];

  @override
  void initState() {
    super.initState();
    listOfHours = widget.is24format ? list24Hours : listHours;

    ampmSelVal =
        widget.selectedAmPm != null ? widget.selectedAmPm.toString() : '';
    minSelVal =
        widget.selectedMins != null ? widget.selectedMins.toString() : '';
    hourSelVal =
        widget.selectedHours != null ? widget.selectedHours.toString() : '';
  }

  ///Mins selection dropdown function
  minSelected(value) {
    widget.onChangedMins!(value);
    minSelVal = value;

    update();
  }

  void checkDates(ampms) {
    // Check if the selected date is not null
    if (minSelVal != '') {
      // Check if the selected date is greater than the number of ampms
      if (int.parse(minSelVal) > ampms) {
        // If the selected date is greater than the number of ampms, clear the selected date
        minSelVal = '';
        widget.onChangedAmPm!('');
        update();
      }
    }
  }

  ampmsSelected(value) {
    widget.onChangedAmPm!(value);

    update();
  }

  hoursSelected(value) {
    widget.onChangedHours!(value);
    hourSelVal = value;

    update();
  }

  ///update function
  update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.showMins)
          Expanded(
            flex: widget.minFlex,
            child: Container(
              decoration: widget.boxDecoration ?? const BoxDecoration(),
              child: SizedBox(
                // height: 49,
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: widget.isDropdownHideUnderline
                      ? DropdownButtonHideUnderline(
                          child: hourDropdown(),
                        )
                      : hourDropdown(),
                ),
              ),
            ),
          ),
        if (widget.showMins) w(widget.width),
        if (widget.showAmPm)
          Expanded(
            flex: widget.ampmFlex,
            child: Container(
              decoration: widget.boxDecoration ?? const BoxDecoration(),
              child: SizedBox(
                  // height: 49,
                  child: ButtonTheme(
                alignedDropdown: true,
                child: widget.isDropdownHideUnderline
                    ? DropdownButtonHideUnderline(
                        child: minDropdown(),
                      )
                    : minDropdown(),
              )),
            ),
          ),
        if (widget.showAmPm) w(widget.width),
        if (widget.is24format == false)
          Expanded(
            flex: widget.hourFlex,
            child: Container(
              decoration: widget.boxDecoration ?? const BoxDecoration(),
              child: SizedBox(
                // height: 49,
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: widget.isDropdownHideUnderline
                      ? DropdownButtonHideUnderline(
                          child: ampmDropdown(),
                        )
                      : ampmDropdown(),
                ),
              ),
            ),
          ),
      ],
    );
  }

  ///min dropdown
  DropdownButtonFormField<String> minDropdown() {
    return DropdownButtonFormField<String>(
        decoration: widget.inputDecoration ??
            (widget.isDropdownHideUnderline ? removeUnderline() : null),
        isExpanded: widget.isExpanded,
        hint: Text(widget.hintMins, style: widget.hintTextStyle),
        icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
        value: minSelVal == '' ? null : minSelVal,
        onChanged: (value) {
          minSelected(value);
        },
        validator: (value) {
          return widget.isFormValidator
              ? value == null
                  ? widget.errorMins
                  : null
              : null;
        },
        items: listMins.map((item) {
          return DropdownMenuItem<String>(
            value: item.toString(),
            child: Text(
              item.toString(),
              style: widget.textStyle ??
                  const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
            ),
          );
        }).toList());
  }

  ///Remove underline from dropdown
  InputDecoration removeUnderline() {
    return const InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
  }

  ///hour dropdown
  DropdownButtonFormField<String> hourDropdown() {
    return DropdownButtonFormField<String>(
        decoration: widget.inputDecoration ??
            (widget.isDropdownHideUnderline ? removeUnderline() : null),
        hint: Text(widget.hintHours, style: widget.hintTextStyle),
        isExpanded: widget.isExpanded,
        icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
        value: hourSelVal == '' ? null : hourSelVal,
        onChanged: (value) {
          hoursSelected(value);
        },
        validator: (value) {
          return widget.isFormValidator
              ? value == null
                  ? widget.errorHours
                  : null
              : null;
        },
        items: listOfHours.map((item) {
          return DropdownMenuItem<String>(
            value: item.toString(),
            child: Text(
              item.toString(),
              style: widget.textStyle ??
                  const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
            ),
          );
        }).toList());
  }

  ///ampm dropdown
  DropdownButtonFormField<String> ampmDropdown() {
    return DropdownButtonFormField<String>(
        decoration: widget.inputDecoration ??
            (widget.isDropdownHideUnderline ? removeUnderline() : null),
        hint: Text(widget.hintAmPm, style: widget.hintTextStyle),
        isExpanded: widget.isExpanded,
        icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
        value: ampmSelVal == '' ? null : ampmSelVal,
        onChanged: (value) {
          ampmsSelected(value);
        },
        validator: (value) {
          return widget.isFormValidator
              ? value == null
                  ? widget.errorAmPm
                  : null
              : null;
        },
        items: listAmPm.map((item) {
          return DropdownMenuItem<String>(
            value: item.toString(),
            child: Text(item.toString(),
                style: widget.textStyle ??
                    const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
          );
        }).toList());
  }

  /* This code creates a blank space that is count pixels wide. */
  Widget w(double count) => SizedBox(width: count);
}
