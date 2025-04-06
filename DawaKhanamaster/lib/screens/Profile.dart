import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hospital/res/lists.dart';
import 'package:hospital/screens/Appointment.dart';
import 'package:hospital/widgets/text_widget.dart';
import 'Appointment.dart';
import 'package:flutter/services.dart';

class Profile extends StatefulWidget {
  final AssetImage image;
  final String name;
  final String speciality;
  const Profile(
      {super.key,
      required this.image,
      required this.name,
      required this.speciality});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  var animate = false;
  var opacity = 0.0;
  late Size size;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

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
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animator() {
    if (opacity == 0.0) {
      opacity = 1;
      animate = true;
    } else {
      opacity = 0.0;
      animate = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: Color(0xFF0A0A0D), // Matching dark theme from Home.dart
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              // Ambient background elements with subtle glow (matching Home.dart style)
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
                top: MediaQuery.of(context).size.height / 3,
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

              // Doctor Image with stylized container
              AnimatedPositioned(
                top: animate ? 20 : -100,
                left: 0,
                right: 0,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutQuad,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: opacity,
                  child: Container(
                    height: size.height * 0.35,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(30)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF1A1A24),
                          Color(0xFF141420),
                        ],
                      ),
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
                    child: Stack(
                      children: [
                        // Decorative elements
                        Positioned(
                          top: -20,
                          right: -20,
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -30,
                          left: -30,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.05),
                            ),
                          ),
                        ),

                        // Profile image
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.teal.shade400.withOpacity(0.5),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.teal.shade700.withOpacity(0.15),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: widget.image,
                              backgroundColor: Colors.teal.shade900,
                            ),
                          ),
                        ),

                        // Back button with teal glow
                        Positioned(
                          top: 15,
                          left: 15,
                          child: GestureDetector(
                            onTap: () {
                              animator();
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xFF16161E),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.teal.shade700.withOpacity(0.2),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.teal.shade800.withOpacity(0.1),
                                    blurRadius: 8,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.teal.shade300,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Doctor name and specialty
              AnimatedPositioned(
                top: animate ? size.height * 0.38 : size.height * 0.5,
                left: 0,
                right: 0,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutQuad,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: opacity,
                  child: Column(
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        widget.speciality,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Stats section with redesigned cards
              AnimatedPositioned(
                top: animate ? size.height * 0.47 : size.height * 0.6,
                left: 20,
                right: 20,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutQuad,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: opacity,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Rating card
                        Container(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.teal.shade700.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        Colors.teal.shade500.withOpacity(0.3),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.teal.shade700.withOpacity(0.1),
                                      blurRadius: 8,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 28,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Rating",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "4.9/5",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Divider
                        Container(
                          height: 80,
                          width: 1,
                          color: Colors.teal.shade600.withOpacity(0.2),
                        ),

                        // Patients card
                        Container(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.teal.shade700.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        Colors.teal.shade500.withOpacity(0.3),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.teal.shade700.withOpacity(0.1),
                                      blurRadius: 8,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.people_rounded,
                                  color: Colors.teal.shade300,
                                  size: 28,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Patients",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "130+",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Divider
                        Container(
                          height: 80,
                          width: 1,
                          color: Colors.teal.shade600.withOpacity(0.2),
                        ),

                        // Experience card
                        Container(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.teal.shade700.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        Colors.teal.shade500.withOpacity(0.3),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.teal.shade700.withOpacity(0.1),
                                      blurRadius: 8,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.workspace_premium_rounded,
                                  color: Colors.amber.shade400,
                                  size: 28,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Experience",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "8 Years",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Biography section with futuristic card
              AnimatedPositioned(
                top: animate ? size.height * 0.65 : size.height * 0.8,
                left: 20,
                right: 20,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutQuad,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: opacity,
                  child: Container(
                    padding: EdgeInsets.all(20),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Biography",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.teal.shade700.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.teal.shade500.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                "Read more",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal.shade300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Famous doctor, hygienist, folklore researcher and sanitary mentor, whose contribution to the development of modern medical practices has been significant in multiple fields...",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade300,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Schedule section
              AnimatedPositioned(
                bottom: animate ? 90 : -50,
                left: 20,
                right: 20,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutQuad,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: opacity,
                  child: Container(
                    padding: EdgeInsets.all(20),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Schedule",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDateCard("19", "Mon", true),
                            _buildDateCard("20", "Tue", false),
                            _buildDateCard("21", "Wed", false),
                            _buildDateCard("22", "Thu", false),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Appointment button
              AnimatedPositioned(
                bottom: animate ? 20 : -50,
                left: 20,
                right: 20,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutQuad,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: opacity,
                  child: InkWell(
                    onTap: () async {
                      animator();
                      await Future.delayed(const Duration(milliseconds: 500));
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Appointment(0)));
                      animator();
                    },
                    child: Container(
                      height: 55,
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
                            blurRadius: 12,
                            spreadRadius: 0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Make an appointment",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 22,
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

  Widget _buildDateCard(String date, String day, bool isSelected) {
    return Container(
      width: 65,
      height: 70,
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.teal.shade700.withOpacity(0.3)
            : Color(0xFF16161E),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected
              ? Colors.teal.shade400.withOpacity(0.5)
              : Colors.teal.shade700.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? Colors.teal.shade800.withOpacity(0.2)
                : Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.teal.shade300 : Colors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(
            day,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.teal.shade200 : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
