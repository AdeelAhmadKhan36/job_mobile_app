import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:job_mobile_app/resources/constants/app_colors.dart';
import 'package:job_mobile_app/view/common/app_bar.dart';
import 'package:path_provider/path_provider.dart';

class PDFViewerScreen extends StatefulWidget {
  final String pdfUrl;

  const PDFViewerScreen({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  late String _localFilePath;
  bool _isLoading = true;
  double _pdfViewZoom = 1.0;

  @override
  void initState() {
    super.initState();
    _initPDF();
  }

  Future<void> _initPDF() async {
    final url = widget.pdfUrl;
    final filename = url.substring(url.lastIndexOf("/") + 1);
    final directory = await getTemporaryDirectory();
    final filepath = '${directory.path}/$filename';

    final response = await http.get(Uri.parse(url));
    final File file = File(filepath);
    await file.writeAsBytes(response.bodyBytes);

    if (mounted) {
      setState(() {
        _localFilePath = filepath;
        _isLoading = false;
      });
    }
  }

  void _zoomIn() {
    setState(() {
      _pdfViewZoom += 0.5;
    });
  }

  void _zoomOut() {
    setState(() {
      _pdfViewZoom -= 0.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          decoration: BoxDecoration(
            color: Color(kprimary_colors.value),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Custom_AppBar(
            text: "PDF Viewer",
            child: Column(
              children: [
                MaterialButton(
                  onPressed: () {
                  },
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : _localFilePath != null
          ? InteractiveViewer(
        child: PDFView(
          filePath: _localFilePath,
          enableSwipe: true,
          swipeHorizontal: true,
          pageSnap: true,
          defaultPage: 0,
          fitPolicy: FitPolicy.BOTH,
          preventLinkNavigation: false,
          onRender: (pages) {
            setState(() {});
          },
        ),
        minScale: 0.5,
        maxScale: 3.0,
      )
          : Center(
        child: Text('Failed to load PDF'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.zoom_in),
              onPressed: _zoomIn,
            ),
            IconButton(
              icon: Icon(Icons.zoom_out),
              onPressed: _zoomOut,
            ),
          ],
        ),
      ),
    );
  }
}
