import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportIncidentScreen extends StatefulWidget {
  @override
  _ReportIncidentScreenState createState() => _ReportIncidentScreenState();
}

class _ReportIncidentScreenState extends State<ReportIncidentScreen> {
  String title = '';
  String complaint = '';
  String selectedTag = '';

  List<String> tags = [
    'Account Issues',
    'Fake News',
    'Summary Problem',
    'User Problem',
    'Explicit Content'
  ];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
                spacing: 20.0,
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
                  _submitReport();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF023436),
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                ),
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitReport() {
    if (title.isNotEmpty && complaint.isNotEmpty && selectedTag.isNotEmpty) {
      _firestore.collection('incidents').add({
        'title': title,
        'complaint': complaint,
        'tag': selectedTag,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((_) {
        // Reset the form after successful submission
        setState(() {
          title = '';
          complaint = '';
          selectedTag = '';
        });

        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: const Text('Success'),
                content: const Text('Incident report submitted successfully.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);

                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: const Text('Error'),
                content: Text(
                    'An error occurred while submitting the report: $error'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      });
    } else {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text('Error'),
              content: const Text('Please fill in all the required fields.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    }
  }
}
