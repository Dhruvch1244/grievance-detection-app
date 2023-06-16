import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  
  String subject = '';
  String issue = '';

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF023436),
        title: Text(
          'Raise Issue',
          style: TextStyle(fontSize: 32),
        ),
      ),
      
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 20),
            
            SizedBox(height: 20),
            Container(
              color: Color(0xFFF7F3F5 ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subject',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  SubjectContainer(
                    onSubjectChanged: (value) {
                      setState(() {
                        subject = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            Container(
             color: Color(0xFFF7F3F5),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Issue Raised',
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.all(16),
                    child: TextField(
                      maxLines: null,
                      onChanged: (value) {
                        setState(() {
                          issue = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Write your issue...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.1,
              
              child: ElevatedButton(
                onPressed: () {
                  // Implement upload functionality here
                  Navigator.pushNamed(context, '/dashboard');
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF023436), 
                  // Set the button color to #023436
                ),
                child: Text('Upload'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectContainer extends StatelessWidget {
  final Function(String) onSubjectChanged;

  SubjectContainer({required this.onSubjectChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[200],
      child: TextField(
        onChanged: onSubjectChanged,
        decoration: InputDecoration(
          hintText: 'Subject',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}