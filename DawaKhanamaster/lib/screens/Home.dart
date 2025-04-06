import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hospital/screens/SeeAll.dart';
import 'package:hospital/res/lists.dart';
import 'package:hospital/widgets/text_widget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  final bool initialDarkMode;

  const Home({super.key, this.initialDarkMode = true}); // Default to dark mode

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  var opacity = 0.0;
  bool position = false;
  bool isDarkMode = true; // Default to dark mode

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.initialDarkMode;

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

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: Color(0xFF0A0A0D), // Deeper black for more contrast
          padding: const EdgeInsets.only(top: 20, left: 0, right: 0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                top: MediaQuery.of(context).size.height / 2.5,
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

              // Logo with subtle glow effect
              Positioned(
                top: 3,
                right: 30,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.shade700.withOpacity(0.12),
                        blurRadius: 14,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/khana_logo.png',
                    height: 80,
                    width: 200,
                    color: Colors.white.withOpacity(0.92),
                    colorBlendMode: BlendMode.srcIn,
                  ),
                ),
              ),

              // Theme toggle button with neon outline effect
              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: toggleTheme,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFF16161E),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.teal.shade400.withOpacity(0.4),
                          width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.shade700.withOpacity(0.15),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.dark_mode,
                          color: Colors.teal.shade300,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Dark",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Welcome user section with futuristic styling
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                top: position ? 80 : 140,
                right: 20,
                left: 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: opacity,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
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
                          width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "VEDANT GHARATE",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade700.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.teal.shade400.withOpacity(0.3),
                                width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.teal.shade700.withOpacity(0.1),
                                blurRadius: 8,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.phonelink_ring,
                            color: Colors.teal.shade300,
                            size: 24,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              // Search bar with glowing border
              AnimatedPositioned(
                top: position ? 160 : 200,
                left: 20,
                right: 20,
                duration: const Duration(milliseconds: 500),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: opacity,
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xFF16161E),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Colors.teal.shade700.withOpacity(0.2),
                          width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.shade700.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search_sharp,
                          size: 25,
                          color: Colors.teal.shade200.withOpacity(0.7),
                        ),
                        hintText: "   Search",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Feature card with modern gradient
              AnimatedPositioned(
                top: position ? 230 : 280,
                right: 20,
                left: 20,
                duration: const Duration(milliseconds: 500),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: opacity,
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.teal.shade900,
                            Colors.blueGrey.shade900,
                            Colors.indigo.shade900
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.shade900.withOpacity(0.2),
                            blurRadius: 12,
                            spreadRadius: 0,
                            offset: Offset(0, 2),
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

                          // Glow accent
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.teal.withOpacity(0.05),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.teal.withOpacity(0.2),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Card content
                          Positioned(
                            top: 25,
                            left: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.teal.shade400
                                            .withOpacity(0.3),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 30,
                                    child: Center(
                                      child: Image(
                                        fit: BoxFit.fill,
                                        image:
                                            AssetImage('assets/images/p1.png'),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      "You're invited to the live",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white.withOpacity(0.9),
                                        fontWeight: FontWeight.normal,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Stream with ",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        Text(
                                          "Dr. Arundhati Roy",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.teal.shade200,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                          // Divider
                          Positioned(
                            top: 100,
                            left: 20,
                            child: Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width - 80,
                              color: Colors.white.withOpacity(.3),
                            ),
                          ),

                          // People joined
                          Positioned(
                            top: 110,
                            left: 20,
                            right: 20,
                            child: Row(
                              children: [
                                Text(
                                  "120K people join live Stream!",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.teal.shade100,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.blue,
                                          child: Center(
                                            child: Text(
                                              "A",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 20,
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.red,
                                          child: Center(
                                            child: Text(
                                              "B",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 40,
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.white,
                                          child: Center(
                                            child: Text(
                                              "C",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                          // Close button
                          Positioned(
                            top: 15,
                            right: 15,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close_outlined,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Categories section
              categoryRow(),

              // Our Doctors section header
              AnimatedPositioned(
                top: position ? 430 : 500,
                left: 20,
                right: 20,
                duration: const Duration(milliseconds: 500),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: opacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Our Doctors",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          animator();
                          setState(() {});
                          await Future.delayed(
                              const Duration(milliseconds: 500));
                          await Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SeeAll();
                            },
                          ));

                          setState(() {
                            animator();
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade700.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.teal.shade500.withOpacity(0.3),
                                width: 1),
                          ),
                          child: Text(
                            "See all",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade300,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Doctor list
              doctorList(),

              // Bottom navigation bar
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: opacity,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      iconTheme: IconThemeData(
                        color: Colors.white,
                      ),
                    ),
                    child: CurvedNavigationBar(
                      color: Color(0xFF16161E),
                      backgroundColor: Color(0xFF0A0A0D),
                      buttonBackgroundColor: Colors.teal.shade700,
                      height: 60,
                      items: [
                        Icon(
                          Icons.home_filled,
                          color: Colors.white,
                          size: 30,
                        ),
                        Icon(
                          Icons.calendar_month_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        Icon(
                          Icons.whatshot_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        Icon(
                          Icons.account_circle_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
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

  Widget doctorList() {
    return AnimatedPositioned(
      top: position ? 480 : 550,
      left: 20,
      right: 20,
      duration: const Duration(milliseconds: 500),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: opacity,
        child: SizedBox(
          height: 270,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                doctorCard(names[0], spacilality[0], images[0]),
                doctorCard(names[1], spacilality[1], images[1]),
                doctorCard(names[2], spacilality[2], images[2]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget doctorCard(String name, String specialist, AssetImage image) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Card(
        elevation: 6,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Color(0xFF16161E),
        child: Container(
          height: 120,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: Colors.teal.shade700.withOpacity(0.2), width: 1),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1E1E28),
                Color(0xFF16161E),
              ],
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
                  backgroundImage: image,
                  backgroundColor: Colors.teal.shade900,
                ),
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    specialist,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
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
              const Spacer(),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.teal.shade700.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.teal.shade500.withOpacity(0.3), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.shade800.withOpacity(0.1),
                      blurRadius: 6,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.navigation_sharp,
                  color: Colors.teal.shade300,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryRow() {
    return AnimatedPositioned(
      top: position ? 390 : 450,
      left: 20,
      right: 20,
      duration: const Duration(milliseconds: 500),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: opacity,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              category("assets/images/capsule.png", "Drug", 8),
              category("assets/images/virus.png", "Virus", 12),
              category("assets/images/heart.png", "Physo", 12),
              category("assets/images/app.png", "Other", 14),
            ],
          ),
        ),
      ),
    );
  }

  Widget category(String asset, String txt, double padding) {
    return Column(
      children: [
        InkWell(
          child: Container(
            padding: EdgeInsets.all(padding),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Color(0xFF16161E),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: Colors.teal.shade700.withOpacity(0.2), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Image.asset(
              asset,
              color: Colors.teal.shade300,
            ),
          ),
          onTap: () {
            // Category selection logic
          },
        ),
        SizedBox(height: 8),
        Text(
          txt,
          style: TextStyle(
            color: Colors.grey.shade300,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
