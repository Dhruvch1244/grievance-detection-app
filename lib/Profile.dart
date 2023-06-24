import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String username;

  ProfilePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
        
        backgroundColor: const Color(0xFF023436),
      ),
      backgroundColor: const Color(0xFF023436),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: const Column(
                  children: [
                    Text(
                      'Deshatan.',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 60),
                width: MediaQuery.of(context).size.width * 1,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: const Card(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('images/girl.jpg'),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        username,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '15 Followers  ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '15 Following',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        'Noida',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: const Card(
                              child: Text(
                                'Reviews (02)',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 0, 110, 0),
                            child: const Card(
                              child: Text(
                                'Grievances',
                                style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),

                      ],

                    ),

                  ),

                  SizedBox(
                  height: 200,
                  width: 350,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildImageWithButton('images/Taj-Mahal.jpg', '⭐',const EdgeInsets.all(24)),
                      _buildImageWithButton('images/hawamahal.webp',  '⭐',const EdgeInsets.all(24)),
                      _buildImageWithButton('images/mysorepalace.webp',  '⭐',const EdgeInsets.all(24)),
                      _buildImageWithButton('images/lakecity.webp',  '⭐',const EdgeInsets.all(24)),
                      // Add more images here
                      ],
                    ),
                  )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
}
Widget _buildImageWithButton(String imagePath, String emoji, EdgeInsets padding) {
  return Stack(
    children: [
      Padding(
        padding: padding,
        child: Image.asset(imagePath),
      ),
      Positioned(
        bottom: 8,
        left: 8,
        child: ElevatedButton.icon(
          onPressed: () {
            // Add your button action here
          },
          icon: Text(
            emoji,
            style: const TextStyle(color: Colors.white),
          ),
          label: const Text('5'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
        ),
      ),
    ],
  );
}

