import 'package:dropdown_timepicker/dropdown_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestApp(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  testWidgets('renders hours, minutes, and AM/PM in 12-hour mode',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      buildTestApp(
        const DropdownTimePicker(),
      ),
    );

    expect(find.byType(DropdownButtonFormField<String>), findsNWidgets(3));
    expect(find.text('Hours'), findsOneWidget);
    expect(find.text('Mins'), findsOneWidget);
    expect(find.text('AM/PM'), findsOneWidget);
  });

  testWidgets('hides the AM/PM field in 24-hour mode',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      buildTestApp(
        const DropdownTimePicker(
          is24format: true,
          selectedHours: 20,
          selectedMins: 30,
        ),
      ),
    );

    expect(find.byType(DropdownButtonFormField<String>), findsNWidgets(2));
    expect(find.text('20'), findsOneWidget);
    expect(find.text('30'), findsOneWidget);
    expect(find.text('AM/PM'), findsNothing);
  });

  testWidgets('allows selection without requiring callbacks',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      buildTestApp(
        const DropdownTimePicker(),
      ),
    );

    await tester.tap(find.byType(DropdownButtonFormField<String>).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('5').last);
    await tester.pumpAndSettle();

    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('validates only visible fields when enabled',
      (WidgetTester tester) async {
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(
      buildTestApp(
        Form(
          key: formKey,
          child: const DropdownTimePicker(
            isFormValidator: true,
            showAmPm: false,
          ),
        ),
      ),
    );

    expect(formKey.currentState!.validate(), isFalse);
    await tester.pump();

    expect(find.text('Please select hours'), findsOneWidget);
    expect(find.text('Please select minutes'), findsOneWidget);
    expect(find.text('Please select AM/PM'), findsNothing);
  });

  testWidgets('uses only valid initial selections',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      buildTestApp(
        const DropdownTimePicker(
          selectedHours: 99,
          selectedMins: 61,
          selectedAmPm: 'XX',
        ),
      ),
    );

    expect(find.text('99'), findsNothing);
    expect(find.text('61'), findsNothing);
    expect(find.text('XX'), findsNothing);
    expect(find.text('Hours'), findsOneWidget);
    expect(find.text('Mins'), findsOneWidget);
    expect(find.text('AM/PM'), findsOneWidget);
  });

  testWidgets('respects the configured hour range',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      buildTestApp(
        const DropdownTimePicker(
          startHours: 9,
          endHours: 11,
        ),
      ),
    );

    await tester.tap(find.byType(DropdownButtonFormField<String>).first);
    await tester.pumpAndSettle();

    expect(find.text('9').last, findsOneWidget);
    expect(find.text('10').last, findsOneWidget);
    expect(find.text('11').last, findsOneWidget);
    expect(find.text('8'), findsNothing);
  });
}
