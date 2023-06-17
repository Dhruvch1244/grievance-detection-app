import 'package:flutter/material.dart';
import 'Profile.dart';

enum MenuOption {
  myProfile,
  grievances,
  news,
  reports,
  settings,
  report,
}

class dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<dashboard> {
  MenuOption _selectedOption = MenuOption.myProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF023436), // Custom color #023436
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            showMenuOptions(context);
          },
        ),
        title: Row(
          children: [
            SizedBox(width: 5),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigation logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: CircleAvatar(
                backgroundImage: AssetImage('images/OIP.jpeg'),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    // Handle location icon click
                    // Add your logic here
                  },
                  child: Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Noida, UP',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
                    Expanded(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 254, 0, 0).withOpacity(1),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Post(
                    title: 'Streetlight Broken',
                    author: 'JohnDoe123',
                    content: 'The court in front of Silver Hall is poorly lit due to multiple incidents of broken lights',
                    upvotes: 42,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 247, 0, 255).withOpacity(1),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Post(
                    title: 'Roadblock',
                    author: 'JaneSmith',
                    content: 'An ongoing construction has rendered the road leading to the Okhla Bird Sanctuary unusable',
                    upvotes: 75,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 41, 246, 0).withOpacity(1),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Post(
                    title: 'Security Risk',
                    author: 'DevDebate',
                    content: 'Many cases of mugging reported in Sector 74, extra caution is essential',
                    upvotes: 53,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 255, 196, 1).withOpacity(1),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Post(
                    title: 'Water Supply Problem',
                    author: 'SupDhru',
                    content: 'Water is being cut for 3 hours in afternoon daily.',
                    upvotes: 53,
                  ),
                ),
              ],
            ),
          ),
       
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to other page
          // Add your logic here
          Navigator.pushNamed(context, '/upload');
        },
        backgroundColor: Colors.green, // Set the background color to green
        child: Icon(
          Icons.add,
          size: 48, // Increase the size of the icon
        ),
      ),
      
    );
  }

  void showMenuOptions(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Menu'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Profile'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = MenuOption.myProfile;
                  
                  Navigator.pushNamed(context, '/MyProfile');
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.error),
              title: Text('Grievances'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = MenuOption.grievances;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.article),
              title: Text('News'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = MenuOption.news;
                });
              },
            ),
            
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = MenuOption.settings;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.report),
              title: Text('Report'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedOption = MenuOption.report;
                });
              },
            ),
          ],
        ),
      );
    },
  );
}
}
class Post extends StatefulWidget {
  final String title;
  final String author;
  final String content;
  int upvotes;

  Post({
    required this.title,
    required this.author,
    required this.content,
    required this.upvotes,
  });

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  bool _isUpvoted = false;

  void _toggleUpvote() {
    setState(() {
      if (_isUpvoted) {
        widget.upvotes--;
      } else {
        widget.upvotes++;
      }
      _isUpvoted = !_isUpvoted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Posted by u/${widget.author}',
            style: TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 8),
          Text(widget.content),
          SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                onTap: _toggleUpvote,
                child: Icon(
                  Icons.arrow_upward,
                  size: 20,
                  color: _isUpvoted ? Colors.green : null,
                ),
              ),
              SizedBox(width: 4),
              Text(widget.upvotes.toString()),
            ],
          ),
        ],
      ),
    );
  }
}