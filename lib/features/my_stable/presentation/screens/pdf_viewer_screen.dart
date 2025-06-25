import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:http/http.dart' as http;

class PdfViewerScreen extends StatefulWidget {
  final String pdfUrl;

  PdfViewerScreen({required this.pdfUrl});

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  PdfController? _pdfController;

  @override
  void initState() {
    super.initState();
    _initializePdf();
  }

  Future<void> _initializePdf() async {
    final response = await http.get(Uri.parse(widget.pdfUrl));
    if (response.statusCode == 200) {
      final pdfData = response.bodyBytes;
      setState(() {
        _pdfController = PdfController(
          document: PdfDocument.openData(pdfData),
        );
      });
    } else {
      // Handle error
      throw Exception('Failed to load PDF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF'),
      ),
      body: _pdfController == null
          // ? Center(child: Text("wait..."))
          ? Center(child: CircularProgressIndicator())
          : PdfView(
        controller: _pdfController!,
      ),
    );
  }

  @override
  void dispose() {
    _pdfController!.dispose();
    super.dispose();
  }
}
