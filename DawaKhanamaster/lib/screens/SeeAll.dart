import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hospital/screens/Home.dart';
import 'package:hospital/widgets/text_widget.dart';
import 'package:hospital/res/lists.dart';

import 'Chat.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({super.key});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> with SingleTickerProviderStateMixin {
  var opacity = 0.0;
  bool position = false;
  bool isDarkMode = true; // Default to dark mode like in Splash.dart

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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: isDarkMode ? const Color(0xFF121212) : Colors.white,
        padding: const EdgeInsets.only(top: 70),
        height: size.height,
        width: size.width,
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

            // Header
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 1 : 50,
              left: 20,
              right: 20,
              child: upperRow(),
            ),

            // Find doctor card
            AnimatedPositioned(
              top: position ? 60 : 120,
              right: 20,
              left: 20,
              duration: const Duration(milliseconds: 300),
              child: findDoctor(),
            ),

            // Section title
            AnimatedPositioned(
              top: position ? 390 : 450,
              right: 20,
              left: 20,
              duration: const Duration(milliseconds: 400),
              child: AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(milliseconds: 400),
                child: Container(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nearby Doctors",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0,
                          color: isDarkMode ? Colors.white : Colors.black,
                          shadows: isDarkMode
                              ? [
                                  BoxShadow(
                                    color: Colors.tealAccent.shade700
                                        .withOpacity(0.3),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  )
                                ]
                              : [],
                        ),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: isDarkMode
                                  ? [
                                      Colors.tealAccent.shade400,
                                      Colors.lightBlue.shade300,
                                    ]
                                  : [
                                      Colors.blue.shade700,
                                      Colors.blue.shade900
                                    ],
                            ).createShader(
                                const Rect.fromLTWH(0.0, 0.0, 80.0, 20.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Doctor list
            AnimatedPositioned(
              top: position ? 430 : 500,
              left: 20,
              right: 20,
              duration: const Duration(milliseconds: 500),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: opacity,
                child: Container(
                  height: 350,
                  child: ListView.builder(
                    itemCount: 7,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () async {
                        animator();
                        await Future.delayed(const Duration(milliseconds: 500));
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Chat(
                                  image: images[index],
                                  name: names[index],
                                  specialist: spacilality[index]),
                            ));
                        animator();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Card(
                          elevation: isDarkMode ? 8 : 5,
                          color: isDarkMode
                              ? const Color(0xFF1E1E24)
                              : Colors.white,
                          shadowColor: isDarkMode
                              ? Colors.tealAccent.shade700.withOpacity(0.2)
                              : Colors.blue.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: isDarkMode
                                ? BorderSide(
                                    color: Colors.tealAccent.shade700
                                        .withOpacity(0.2),
                                    width: 1)
                                : BorderSide.none,
                          ),
                          child: SizedBox(
                            height: 120,
                            width: double.infinity,
                            child: Row(
                              children: [
                                const SizedBox(width: 20),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: isDarkMode
                                            ? Colors.tealAccent.shade700
                                                .withOpacity(0.2)
                                            : Colors.blue.shade100,
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: images[index],
                                    backgroundColor: isDarkMode
                                        ? Colors.tealAccent.shade700
                                        : Colors.blue,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      names[index],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: isDarkMode
                                              ? [
                                                  Colors.tealAccent.shade700
                                                      .withOpacity(0.3),
                                                  Colors.lightBlue.shade800
                                                      .withOpacity(0.3)
                                                ]
                                              : [
                                                  Colors.blue.shade50,
                                                  Colors.blue.shade100
                                                ],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        spacilality[index],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: isDarkMode
                                              ? Colors.white.withOpacity(0.9)
                                              : Colors.blue.shade800,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: List.generate(
                                        5,
                                        (i) => Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: isDarkMode
                                          ? [
                                              Colors.tealAccent.shade700,
                                              Colors.lightBlue.shade800
                                            ]
                                          : [
                                              Colors.blue.shade700,
                                              Colors.blue.shade900
                                            ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isDarkMode
                                            ? Colors.tealAccent.shade700
                                                .withOpacity(0.3)
                                            : Colors.blue.shade300
                                                .withOpacity(0.5),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: const Icon(
                                    Icons.navigation_sharp,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget findDoctor() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.tealAccent.shade700.withOpacity(0.2)
                  : Colors.blue.shade300.withOpacity(0.5),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDarkMode
                    ? [
                        Colors.tealAccent.shade700,
                        Colors.lightBlue.shade800,
                        Colors.blue.shade900,
                      ]
                    : [
                        Colors.blue.shade700,
                        Colors.blue.shade900,
                        Colors.blue.shade900,
                      ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background pattern for dark mode
                if (isDarkMode)
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.05,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/pattern.png'),
                            repeat: ImageRepeat.repeat,
                          ),
                        ),
                      ),
                    ),
                  ),

                Positioned(
                  top: 25,
                  left: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
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
                              image: AssetImage('assets/images/p1.png'),
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
                            "Find Doctors!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                              shadows: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Use this feature to find a doctor\nclosest to you",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.normal,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 115,
                  left: 20,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/map.png'),
                          ),
                        ),
                        // Add overlay gradient in dark mode
                        child: isDarkMode
                            ? Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.2),
                                    ],
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_outlined,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget upperRow() {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              animator();
              Timer(const Duration(milliseconds: 600), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isDarkMode ? Colors.grey.shade900 : Colors.blue.shade50,
                border: isDarkMode
                    ? Border.all(
                        color: Colors.tealAccent.shade700.withOpacity(0.3),
                        width: 1)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode
                        ? Colors.tealAccent.shade700.withOpacity(0.1)
                        : Colors.blue.shade100.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: isDarkMode ? Colors.white : Colors.black,
                size: 20,
              ),
            ),
          ),
          Text(
            "Our Doctors",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
              letterSpacing: 0.5,
              shadows: isDarkMode
                  ? [
                      BoxShadow(
                        color: Colors.tealAccent.shade700.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      )
                    ]
                  : [],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isDarkMode ? Colors.grey.shade900 : Colors.blue.shade50,
              border: isDarkMode
                  ? Border.all(
                      color: Colors.tealAccent.shade700.withOpacity(0.3),
                      width: 1)
                  : null,
              boxShadow: [
                BoxShadow(
                  color: isDarkMode
                      ? Colors.tealAccent.shade700.withOpacity(0.1)
                      : Colors.blue.shade100.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: isDarkMode ? Colors.white : Colors.black,
                  size: 20,
                ),
                const SizedBox(width: 2),
                if (!isDarkMode)
                  GestureDetector(
                    onTap: toggleTheme,
                    child: Icon(
                      Icons.dark_mode,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                if (isDarkMode)
                  GestureDetector(
                    onTap: toggleTheme,
                    child: Icon(
                      Icons.light_mode,
                      color: Colors.tealAccent.shade400,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
