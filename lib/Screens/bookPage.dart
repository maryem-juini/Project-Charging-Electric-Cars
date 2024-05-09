import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:async';
import 'package:intl/intl.dart';

void main() {
  Intl.defaultLocale = 'en_US';
  initializeDateFormatting('en_US')
      .then((_) => runApp(BookingCalendarDemoApp()));
}

class BookingCalendarDemoApp extends StatefulWidget {
  const BookingCalendarDemoApp({Key? key}) : super(key: key);

  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {
  final now = DateTime.now();
  late BookingService mockBookingService;

  @override
  void initState() {
    super.initState();
    // DateTime.now().startOfDay
    // DateTime.now().endOfDay
    mockBookingService = BookingService(
        serviceName: 'Booking Service',
        serviceDuration: 30,
        bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 8, 0));
  }

  Stream<List<DateTimeRange>> getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return FirebaseFirestore.instance
        .collection('appointments')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return DateTimeRange(
          start: (data['start'] as Timestamp).toDate(),
          end: (data['end'] as Timestamp).toDate(),
        );
      }).toList();
    });
  }

  Future<void> uploadBookingMock({required BookingService newBooking}) async {
    await FirebaseFirestore.instance.collection('appointments').add({
      'start': newBooking.bookingStart,
      'end': newBooking.bookingEnd,
    });
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    print('${newBooking.toJson()} has been uploaded');
  }

  List<DateTimeRange> converted = [];
  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    // Check if streamResult is not null and is of type JSArray<DateTimeRange>
    if (streamResult != null && streamResult is List<DateTimeRange>) {
      converted.addAll(streamResult);
    }

    return converted;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Booking Calendar Demo'),
        ),
        body: BookingCalendar(
          bookingService: mockBookingService,
          convertStreamResultToDateTimeRanges: convertStreamResultMock,
          getBookingStream: getBookingStreamMock,
          uploadBooking: uploadBookingMock,
          hideBreakTime: true,
          loadingWidget: const Text('Fetching data...'),
          uploadingWidget: const CircularProgressIndicator(),
          startingDayOfWeek: StartingDayOfWeek.tuesday,
          wholeDayIsBookedWidget:
              const Text('Sorry, for this day everything is booked'),
          //disabledDates: [DateTime(2023, 1, 20)],
          //disabledDays: [6, 7],
        ),
      ),
    );
  }
}
