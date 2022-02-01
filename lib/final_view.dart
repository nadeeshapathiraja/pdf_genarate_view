import 'package:flutter/material.dart';
import 'package:pdf_vie/model/final_view_model.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'provider/final_vie_provider.dart';

class FinalView extends StatefulWidget {
  const FinalView({Key? key}) : super(key: key);

  @override
  _FinalViewState createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.picture_as_pdf,
                size: 100,
              ),
              const Text(
                "Genarate PDF",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: _createPdf,
                child: const Text("Invoice PDF"),
              ),
            ],
          ),
        ),
      ),
    );
  }

//Text add
  Future<void> _createPdf() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString(
      "Welcome to My World",
      PdfStandardFont(
        PdfFontFamily.helvetica,
        30,
      ),
    );
//Image Add
    page.graphics.drawImage(
      PdfBitmap(
        await _readImageData("log.png"),
      ),
      const Rect.fromLTWH(
        0,
        30,
        440,
        550,
      ),
    );
//table add
    PdfGrid

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Invoice.pdf');
  }
}

Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('assets/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
