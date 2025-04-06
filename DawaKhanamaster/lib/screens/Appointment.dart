import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hospital/widgets/text_widget.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'Profile.dart';

class Appointment extends StatefulWidget {
  final int index;
  const Appointment(this.index, {super.key});
  
  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> with SingleTickerProviderStateMixin {
  var images = [
    const AssetImage('assets/images/doctor2.png'),
    const AssetImage('assets/images/doctor3.png'),
    const AssetImage('assets/images/doctor4.png'),
    const AssetImage('assets/images/doctor5.png'),
    const AssetImage('assets/images/doctor6.png'),
    const AssetImage('assets/images/doctor7.png'),
    const AssetImage('assets/images/doctor5.png'),
  ];
  
  late Size size;
  var opacity = 0.0;
  bool position = false;
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  var selectedTime = -1;
  var timeSlots = [
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "12:00 PM",
  ];

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();

    Future.delayed(Duration.zero, () {
      animator();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animator() {
    if (opacity == 1) {
      opacity = 0;
      position = false;
    } else {
      opacity = 1;
      position = true;
    }
    setState(() {});
  }

  void selectTimeSlot(int index) {
    setState(() {
      selectedTime = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: Color(0xFF0A0A0D), // Same deep black as Home
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              // Ambient background elements with subtle glow
              Positioned(
                top: -150,
                right: -100,
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.teal.shade800.withOpacity(0.07),
                  ),
                ),
              ),
              Positioned(
                bottom: -120,
                left: -80,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.indigo.shade900.withOpacity(0.08),
                  ),
                ),
              ),

              // Subtle accent glow for visual depth
              Positioned(
                top: size.height / 2.5,
                right: -100,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.shade700.withOpacity(0.06),
                        blurRadius: 80,
                        spreadRadius: 60,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Main content
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                top: position ? 0 : 50,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: opacity,
                  child: Column(
                    children: [
                      // App bar with back button and title
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                animator();
                                Timer(const Duration(milliseconds: 500), () {
                                  Navigator.pop(context);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Color(0xFF16161E),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.teal.shade700.withOpacity(0.2),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color: Colors.teal.shade300,
                                  size: 20,
                                ),
                              ),
                            ),
                            Text(
                              "Appointment",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(width: 40), // Balance the header
                          ],
                        ),
                      ),
                      
                      // Doctor info card
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF1A1A24),
                              Color(0xFF141420),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.teal.shade600.withOpacity(0.2),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 12,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.teal.shade400.withOpacity(0.5),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.teal.shade700.withOpacity(0.1),
                                    blurRadius: 6,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: images[widget.index],
                                backgroundColor: Colors.teal.shade900,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dr. Sarah Johnson",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Cardiologist",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.amber, size: 16),
                                    Icon(Icons.star, color: Colors.amber, size: 16),
                                    Icon(Icons.star, color: Colors.amber, size: 16),
                                    Icon(Icons.star, color: Colors.amber, size: 16),
                                    Icon(Icons.star, color: Colors.amber, size: 16),
                                    SizedBox(width: 5),
                                    Text(
                                      "5.0",
                                      style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Date picker section
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                top: position ? 200 : 250,
                left: 20,
                right: 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: opacity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Date",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Color(0xFF16161E),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.teal.shade700.withOpacity(0.2),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Theme(
                          data: ThemeData.dark().copyWith(
                            colorScheme: ColorScheme.dark(
                              primary: Colors.teal.shade400,
                              onPrimary: Colors.white,
                              surface: Colors.transparent,
                              onSurface: Colors.white,
                            ),
                          ),
                          child: SfDateRangePicker(
                            selectionMode: DateRangePickerSelectionMode.single,
                            backgroundColor: Colors.transparent,
                            allowViewNavigation: true,
                            enablePastDates: false,
                            headerHeight: 60,
                            selectionColor: Colors.teal.shade600,
                            todayHighlightColor: Colors.teal.shade400,
                            monthCellStyle: DateRangePickerMonthCellStyle(
                              textStyle: TextStyle(color: Colors.white),
                              todayTextStyle: TextStyle(color: Colors.teal.shade300),
                            ),
                            selectionTextStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            headerStyle: const DateRangePickerHeaderStyle(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Time selection section
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                bottom: position ? 100 : 150,
                left: 20,
                right: 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: opacity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Time",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        height: 160,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2.2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => selectTimeSlot(index),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  gradient: selectedTime == index
                                      ? LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.teal.shade700,
                                            Colors.teal.shade900,
                                          ],
                                        )
                                      : LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xFF1E1E28),
                                            Color(0xFF16161E),
                                          ],
                                        ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: selectedTime == index
                                        ? Colors.teal.shade400
                                        : Colors.teal.shade700.withOpacity(0.2),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 8,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    timeSlots[index],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: selectedTime == index
                                          ? Colors.white
                                          : Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Book appointment button
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                bottom: position ? 20 : 60,
                left: 20,
                right: 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: opacity,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        barrierColor: Colors.black.withOpacity(.8),
                        backgroundColor: Colors.transparent,
                        isDismissible: true,
                        context: context,
                        builder: (context) {
                          return Container(
                            height: size.height / 1.7,
                            child: Stack(
                              children: [
                                // Success background
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: size.height / 1.9,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.teal.shade900,
                                          Colors.blueGrey.shade900,
                                          Colors.indigo.shade900,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.teal.shade900.withOpacity(0.3),
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                
                                // Content
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: size.height / 1.93,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF0A0A0D),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40),
                                      ),
                                      border: Border.all(
                                        color: Colors.teal.shade700.withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Colors.teal.shade700.withOpacity(0.3),
                                                Colors.teal.shade900.withOpacity(0.3),
                                              ],
                                            ),
                                            border: Border.all(
                                              color: Colors.teal.shade400.withOpacity(0.5),
                                              width: 2,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.teal.shade700.withOpacity(0.2),
                                                blurRadius: 20,
                                                spreadRadius: 5,
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.teal.shade300,
                                            size: 50,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          "Appointment Confirmed",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Your appointment has been booked successfully",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                        SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.calendar_month,
                                              color: Colors.teal.shade300,
                                              size: 20,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "April 3, 2025",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Icon(
                                              Icons.access_time,
                                              color: Colors.teal.shade300,
                                              size: 20,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              selectedTime >= 0 ? timeSlots[selectedTime] : "10:00 AM",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                
                                // Doctor avatar
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.teal.shade400.withOpacity(0.5),
                                        width: 3,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.teal.shade700.withOpacity(0.2),
                                          blurRadius: 15,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                      image: DecorationImage(
                                        image: images[widget.index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.teal.shade700,
                            Colors.teal.shade900,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.shade900.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Book Appointment",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 24,
                          ),
                        ],
                      ),
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