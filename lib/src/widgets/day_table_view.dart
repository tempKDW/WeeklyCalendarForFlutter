import 'package:flutter/material.dart';

import '../shared/calendar_style.dart';
import '../widgets/day_cell.dart';

class DayTableView extends StatelessWidget {
  const DayTableView({
    super.key,
    required this.weekdays,
    required this.onSelect,
    required this.selectedDate,
    required this.currentDate,
    required this.style,
    required this.events,
  });

  final List<DateTime> weekdays;
  final Function(DateTime)? onSelect;
  final DateTime selectedDate;
  final DateTime currentDate;
  final CalendarStyle style;
  final Map<DateTime, List> events;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            ...weekdays.map(
              (date) {
                return GestureDetector(
                  onTap: () => onSelect?.call(DateTime(date.year, date.month, date.day)),
                  child: DayCell(
                    display: date,
                    selected: selectedDate,
                    current: currentDate,
                    style: style,
                  ),
                );
              },
            ).toList(),
          ],
        ),
        TableRow(
          children: [
            ...weekdays.map(
              (date) {
                int eventCount = events[DateTime(date.year, date.month, date.day)]?.length ?? 0;
                return GestureDetector(
                  child: Text(
                    eventCount.toString(), 
                    style: TextStyle(color: getColorBasedOnValue(eventCount), fontSize: 12), textAlign: TextAlign.center,
                  )
                );
              },
            ).toList(),
          ]
        )
      ],
    );
  }

  Color getColorBasedOnValue(int value) {
    const int maxValue = 10;
    double t = (value.clamp(0, maxValue) / maxValue).toDouble();
    return Color.lerp(Colors.white, Colors.red, t)!;
  }
}
