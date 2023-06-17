import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String username;

  ProfilePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
        
        backgroundColor: Color(0xFF023436),
      ),
      backgroundColor: Color(0xFF023436),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: Column(
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
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 60),
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Card(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('images/girl.jpg'),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        username,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
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
                    Padding(
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
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Card(
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
                            padding: EdgeInsets.fromLTRB(20, 0, 110, 0),
                            child: Card(
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

Container(
  height: 200,
  width: 350,
  child: ListView(
    scrollDirection: Axis.horizontal,
    children: [
      _buildImageWithButton('images/Taj-Mahal.jpg', '⭐',EdgeInsets.all(24)),
      _buildImageWithButton('images/hawamahal.webp',  '⭐',EdgeInsets.all(24)),
      _buildImageWithButton('images/mysorepalace.webp',  '⭐',EdgeInsets.all(24)),
      _buildImageWithButton('images/lakecity.webp',  '⭐',EdgeInsets.all(24)),
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
            style: TextStyle(color: Colors.white),
          ),
          label: Text('5'),
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
        ),
      ),
    ],
  );
}

