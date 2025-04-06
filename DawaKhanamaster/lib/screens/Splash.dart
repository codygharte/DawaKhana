import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hospital/screens/Home.dart';
import 'package:hospital/widgets/text_widget.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  bool position = false;
  var opacity = 0.0;
  bool isDarkMode = true; // Default to dark mode

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
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

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  animator() async {
    if (opacity == 0) {
      opacity = 1;
      position = true;
    } else {
      opacity = 0;
      position = false;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [Color(0xFF121212), Color(0xFF1E1E24)]
                : [Colors.white, Colors.blue.shade50],
          ),
        ),
        child: Stack(
          children: [
            // Background design elements with improved dark mode aesthetics
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              top: -50,
              right: -50,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: 0.08,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDarkMode
                        ? Colors.tealAccent.shade700.withOpacity(0.6)
                        : Colors.blue.shade700,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              bottom: -120,
              left: -80,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: 0.05,
                child: Container(
                  height: 350,
                  width: 350,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDarkMode
                        ? Colors.blue.shade400.withOpacity(0.6)
                        : Colors.blue.shade900,
                  ),
                ),
              ),
            ),

            // Subtle glow in bottom right for dark mode ambiance
            if (isDarkMode)
              Positioned(
                bottom: 40,
                right: 40,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.tealAccent.shade700.withOpacity(0.15),
                        blurRadius: 80,
                        spreadRadius: 20,
                      ),
                    ],
                  ),
                ),
              ),

            // Logo with enhanced dark mode styling
            AnimatedPositioned(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              top: 20,
              right: 20,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode
                            ? Colors.tealAccent.withOpacity(0.1)
                            : Colors.blue.shade100,
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/khana_logo.png',
                    width: 180,
                    height: 90,
                    color: isDarkMode ? Colors.white.withOpacity(0.95) : null,
                    colorBlendMode:
                        isDarkMode ? BlendMode.srcIn : BlendMode.dstIn,
                  ),
                ),
              ),
            ),

            // Theme toggle button with improved dark mode styling
            Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                onTap: toggleTheme,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey.shade900 : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: isDarkMode
                        ? Border.all(
                            color: Colors.tealAccent.shade700.withOpacity(0.3),
                            width: 1)
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode
                            ? Colors.tealAccent.shade700.withOpacity(0.1)
                            : Colors.blue.shade100.withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isDarkMode ? Icons.dark_mode : Icons.light_mode,
                        color: isDarkMode
                            ? Colors.tealAccent.shade400
                            : Colors.amber.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isDarkMode ? "Dark" : "Light",
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Main content with enhanced text styling for dark mode
            AnimatedPositioned(
              duration: const Duration(milliseconds: 800),
              top: position ? 150 : 200,
              left: 30,
              right: 30,
              child: AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(milliseconds: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Complete",
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3,
                                foreground: Paint()
                                  ..shader = LinearGradient(
                                    colors: isDarkMode
                                        ? [
                                            Colors.tealAccent.shade400,
                                            Colors.lightBlue.shade300,
                                          ]
                                        : [
                                            Colors.blue.shade700,
                                            Colors.teal.shade800
                                          ],
                                  ).createShader(const Rect.fromLTWH(
                                      0.0, 0.0, 200.0, 70.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Health",
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3,
                                foreground: Paint()
                                  ..shader = LinearGradient(
                                    colors: isDarkMode
                                        ? [
                                            Colors.tealAccent.shade400,
                                            Colors.lightBlue.shade300,
                                          ]
                                        : [
                                            Colors.blue.shade700,
                                            Colors.teal.shade800
                                          ],
                                  ).createShader(const Rect.fromLTWH(
                                      0.0, 0.0, 200.0, 70.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Solution",
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3,
                                foreground: Paint()
                                  ..shader = LinearGradient(
                                    colors: isDarkMode
                                        ? [
                                            Colors.tealAccent.shade400,
                                            Colors.lightBlue.shade300,
                                          ]
                                        : [
                                            Colors.blue.shade700,
                                            Colors.teal.shade800
                                          ],
                                  ).createShader(const Rect.fromLTWH(
                                      0.0, 0.0, 200.0, 70.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.grey.shade900.withOpacity(0.7)
                              : Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(15),
                          border: isDarkMode
                              ? Border.all(
                                  color: Colors.tealAccent.shade700
                                      .withOpacity(0.2),
                                  width: 1)
                              : null,
                          boxShadow: [
                            BoxShadow(
                              color: isDarkMode
                                  ? Colors.black.withOpacity(0.3)
                                  : Colors.blue.shade100.withOpacity(0.2),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Text(
                          "Early Protection for Family Health",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.9)
                                : Colors.black.withOpacity(.7),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Doctor image with enhanced dark mode styling
            AnimatedPositioned(
              bottom: 0,
              right: 0,
              duration: const Duration(milliseconds: 800),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                opacity: opacity,
                child: Container(
                  height: 450,
                  width: 400,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode
                            ? Colors.tealAccent.shade700.withOpacity(0.08)
                            : Colors.blue.shade900.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(-5, 0),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/doctor6.png',
                        fit: BoxFit.fill,
                        height: 450,
                        width: 400,
                        color:
                            isDarkMode ? Colors.white.withOpacity(0.85) : null,
                        colorBlendMode:
                            isDarkMode ? BlendMode.modulate : BlendMode.dst,
                      ),
                      if (isDarkMode)
                        Container(
                          height: 450,
                          width: 400,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.tealAccent.shade700.withOpacity(0.05),
                                Colors.black.withOpacity(0.3),
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Get Started button with improved dark mode styling
            AnimatedPositioned(
              bottom: 80,
              left: position ? 30 : -100,
              duration: const Duration(milliseconds: 800),
              child: InkWell(
                onTap: () {
                  position = false;
                  opacity = 0;
                  setState(() {});
                  Timer(const Duration(milliseconds: 800), () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                  });
                },
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(milliseconds: 800),
                  child: Container(
                    width: 180,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDarkMode
                            ? [
                                Colors.tealAccent.shade700,
                                Colors.lightBlue.shade700
                              ]
                            : [Colors.blue.shade800, Colors.blue.shade900],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: isDarkMode
                              ? Colors.tealAccent.shade700.withOpacity(0.3)
                              : Colors.blue.shade300.withOpacity(0.5),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Get Started",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Decorative line with enhanced dark mode styling
            AnimatedPositioned(
              duration: const Duration(milliseconds: 800),
              bottom: 220,
              left: 30,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                opacity: opacity * 0.7,
                child: Container(
                  height: 4,
                  width: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDarkMode
                          ? [
                              Colors.tealAccent.shade400,
                              Colors.lightBlue.shade300,
                            ]
                          : [Colors.blue.shade900, Colors.teal.shade400],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            // Additional decorative element for dark mode
            if (isDarkMode)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 800),
                top: 220,
                right: 40,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: opacity * 0.4,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: Colors.tealAccent.shade400,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.tealAccent.shade400.withOpacity(0.6),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
