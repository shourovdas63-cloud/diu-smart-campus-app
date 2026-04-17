import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  final TextEditingController _controller = TextEditingController();

  List<dynamic> routine = [];
  bool isLoading = false;
  String? lastQuery;

  final String apiBase = 'http://127.0.0.1:5000';

  Future<void> fetchRoutine(String batchCode) async {
    if (batchCode.isEmpty) return;

    setState(() {
      isLoading = true;
      routine = [];
      lastQuery = batchCode;
    });

    try {
      final response = await http.get(Uri.parse('$apiBase/routine/$batchCode'));

      if (response.statusCode == 200) {
        setState(() {
          routine = json.decode(response.body);
        });
      } else {
        final msg = json.decode(response.body)['message'] ?? 'No routine found';
        _showSnackBar(msg, isError: true);
      }
    } catch (e) {
      _showSnackBar(
        'Connection error: Make sure the backend server is running.',
        isError: true,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> uploadRoutineFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'csv'],
      withData: true,
    );

    if (result != null) {
      setState(() => isLoading = true);

      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('$apiBase/upload'),
        );

        final fileHeader = http.MultipartFile.fromBytes(
          'file',
          result.files.single.bytes!,
          filename: result.files.single.name,
        );

        request.files.add(fileHeader);

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          _showSnackBar('Routine updated successfully!');
        } else {
          _showSnackBar(
            'Upload failed: ${json.decode(response.body)['error']}',
            isError: true,
          );
        }
      } catch (e) {
        _showSnackBar('Upload error: $e', isError: true);
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  void downloadPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text(
                  'DIU Routine - ${lastQuery ?? ''}',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headerDecoration: const pw.BoxDecoration(
                  color: PdfColors.grey300,
                ),
                headers: const ['Day', 'Time', 'Course', 'Room', 'Teacher'],
                data: routine.map((item) {
                  return [
                    item['day'] ?? '',
                    item['time'] ?? '',
                    item['course'] ?? '',
                    item['room'] ?? '',
                    item['teacher'] ?? '',
                  ];
                }).toList(),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white70),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text('Routine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter Batch/Section (e.g. 67_C)',
                  hintStyle: const TextStyle(color: Colors.white30),
                  prefixIcon: const Icon(Icons.search, color: Colors.white30),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(20),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF6366F1),
                    ),
                    onPressed: () => fetchRoutine(_controller.text.trim()),
                  ),
                ),
                onSubmitted: (value) => fetchRoutine(value.trim()),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: uploadRoutineFile,
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Update Data'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: routine.isEmpty ? null : downloadPDF,
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Export PDF'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : routine.isEmpty
                      ? Center(
                          child: Text(
                            lastQuery == null
                                ? 'Search for your batch routine'
                                : 'No records found for "$lastQuery"',
                            style: const TextStyle(color: Colors.white54),
                          ),
                        )
                      : ListView.builder(
                          itemCount: routine.length,
                          itemBuilder: (context, index) {
                            final entry = routine[index];

                            return Card(
                              color: Colors.white.withOpacity(0.05),
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry['course']?.toString() ??
                                          'UNKNOWN COURSE',
                                      style: const TextStyle(
                                        color: Color(0xFF818CF8),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    _infoRow(
                                      Icons.calendar_today,
                                      entry['day']?.toString() ?? '',
                                    ),
                                    const SizedBox(height: 8),
                                    _infoRow(
                                      Icons.access_time,
                                      entry['time']?.toString() ?? '',
                                    ),
                                    const SizedBox(height: 8),
                                    _infoRow(
                                      Icons.room_outlined,
                                      'Room: ${entry['room'] ?? ''}',
                                    ),
                                    const SizedBox(height: 8),
                                    _infoRow(
                                      Icons.person_outline,
                                      'Teacher: ${entry['teacher'] ?? ''}',
                                    ),
                                  ],
                                ),
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
