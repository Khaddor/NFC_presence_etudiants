import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';
import 'sheets_service.dart';

class GeneratePdfPage extends StatefulWidget {
  @override
  _GeneratePdfPageState createState() => _GeneratePdfPageState();
}

class _GeneratePdfPageState extends State<GeneratePdfPage> {
  double _progress = 0;
  String? _pdfPath;
  bool _isGenerating = false;
  final service = SheetsService();

  void _generatePdf() {
    setState(() {
      _progress = 0;
      _pdfPath = null;
      _isGenerating = true;
    });

    SheetsService.generatePdfStream(service).listen((event) {
      if (event is double) {
        setState(() => _progress = event);
      } else if (event is String) {
        setState(() => _pdfPath = event);
      }
    }, onError: (error) {
      print("Erreur lors de la génération du PDF: $error");
      setState(() {
        _progress = 0;
        _isGenerating = false;
      });
    }, onDone: () => setState(() {
      _progress = 1.0;
      _isGenerating = false;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Générer le PDF'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_isGenerating && _pdfPath == null)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Cliquez pour télécharger le PDF'),
                      IconButton(
                        onPressed: _generatePdf,
                        icon: const Icon(Icons.download_rounded,
                            color: Colors.blue),
                        tooltip: 'Télécharger',
                      ),
                    ],
                  ),
                ),
              ),
            if (_isGenerating && _progress < 1.0)
              const Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text('Génération du PDF en cours...'),
                    ],
                  ),
                ),
              ),
            if (_pdfPath != null)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Icon(Icons.check, size: 50, color: Colors.green),
                      const SizedBox(height: 20),
                      const Text('PDF généré avec succès!'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.visibility,
                                color: Colors.green),
                            onPressed: () => OpenFile.open(_pdfPath!),
                            tooltip: 'Visualiser',
                          ),
                          IconButton(
                            icon: const Icon(Icons.share, color: Colors.blue),
                            onPressed: () {
                              Share.shareXFiles([XFile(_pdfPath!)],
                                  text: 'Voici le PDF généré.');
                            },
                            tooltip: 'Partager',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}