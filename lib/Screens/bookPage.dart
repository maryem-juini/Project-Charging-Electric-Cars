import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:app_utils/app_utils.dart';
import 'package:project/DataBase/firebase_options.dart';


void main() async {
  initializeDateFormatting()
      .then((_) => runApp(const BookingCalendarDemoApp()));
       WidgetsFlutterBinding.ensureInitialized(); 
          await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
      );
}


@JsonSerializable(explicitToJson: true)
class Book {
  final DateTime? bookingStart;
  final DateTime? bookingend;

  Book({
    this.bookingStart,
    this.bookingend,
  });

  
}


class BookingCalendarDemoApp extends StatefulWidget {
  const BookingCalendarDemoApp({Key? key}) : super(key: key);

  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {
  final now = DateTime.now();
  late BookingService mockBookingService;
 
  
    CollectionReference bookings = FirebaseFirestore.instance.collection('appointments');

   

  @override
  void initState() {
    super.initState();
    // DateTime.now().startOfDay
    // DateTime.now().endOfDay
    mockBookingService = BookingService(
        serviceName: 'Mock Service',
        serviceDuration: 30,
        bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 8, 0));
  }
  

Stream<dynamic> getBookingStreamFirebase({required DateTime end, required DateTime start}) {
  try {
    return FirebaseFirestore.instance
        .collection('appointments')
        .where('start', isGreaterThanOrEqualTo: start)
        .where('end', isLessThanOrEqualTo: end)
        .snapshots();
  } catch (e) {
    print('Error fetching appointments: $e');
    throw e; // Re-throw the exception to propagate it
  }
}

 List<DateTimeRange> convertStreamResultFirebase(
    {required dynamic streamResult}) {
    
      List<DateTimeRange> converted = [] ;
      for (var i = 0; i < streamResult.size; i++) {
        final item = streamResult.docs[i].data();
        converted.add(DateTimeRange(start: (item.bookingStart!), end: (item.bookingEnd!)));
      }
  return converted;
}


  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    print('${newBooking.toJson()} has been uploaded');
  }
  //  Future<List<DocumentSnapshot>> fetchAppointments() async {
  //   final querySnapshot = await FirebaseFirestore.instance
  //       .collection('appointments')
  //       .where('start', isGreaterThanOrEqualTo: DateTime.now())
  //       .where('end', isLessThanOrEqualTo: DateTime.now().add(const Duration(days: 7))) // You can adjust the query as per your requirement
  //       .get();

  //   return querySnapshot.docs;
  // }

  List<DateTimeRange> converted = [];

   List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data
    DateTime first = now;
    DateTime tomorrow = now.add(const Duration(days: 1));
    DateTime second = now.add(const Duration(minutes: 55));
    DateTime third = now.subtract(const Duration(minutes: 240));
    DateTime fourth = now.subtract(const Duration(minutes: 500));
    converted.add(
        DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    converted.add(DateTimeRange(
        start: second, end: second.add(const Duration(minutes: 23))));
    converted.add(DateTimeRange(
        start: third, end: third.add(const Duration(minutes: 15))));
    converted.add(DateTimeRange(
        start: fourth, end: fourth.add(const Duration(minutes: 50))));

    converted.add(DateTimeRange(
        start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
        end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
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
          body: Center(
            child: BookingCalendar(
              bookingService: mockBookingService,
              convertStreamResultToDateTimeRanges: convertStreamResultMock,
              getBookingStream: getBookingStreamFirebase , 
              uploadBooking: uploadBookingMock,
              pauseSlots: generatePauseSlots(),
              pauseSlotText: 'LUNCH',
              hideBreakTime: false,
              loadingWidget: const Text('Fetching data...'),
              uploadingWidget: const CircularProgressIndicator(),
              locale: 'hu_HU',
              startingDayOfWeek: StartingDayOfWeek.tuesday,
              wholeDayIsBookedWidget:
                  const Text('Sorry, for this day everything is booked'),
              //disabledDates: [DateTime(2023, 1, 20)],
              //disabledDays: [6, 7],
            ),
          ),
        ));
  }
}