import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:project/Screens/HomePage.dart';



class BookingCalendarDemoApp extends StatefulWidget {
  final String stationId;

  const BookingCalendarDemoApp({Key? key, required this.stationId}) : super(key: key);

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
        .where('station_ID', isEqualTo: widget.stationId) // Filter by stationId
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
       debugShowCheckedModeBanner: false,
      title: 'Booking Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
       appBar: AppBar(
          title: Text(
            'Book an Appointment ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF06094C),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage()
          ),
        );
            },
          ),
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
