import 'package:dropdown_timepicker/dropdown_timepicker.dart';
import 'package:dropdown_timepicker_package_example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('example app renders the time picker',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Dropdown Time Picker Demo'), findsOneWidget);
    expect(find.byType(DropdownTimePicker), findsOneWidget);
  });
}
