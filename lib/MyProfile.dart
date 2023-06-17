import 'package:flutter/material.dart';
import 'package:newapp/upload.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String name = 'John Doe';
  String email = 'johndoe@example.com';
  List<String> grievances = [];

  void addGrievance(String grievance) {
    setState(() {
      grievances.add(grievance);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        backgroundColor: Color(0xFF023436),
      ),
      body: Center(
        child: Column(
          children: [
                  SizedBox(height: 40),

            Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
        SizedBox(height: 10),
                Text(
                  '$name',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyProfile()),
                    );
                  },
                ),
                   ],
            ),

        SizedBox(height: 10),
        Text(
          '$email',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Upload()),
    );
  },
  style: ElevatedButton.styleFrom(
    primary: Color(0xFF023436),
  ),
  child: Text('Add Grievance'),
),

      ],
    ),
    SizedBox(width: 10),
    Container(
      margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('images/OIP.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
  ],
),
        Container(
          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
          
                  width: MediaQuery.of(context).size.width * 0.9,
  decoration: BoxDecoration(
        border: Border(
      top: BorderSide(width: 1,color: Colors.grey),
      bottom: BorderSide(width: 1,color: Colors.grey),
    ),
  ),
  child: Row(
    
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            
  icon: Icon(Icons.arrow_upward_outlined),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyProfile()),
    );
  },
  iconSize: 45,
  padding: EdgeInsets.all(0),
  constraints: BoxConstraints(),
  visualDensity: VisualDensity.compact,
  alignment: Alignment.center,
  splashRadius: 45,
  highlightColor: Colors.transparent,
  color: Colors.black,
  splashColor: Colors.transparent,
  enableFeedback: true,
  tooltip: 'Upvote',
),

      Text('Upvotes'),
        ],
      ),
            Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
  icon: Icon(Icons.notifications),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyProfile()),
    );
  },
  iconSize: 45,
  padding: EdgeInsets.all(0),
  constraints: BoxConstraints(),
  visualDensity: VisualDensity.compact,
  alignment: Alignment.center,
  splashRadius: 45,
  highlightColor: Colors.transparent,
  color: Colors.black,
  splashColor: Colors.transparent,
  enableFeedback: true,
  tooltip: 'Notifications',
),

      Text('Notifications'),
        ],
      ),
            Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
  icon: Icon(Icons.settings),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyProfile()),
    );
  },
  iconSize: 45,
  padding: EdgeInsets.all(0),
  constraints: BoxConstraints(),
  visualDensity: VisualDensity.compact,
  alignment: Alignment.center,
  splashRadius: 45,
  highlightColor: Colors.transparent,
  color: Colors.black,
  splashColor: Colors.transparent,
  enableFeedback: true,
  tooltip: 'Settings',
),

      Text('Settings'),
        ],
      ),
    ],
  ),
),
  Expanded(
            child: ListView(
              children: [
                Container(
                  
          margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF023436).withOpacity(1),
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
          margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF023436).withOpacity(1),
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
          margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF023436).withOpacity(1),
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
          margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF023436).withOpacity(1),
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
      ),
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