import 'package:flutter/material.dart';

class RoomMain extends StatefulWidget {
  const RoomMain({super.key});

  @override
  State<RoomMain> createState() => _RoomMainState();
}

class _RoomMainState extends State<RoomMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room'),
      ),
    );
  }
}
