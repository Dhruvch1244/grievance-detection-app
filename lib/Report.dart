import 'package:flutter/material.dart';

class ReportIncidentScreen extends StatefulWidget {
  @override
  _ReportIncidentScreenState createState() => _ReportIncidentScreenState();
}

class _ReportIncidentScreenState extends State<ReportIncidentScreen> {
  String title = '';
  String complaint = '';
  String selectedTag = '';

  List<String> tags = ['Account Issues', 'Fake News', 'Summary Problem', 'User Problem', 'Explicit Content'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Incident'),

        backgroundColor: Color(0xFF023436),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter title...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Complaint',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  complaint = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter your complaint...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
        Text(
              'Tags',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
          Center(
            child: Container(
            child : Wrap(
              spacing:20.0,
              children: tags.map((tag) {
                return ChoiceChip(
                  label: Text(tag),
                  selected: selectedTag == tag,
                  onSelected: (selected) {
                    setState(() {
                      selectedTag = selected ? tag : '';
                    });
                  },
                );
              }).toList(),
            ),
            ),
          ),
            SizedBox(height: 16.0),

            Center(
              child: Container( // Set margin using EdgeInsets.fromLTRB()
                child: ElevatedButton(
                  onPressed: () {
                    // Handle submit button action
                    print('Title: $title');
                    print('Complaint: $complaint');
                    print('Selected Tag: $selectedTag');
                  },
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF023436), // Set button color to red
                    onPrimary: Colors.white, // Set text color to white
                    padding: EdgeInsets.symmetric(horizontal: 40.0), // Increase horizontal padding
                  ),
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}
