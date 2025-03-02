import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key});

  @override
  _AppointmentBookingScreenState createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  int _selectedDoctorIndex = -1;
  final DateTime _selectedDate = DateTime.now();
  String _selectedTime = '';
  
  // State for TableCalendar
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> doctors = [
    {
      'name': 'Dr. Emily Clark',
      'specialization': 'Cardiology',
      'image': 'assets/images/doctor1.jpg',
    },
    {
      'name': 'Dr. Marc Thompson',
      'specialization': 'Orthopedic Surgery',
      'image': 'assets/images/doctor2.jpg',
    },
    {
      'name': 'Dr. Sarah Lee',
      'specialization': 'Pediatrics',
      'image': 'assets/images/doctor3.jpg',
    },
    {
      'name': 'Dr. David Patel',
      'specialization': 'Dermatology',
      'image': 'assets/images/doctor4.jpg',
    },
  ];

  List<String> availableTimes = ['9:00 AM', '10:30 AM', '1:00 PM', '3:30 PM'];
  List<Map<String, String>> _filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    _filteredDoctors = doctors; // Initialize with all doctors
  }

  // Method to filter doctors based on search query
  void _filterDoctors(String query) {
    List<Map<String, String>> filteredList = [];
    if (query.isNotEmpty) {
      filteredList = doctors.where((doctor) {
        return doctor['name']!.toLowerCase().contains(query.toLowerCase()) ||
               doctor['specialization']!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      filteredList = doctors; // If query is empty, show all doctors
    }

    setState(() {
      _filteredDoctors = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Booking'),
        actions: const [
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildFilterOptions(),
            const SizedBox(height: 16),
            _buildDoctorList(),
            const SizedBox(height: 16),
            _buildAppointmentCalendar(),
            const SizedBox(height: 16),
            _buildAvailableTimes(),
            const SizedBox(height: 16),
            _buildAppointmentConfirmation(),
            const SizedBox(height: 16),
            _buildPaymentOptions(),
            const SizedBox(height: 16),
            _buildPayNowButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search for doctors',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: _filterDoctors, // Call the filter method on text change
    );
  }

  Widget _buildFilterOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Filter Options', style: TextStyle(fontWeight: FontWeight.bold)),
        IconButton(
          icon: const Icon(Icons.filter_alt),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildDoctorList() {
    return Column(
      children: [
        if (_filteredDoctors.isEmpty) 
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'No doctors found',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
        ..._filteredDoctors.map((doctor) {
          int index = _filteredDoctors.indexOf(doctor);
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(doctor['image']!),
              ),
              title: Text(doctor['name']!),
              subtitle: Text(doctor['specialization']!),
              trailing: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedDoctorIndex = index;
                  });
                },
                child: Text(
                  _selectedDoctorIndex == index ? 'Selected' : 'Book Now',
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  // Modified Appointment Calendar using TableCalendar
  Widget _buildAppointmentCalendar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Appointment Calendar',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TableCalendar(
          focusedDay: _focusedDay,
          firstDay: DateTime.now(),
          lastDay: DateTime(2025, 12, 31),
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // update `_focusedDay` here as well
            });
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.purple),
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.purple),
            titleTextStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          calendarStyle: const CalendarStyle(
            todayTextStyle: TextStyle(color: Colors.white),
            todayDecoration: BoxDecoration(
              color: Colors.purple,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.purpleAccent,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(color: Colors.white),
          ),
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Colors.black),
            weekendStyle: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _buildAvailableTimes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available Times',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10.0,
          children: availableTimes.map((time) {
            return ChoiceChip(
              label: Text(time),
              selected: _selectedTime == time,
              onSelected: (isSelected) {
                setState(() {
                  _selectedTime = time;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAppointmentConfirmation() {
    if (_selectedDoctorIndex == -1 || _selectedTime == '') {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Appointment Confirmation',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          'Doctor: ${_filteredDoctors[_selectedDoctorIndex]['name']}',
        ),
        Text(
          'Date: ${_selectedDate.toLocal()}'.split(' ')[0],
        ),
        Text(
          'Time: $_selectedTime',
        ),
        const Text('Location: Grandview Hospital'),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            // Confirm appointment logic
          },
          child: const Text('Confirm Appointment'),
        ),
      ],
    );
  }

  Widget _buildPaymentOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Options',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Row(
          children: [
            Checkbox(value: true, onChanged: (value) {}),
            const Text('Credit Card'),
          ],
        ),
        Row(
          children: [
            Checkbox(value: false, onChanged: (value) {}),
            const Text('Debit Card'),
          ],
        ),
      ],
    );
  }

  Widget _buildPayNowButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Payment processing logic
        },
        child: const Text('Pay Now'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AppointmentBookingScreen(),
  ));
}
