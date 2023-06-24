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
        title: const Text('Report Incident'),

        backgroundColor: const Color(0xFF023436),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter title...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Complaint',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  complaint = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter your complaint...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
        const Text(
              'Tags',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
          Center(
            child: Wrap(
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
            const SizedBox(height: 16.0),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle submit button action
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: const Color(0xFF023436), // Set text color to white
                  padding: const EdgeInsets.symmetric(horizontal: 40.0), // Increase horizontal padding
                ),
                child: const Text('Submit'),
              ),
            )


          ],
        ),
      ),
    );
  }
}
