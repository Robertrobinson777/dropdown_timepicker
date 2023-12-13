// ignore_for_file: avoid_print

import 'package:dropdown_timepicker/dropdown_timepicker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Dropdown TimePicker Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Dropdwon Time picker Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  String _selectedAmPm = 'AM';
  int _selectedMins = 10;
  int _selectedHours = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: _autovalidate,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  print('onChangedDay: $value');
                },
                onChangedMins: (value) {
                  _selectedMins = int.parse(value!);
                  print('onChangedMonth: $value');
                },
                onChangedHours: (value) {
                  _selectedHours = int.parse(value!);
                  print('onChangedYear: $value');
                },
                //boxDecoration: BoxDecoration(
                // border: Border.all(color: Colors.grey, width: 1.0)), // optional
                // showDay: false,// optional
                // dayFlex: 2,// optional
                // locale: "zh_CN",// optional
                // hintDay: 'Day', // optional
                // hintMonth: 'Month', // optional
                // hintYear: 'Year', // optional
                // hintTextStyle: TextStyle(color: Colors.grey), // optional
              ),
              MaterialButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    TimeOfDay? date =
                        _dateTime(_selectedAmPm, _selectedMins, _selectedHours);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                        content: Text('selected date is $date'),
                        elevation: 20,
                      ),
                    );
                  } else {
                    print('on error');
                    setState(() {
                      _autovalidate = AutovalidateMode.always;
                    });
                  }
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }

  //String to datetime conversion
  TimeOfDay? _dateTime(String? ampm, int? mins, int? hours) {
    if (mins != null && hours != null) {
      //convert ampm to 24 hours
      if (ampm != null && ampm == 'PM') {
        hours = hours + 12;
      }
      return TimeOfDay(hour: hours, minute: mins);
    }
    return null;
  }
}
