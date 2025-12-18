import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Helper to check if two dates are the same day
  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final selectedDate = ValueNotifier<DateTime?>(null);

    // Generate days for current month (simplified)
    final daysInMonth = DateTime(today.year, today.month + 1, 0).day;
    final firstDayOfMonth = DateTime(today.year, today.month, 1);
    final startWeekday = firstDayOfMonth.weekday; // 1 (Mon) to 7 (Sun)
    final totalGridCount = daysInMonth + (startWeekday - 1);

    // Dummy events for demonstration
    final Map<int, String> dummyEvents = {
      3: "Team meeting at 10 AM",
      7: "Project deadline",
      12: "Dinner with friends",
      18: "Gym session",
      25: "Birthday Party",
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Glassmorphism Calendar Demo',
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background image for glass effect
            Image.network(
              'https://picsum.photos/800/1400',
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Calendar 2026',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(color: Colors.black45, blurRadius: 5),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Days of the week header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:
                      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                          .map(
                            (day) => Text(
                          day,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                          .toList(),
                    ),
                    const SizedBox(height: 12),

                    // Calendar grid
                    Expanded(
                      child: ValueListenableBuilder<DateTime?>(
                        valueListenable: selectedDate,
                        builder: (context, selected, _) {
                          return GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: totalGridCount,
                            itemBuilder: (context, index) {
                              if (index < startWeekday - 1) {
                                return const SizedBox.shrink();
                              }

                              final day = index - (startWeekday - 2);
                              final date = DateTime(
                                today.year,
                                today.month,
                                day,
                              );

                              final isToday = _isSameDay(date, today);
                              final isSelected =
                                  selected != null &&
                                      _isSameDay(date, selected);
                              final isWeekend =
                                  date.weekday == 6 || date.weekday == 7;

                              return InkWell(
                                onTap: () => selectedDate.value = date,
                                borderRadius: BorderRadius.circular(15),
                                child: GlassContainer(
                                  blur: isToday ? 25 : 15,
                                  opacity: isSelected
                                      ? 0.4
                                      : (isToday ? 0.35 : 0.15),
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isWeekend
                                          ? Colors.white.withValues(alpha: 0.1)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$day',
                                      style: TextStyle(
                                        fontWeight: isToday || isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        fontSize: 18,
                                        color: isSelected
                                            ? Colors.orangeAccent
                                            : isToday
                                            ? Colors.blueAccent.shade100
                                            : Colors.white,
                                        shadows: isToday || isSelected
                                            ? const [
                                          Shadow(
                                            color: Colors.black45,
                                            blurRadius: 5,
                                            offset: Offset(1, 1),
                                          ),
                                        ]
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Display dummy event for selected date
                    ValueListenableBuilder<DateTime?>(
                      valueListenable: selectedDate,
                      builder: (context, selected, _) {
                        if (selected == null) {
                          return const SizedBox.shrink();
                        }

                        final day = selected.day;
                        final eventText = dummyEvents.containsKey(day)
                            ? dummyEvents[day]!
                            : "No events";

                        return GlassContainer(
                          blur: 20,
                          opacity: 0.3,
                          borderRadius: BorderRadius.circular(20),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              const Icon(Icons.event, color: Colors.white),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  eventText,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // Glassmorphic button
                    GlassContainer(
                      blur: 20,
                      opacity: 0.3,
                      borderRadius: BorderRadius.circular(30),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(30),
                        child: const Text(
                          'Add Event',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black38,
                                blurRadius: 3,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
