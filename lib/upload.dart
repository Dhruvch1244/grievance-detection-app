import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  String selectedLocation = 'Noida,UP';
  String subject = '';
  String issue = '';

  List<String> locationOptions = [
    'Noida,UP',
    'New Delhi',
    'Chennai,TN',
    'Hyderabad,TL',
  ];

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
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              color: Color(0xFFF7F3F5),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Location',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  DropdownButton<String>(
                    value: selectedLocation,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLocation = newValue!;
                      });
                    },
                    items: locationOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
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
              height: MediaQuery.of(context).size.height * 0.4,
             color: Color(0xFFF7F3F5),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Issue Raised',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 7 * 8), // 7 lines * 8 pixels per line
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.2,
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
