import 'package:flutter/material.dart';
import 'package:resize_photo/data/resizer.dart';
import 'package:resize_photo/widgets/ResizerButton.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter resizer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading = false;
  String titleStatus = 'Resize image from asset';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resizer app"),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: ResizerButton(
              title: titleStatus,
              onPressed: () => _resizeImage(context),
              state: _loading ? false : true,
            ),
          ),
          _loading
              ? Align(
                  alignment: Alignment.center,
                  child: ResizerImageWidget(
                    title: 'canon-camera.jpg',
                    onPress: () {
                      setState(() {
                        titleStatus = 'Resize image from asset';
                        _loading = false;
                      });
                    },
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  _resizeImage(BuildContext context) async {
    setState(() {
      titleStatus = "Please waiting";
      _loading = true;
    });
  }
}
