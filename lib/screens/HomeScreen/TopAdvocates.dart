import 'dart:convert'; // Import this for JSON decoding
import 'package:casemet/provider/theme.dart';
import 'package:casemet/screens/HomeScreen/TopAdvocate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for rootBundle
import 'package:provider/provider.dart';

class TopAdvocates extends StatefulWidget {
  const TopAdvocates({super.key});

  @override
  State<TopAdvocates> createState() => _TopAdvocatesState();
}

class _TopAdvocatesState extends State<TopAdvocates> {
  List<Map<String, dynamic>> liveAdvocates =
      []; // Updated to hold advocate data

  @override
  void initState() {
    super.initState();
    _loadAdvocates();
  }

  Future<void> _loadAdvocates() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/json/topadvocate.json');
      final List<dynamic> jsonData = json.decode(jsonString);
      setState(() {
        liveAdvocates = jsonData
            .map((item) => {
                  'name': item['name'],
                  'image': item['profileImage'],
                  'specialization': item['specialization']
                })
            .toList();
      });
    } catch (e) {
      print("Error loading advocates data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Provider.of<ThemeProviderState>(context);
    return SizedBox(
      height: 165,
      child: liveAdvocates.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: liveAdvocates.length,
              separatorBuilder: (context, index) => const SizedBox(width: 5),
              itemBuilder: (context, index) {
                return Container(
                  width: 125,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                          width: 0.5,
                          color: themeData.isDarkMode
                              ? Colors.grey
                              : Colors.black26)),
                  child: SizedBox(
                    // width: 20,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const TopAdvocate()),
                            );
                          },
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.deepPurple[100],
                              child: ClipOval(
                                child: Image.asset(
                                  liveAdvocates[index]['image'],
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          liveAdvocates[index]['name'],
                          style: TextStyle(
                            fontSize: 14,
                            color: themeData.isDarkMode
                                ? Colors.deepPurpleAccent
                                : Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 95,
                          child: Text(
                            liveAdvocates[index]['specialization'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: themeData.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.deepPurple[100],
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.fromLTRB(38, 2, 38, 2),
                          child: const Text('₹99',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.deepPurple,
                              )),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
