import 'package:flutter/material.dart';
import 'package:hospital/widgets/text_widget.dart';

class AppointmentPage extends StatefulWidget {
  final String doctorName;
  final String specialization;
  final AssetImage doctorImage;

  const AppointmentPage({
    super.key,
    required this.doctorName,
    required this.specialization,
    required this.doctorImage,
  });

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedReason;

  final List<String> reasons = [
    'General Checkup',
    'Follow-up Visit',
    'Emergency',
    'Consultation',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Book Appointment',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Info Card
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xFF16161E),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.teal.shade700.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.teal.shade400.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: widget.doctorImage,
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.doctorName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          widget.specialization,
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // Date Selection
              Text(
                'Select Date',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xFF16161E),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.teal.shade700.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate == null
                          ? 'Choose a date'
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      style: TextStyle(
                        color: selectedDate == null
                            ? Colors.grey.shade500
                            : Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today, color: Colors.teal.shade300),
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 30)),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.dark().copyWith(
                                colorScheme: ColorScheme.dark(
                                  primary: Colors.teal,
                                  onPrimary: Colors.white,
                                  surface: Color(0xFF16161E),
                                  onSurface: Colors.white,
                                ),
                                dialogBackgroundColor: Color(0xFF0A0A0D),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Time Selection
              Text(
                'Select Time',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xFF16161E),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.teal.shade700.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedTime == null
                          ? 'Choose a time'
                          : selectedTime!.format(context),
                      style: TextStyle(
                        color: selectedTime == null
                            ? Colors.grey.shade500
                            : Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.access_time, color: Colors.teal.shade300),
                      onPressed: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.dark().copyWith(
                                colorScheme: ColorScheme.dark(
                                  primary: Colors.teal,
                                  onPrimary: Colors.white,
                                  surface: Color(0xFF16161E),
                                  onSurface: Colors.white,
                                ),
                                dialogBackgroundColor: Color(0xFF0A0A0D),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          setState(() {
                            selectedTime = picked;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Reason Selection
              Text(
                'Reason for Visit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Color(0xFF16161E),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.teal.shade700.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedReason,
                    hint: Text(
                      'Select a reason',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                    dropdownColor: Color(0xFF16161E),
                    style: TextStyle(color: Colors.white),
                    items: reasons.map((String reason) {
                      return DropdownMenuItem<String>(
                        value: reason,
                        child: Text(reason),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedReason = newValue;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 40),

              // Book Appointment Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedDate != null &&
                        selectedTime != null &&
                        selectedReason != null) {
                      // Show confirmation dialog
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Color(0xFF16161E),
                          title: Text(
                            'Appointment Confirmed!',
                            style: TextStyle(color: Colors.white),
                          ),
                          content: Text(
                            'Your appointment with ${widget.doctorName} has been scheduled for ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} at ${selectedTime!.format(context)}.',
                            style: TextStyle(color: Colors.grey.shade300),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.teal.shade300),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill in all fields'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Book Appointment',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}