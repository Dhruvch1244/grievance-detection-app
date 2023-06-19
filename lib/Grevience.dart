import 'package:flutter/material.dart';

class Grievance extends StatefulWidget {
  @override
  _GrievanceState createState() => _GrievanceState();
}

class _GrievanceState extends State<Grievance> {
List<GrievanceR> grievances = [
    GrievanceR(summary: "Power outage in T nagar area", upvotes: 10, reports: 2),
    GrievanceR(summary: "Poor road conditions", upvotes: 5, reports: 1),
    GrievanceR(summary: "Lack of clean drinking water", upvotes: 8, reports: 3),
    GrievanceR(summary: "Traffic jam at yamuna expressway", upvotes: 5, reports: 3),
    GrievanceR(summary: "Religious parade going in J nagar", upvotes: 1, reports: 3),
    // Add more grievance items as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grievances'),
       backgroundColor: Color(0xFF023436),
      ),
      body: Center(
        
        child: Column(
          
          children: [
            
              SizedBox(height: 30),
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
            
            SizedBox(height: 30),
            Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      
        border: Border.all(
          
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          "What's Going in your area?",
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    
              SizedBox(height: 30),
    Expanded(
        child: ListView.builder(
          itemCount: grievances.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(grievances[index].summary,
              style: TextStyle(
              ),

              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.thumb_up
                   ,color : Color(0xFF023436)),
                    onPressed: () {
                      setState(() {
                        grievances[index].upvotes++;
                      });
                    },
                  ),
                  Text('${grievances[index].upvotes}'),
                  IconButton(
                    icon: Icon(Icons.report,color : Color(0xFF023436),),
                    onPressed: () {
                      setState(() {
                        grievances[index].reports++;
                      });
                    },
                  ),
                  Text('${grievances[index].reports}'),
                ],
              ),
            );
          },
        ),
      ),

          ],
        ),
        
      ),
    );
  }
}




class GrievanceR {
  final String summary;
  int upvotes;
  int reports;

  GrievanceR({required this.summary, required this.upvotes, required this.reports});
}
