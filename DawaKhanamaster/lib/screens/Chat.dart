import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hospital/screens/SeeAll.dart';
import 'package:hospital/widgets/text_widget.dart';
import 'Profile.dart';

class Chat extends StatefulWidget {
  final AssetImage image;
  final String name;
  final String specialist;

  const Chat(
      {super.key,
      required this.image,
      required this.name,
      required this.specialist});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> with SingleTickerProviderStateMixin {
  late Size size;
  var animate = false;
  var opacity = 0.0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animator() {
    if (opacity == 0.0) {
      opacity = 1.0;
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
          color: Color(0xFF0A0A0D), // Deeper black background
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

              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: animate ? 0 : 50,
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Column(
                    children: [
                      // Header section
                      buildHeader(),

                      // Messages section
                      Expanded(
                        child: buildMessagesSection(),
                      ),

                      // Message input field
                      buildMessageInput(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFF16161E),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
        border: Border(
            bottom: BorderSide(
                color: Colors.teal.shade700.withOpacity(0.2), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              animator();
              Timer(const Duration(milliseconds: 500), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeeAll(),
                  ),
                );
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF1A1A24),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.teal.shade700.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.teal.shade300,
                size: 18,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              animator();
              await Future.delayed(const Duration(milliseconds: 400));
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(
                    image: widget.image,
                    name: widget.name,
                    speciality: widget.specialist,
                  ),
                ),
              );
              animator();
            },
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
                    radius: 22,
                    backgroundImage: widget.image,
                    backgroundColor: Colors.teal.shade900,
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(
                          "Online",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              buildActionButton(Icons.video_camera_front),
              SizedBox(width: 10),
              buildActionButton(Icons.call_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildActionButton(IconData icon) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.teal.shade700.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.teal.shade500.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.teal.shade300,
          size: 22,
        ),
      ),
    );
  }

  Widget buildMessagesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Color(0xFF0A0A0D),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            // Doctor message
            receivedMessage("Use the Stick on other hand Fandit", "08:20"),
            SizedBox(height: 30),
            // User message
            sentMessage("Thanks doc!", "09:20"),
            SizedBox(height: 30),
            // Date divider
            buildDateDivider("Today"),
            SizedBox(height: 30),
            // Doctor message
            receivedMessage(
                "Morning!\n\nHow the result did it\nwork well", "08:20"),
            SizedBox(height: 30),
            // User message
            sentMessage("Morning doc, Problem is\nsolved, Thanks doc", "08:25"),
            SizedBox(height: 20),
            // Emoji animation
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.shade700.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Image(
                image: AssetImage('assets/images/emoji.png'),
                width: 130,
                height: 130,
                color: Colors.white.withOpacity(0.9),
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildDateDivider(String date) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            margin: EdgeInsets.only(right: 10),
            color: Colors.teal.shade800.withOpacity(0.3),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Color(0xFF16161E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.teal.shade700.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Text(
            date,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            margin: EdgeInsets.only(left: 10),
            color: Colors.teal.shade800.withOpacity(0.3),
          ),
        ),
      ],
    );
  }

  Widget receivedMessage(String message, String time) {
    return Container(
      padding: const EdgeInsets.all(15),
      constraints: BoxConstraints(maxWidth: size.width * 0.7),
      decoration: BoxDecoration(
        color: Color(0xFF16161E),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        border: Border.all(
          color: Colors.teal.shade700.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          SizedBox(height: 6),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              time,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sentMessage(String message, String time) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: const EdgeInsets.all(15),
        constraints: BoxConstraints(maxWidth: size.width * 0.7),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.teal.shade700,
              Colors.teal.shade900,
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.shade900.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
            SizedBox(height: 6),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMessageInput() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Color(0xFF16161E),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.teal.shade700.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.emoji_emotions_outlined,
              color: Colors.teal.shade300,
              size: 22,
            ),
          ),
          Expanded(
            child: TextFormField(
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Type a message...",
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 5),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.teal.shade700,
              child: Transform.rotate(
                angle: -0.5,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
