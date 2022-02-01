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
    PdfGrid grid = PdfGrid();

    grid.columns.add(count: 3);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = "Form Id";
    header.cells[1].value = "Full Name";
    header.cells[2].value = "Class";

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = "1";
    row.cells[1].value = "Nadeesha Pathiraja";
    row.cells[2].value = "Grade 6";

    row = grid.rows.add();
    row.cells[0].value = "2";
    row.cells[1].value = "Sumudu Sanakelum";
    row.cells[2].value = "Grade 8";
    row = grid.rows.add();

    row.cells[0].value = "3";
    row.cells[1].value = "Janaka Perera";
    row.cells[2].value = "Grade 4";

    //Create new page and add
    grid.draw(
      page: document.pages.add(),
      bounds: const Rect.fromLTWH(
        0,
        0,
        0,
        0,
      ),
    );

//Create cocument
    List<int> bytes = document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'Invoice.pdf');
  }
}

Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('assets/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
