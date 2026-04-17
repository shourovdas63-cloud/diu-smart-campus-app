import 'package:flutter/material.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final List<Map<String, dynamic>> exams = [
    {
      'course': 'CSE101',
      'date': '20 Dec 2025',
      'time': '10:00 AM',
      'room': 'Room 701',
      'type': 'Mid Exam',
      'saved': false,
    },
    {
      'course': 'MAT101',
      'date': '22 Dec 2025',
      'time': '12:00 PM',
      'room': 'Room 504',
      'type': 'Mid Exam',
      'saved': false,
    },
    {
      'course': 'ENG101',
      'date': '24 Dec 2025',
      'time': '9:00 AM',
      'room': 'Room 402',
      'type': 'Quiz',
      'saved': false,
    },
  ];

  void toggleSaved(int index) {
    setState(() {
      exams[index]['saved'] = !exams[index]['saved'];
    });
  }

  Color typeColor(String type) {
    switch (type) {
      case 'Mid Exam':
        return Colors.orange;
      case 'Quiz':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text('Exam Info'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exams.length,
        itemBuilder: (context, index) {
          final exam = exams[index];

          return Card(
            color: Colors.white.withOpacity(0.05),
            margin: const EdgeInsets.only(bottom: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        exam['course'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => toggleSaved(index),
                        icon: Icon(
                          exam['saved']
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: exam['saved'] ? Colors.amber : Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: typeColor(exam['type']).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      exam['type'],
                      style: TextStyle(
                        color: typeColor(exam['type']),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 16, color: Colors.white70),
                      const SizedBox(width: 8),
                      Text(
                        exam['date'],
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 16, color: Colors.white70),
                      const SizedBox(width: 8),
                      Text(
                        exam['time'],
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.room_outlined,
                          size: 16, color: Colors.white70),
                      const SizedBox(width: 8),
                      Text(
                        exam['room'],
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
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
