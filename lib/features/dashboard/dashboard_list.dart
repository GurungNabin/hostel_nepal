// import 'package:flutter/material.dart';
// import 'package:hostel/feature/dashboard/image_update.dart';
// import 'package:hostel/feature/dashboard/update_screen.dart';

// class DashboardTest extends StatefulWidget {
//   final String roomType;
//   final ValueChanged<bool> onAvailableBedValidationChanged;

//   const DashboardTest(
//       {super.key,
//       required this.roomType,
//       required this.onAvailableBedValidationChanged});

//   @override
//   State<DashboardTest> createState() => _DashboardTestState();
// }

// class _DashboardTestState extends State<DashboardTest> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey[300]!),
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.roomType,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 12.0),

//           // Price and bed and availability
//           Row(
//             children: [
//               Expanded(
//                 child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: 'Price',
//                     border: OutlineInputBorder(),
//                     isDense: true,
//                   ),
//                   onChanged: (value) {
//                     setState(() {});
//                   },
//                 ),
//               ),
//               const SizedBox(width: 16.0),
//               Expanded(
//                 child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: 'Total bed',
//                     border: OutlineInputBorder(),
//                     isDense: true,
//                   ),
//                   onChanged: (value) {
//                     setState(() {});
//                   },
//                 ),
//               ),
//               const SizedBox(width: 16.0),
//               Expanded(
//                 child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     labelText: 'Available bed',
//                     border: OutlineInputBorder(),
//                     isDense: true,
//                   ),
//                   onChanged: (value) {
//                     setState(() {});
//                   },
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12.0),

//           //Edit
//           Row(
//             children: [
//               ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const UpdateScreen()));
//                 },
//                 icon: const Icon(Icons.edit),
//                 label: const Text('Update'),
//               ),
//               const SizedBox(
//                 width: 16,
//               ),
//               OutlinedButton.icon(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const ImageScreen()));
//                 },
//                 icon: const Icon(Icons.image),
//                 label: const Text('Image'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hostel_nepal/features/dashboard/image_update.dart';
import 'package:hostel_nepal/features/dashboard/update_screen.dart';


class DashboardTest extends StatefulWidget {
  final String roomType;
  final String price;
  final String totalBed;
  final String availableBed;
  final ValueChanged<bool> onAvailableBedValidationChanged;

  const DashboardTest({
    super.key,
    required this.roomType,
    required this.price,
    required this.totalBed,
    required this.availableBed,
    required this.onAvailableBedValidationChanged,
  });

  @override
  State<DashboardTest> createState() => _DashboardTestState();
}

class _DashboardTestState extends State<DashboardTest> {
  late TextEditingController priceController;
  late TextEditingController totalBedController;
  late TextEditingController availableBedController;

  @override
  void initState() {
    super.initState();
    priceController = TextEditingController(text: widget.price);
    totalBedController = TextEditingController(text: widget.totalBed);
    availableBedController = TextEditingController(text: widget.availableBed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.roomType,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    controller: totalBedController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Total bed',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextFormField(
                    controller: availableBedController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Available bed',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpdateScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Update'),
                ),
                const SizedBox(
                  width: 16,
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ImageScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Image'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
