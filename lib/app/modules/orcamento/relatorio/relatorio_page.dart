import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:open_file/open_file.dart';

class RelatorioPage extends StatelessWidget {
  final String path;
  const RelatorioPage({Key key, this.path}) : super(key: key);

  void openFile() {
    OpenFile.open(path);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Tap to open file'),
                onPressed: openFile,
              ),
            ],
          ),
        ),
      ),
    );
  }
  /*
  Widget build(BuildContext context) {
    return 
    
    PDFViewerScaffold(
      path: path,
    );
  }*/
}
