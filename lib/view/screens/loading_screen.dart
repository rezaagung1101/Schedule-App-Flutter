import 'package:flutter/material.dart';
import '../widgets/body_text.dart';


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Container(
      color: Colors.black.withOpacity(0.6), // Semi-transparent overlay
      child: Center(
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              BodyText(text: "Loading", size: 14, color: Colors.black87,),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                      color: Colors.white,
                      backgroundColor: Colors.blue,
                      strokeWidth: 2)),
            ],
          ),
        ),
      ),
    );
  }
}
