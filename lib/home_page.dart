import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NfcReadPage extends StatefulWidget {
  @override
  _NfcReadPageState createState() => _NfcReadPageState();
}

class _NfcReadPageState extends State<NfcReadPage> {
  String _nfcData = "Pas de données NFC";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkNfcAvailability());
  }

  void _checkNfcAvailability() {
    NfcManager.instance.isAvailable().then((bool isAvailable) {
      if (!isAvailable) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("NFC n'est pas disponible sur cet appareil"),
        ));
      }
    });
  }

  void _startNfcSession() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      print(tag);
      setState(() {
        _nfcData = tag.data.toString();
      });

      NfcManager.instance.stopSession();
    }).catchError((e) {
      print("Erreur lors de la lecture NFC: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecture NFC'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _startNfcSession,
              child: Text('Lire Tag NFC'),
            ),
            SizedBox(height: 20),
            Text(_nfcData),
          ],
        ),
      ),
    );
  }
}
