import 'package:flutter/material.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
var Newss = <NewsR>[
    NewsR(summary: "Power outage in T nagar area", upvotes: 10, reports: 2),
    NewsR(summary: "Poor road conditions", upvotes: 5, reports: 1),
    NewsR(summary: "Lack of clean drinking water", upvotes: 8, reports: 3),
    NewsR(summary: "Traffic jam at yamuna expressway", upvotes: 5, reports: 3),
    NewsR(summary: "Religious parade going in J nagar", upvotes: 1, reports: 3),
    // Add more News items as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
       backgroundColor: const Color(0xFF023436),
      ),
      body: Center(
        
        child: Column(
          
          children: [
            
              const SizedBox(height: 30),
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
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Noida, UP',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

              const SizedBox(height: 30),
              Container(
      
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),

                border: Border.all(

                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: const Center(
                child: Text(
                  "What will Happend in your Area",
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    
              const SizedBox(height: 30),
          Expanded(
              child: ListView.builder(
                itemCount: Newss.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(Newss[index].summary,
                    style: const TextStyle(
                    ),

                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.thumb_up
                         ,color : Color(0xFF023436)),
                          onPressed: () {
                            setState(() {
                              Newss[index].upvotes++;
                            });
                          },
                        ),
                        Text('${Newss[index].upvotes}'),
                        IconButton(
                          icon: const Icon(Icons.report,color : Color(0xFF023436),),
                          onPressed: () {
                            setState(() {
                              Newss[index].reports++;
                            });
                          },
                        ),
                        Text('${Newss[index].reports}'),
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




class NewsR {
  final String summary;
  int upvotes;
  int reports;

  NewsR({required this.summary, required this.upvotes, required this.reports});
}
