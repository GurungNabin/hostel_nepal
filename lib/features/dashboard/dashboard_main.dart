// import 'package:flutter/material.dart';
// import 'package:hostel/feature/dashboard/dashboard_list.dart';
// import 'package:hostel/feature/facility/screen/facility_screen.dart';

// class DashBoardMain extends StatefulWidget {
//   const DashBoardMain({super.key});

//   @override
//   State<DashBoardMain> createState() => _DashBoardMainState();
// }

// class _DashBoardMainState extends State<DashBoardMain> {
//   bool _areAvailableBedsValid = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('DashBoard'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: ListView(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: DashboardTest(
//                     roomType: 'Single Seater',
//                     price: '0',
//                     totalBed: '0',
//                     availableBed: '0',
//                     onAvailableBedValidationChanged: (isValid) {
//                       // Update the overall validation status
//                       setState(() {
//                         _areAvailableBedsValid = isValid;
//                       });
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: DashboardTest(
//                     roomType: 'Double Seater',
//                     price: '0',
//                     totalBed: '0',
//                     availableBed: '0',
//                     onAvailableBedValidationChanged: (isValid) {
//                       // Update the overall validation status
//                       setState(() {
//                         _areAvailableBedsValid = isValid;
//                       });
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: DashboardTest(
//                     roomType: 'Triple Seater',
//                     price: '0',
//                     totalBed: '0',
//                     availableBed: '0',
//                     onAvailableBedValidationChanged: (isValid) {
//                       // Update the overall validation status
//                       setState(() {
//                         _areAvailableBedsValid = isValid;
//                       });
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: DashboardTest(
//                     roomType: 'Fourth Seater',
//                     price: '0',
//                     totalBed: '0',
//                     availableBed: '0',
//                     onAvailableBedValidationChanged: (isValid) {
//                       // Update the overall validation status
//                       setState(() {
//                         _areAvailableBedsValid = isValid;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 if (_areAvailableBedsValid) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const FacilityMain(),
//                     ),
//                   );
//                 } else {
//                   // Show an error message or handle the invalid condition
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content:
//                           Text('Available bed cannot be more than Total bed'),
//                     ),
//                   );
//                 }
//               },
//               child: const Text('Next'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hostel_nepal/features/dashboard/dashboard_list.dart';
import 'package:hostel_nepal/features/facility/screen/facility_screen.dart';

class DashBoardMain extends StatefulWidget {
  const DashBoardMain({super.key});

  @override
  State<DashBoardMain> createState() => _DashBoardMainState();
}

class _DashBoardMainState extends State<DashBoardMain> {
  bool _areAvailableBedsValid = true;
  Map<String, dynamic> singleSeaterData = {};
  Map<String, dynamic> doubleSeaterData = {};
  Map<String, dynamic> tripleSeaterData = {};
  Map<String, dynamic> fourSeaterData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashBoard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DashboardTest(
                  roomType: 'Single Seater',
                  price: singleSeaterData['total_price'] ?? '0',
                  totalBed: singleSeaterData['total_bed'] ?? '0',
                  availableBed: singleSeaterData['available_bed'] ?? '0',
                  onAvailableBedValidationChanged: (isValid) {
                    // Update the overall validation status
                    setState(() {
                      _areAvailableBedsValid = isValid;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DashboardTest(
                  roomType: 'Double Seater',
                  price: doubleSeaterData['total_price'] ?? '0',
                  totalBed: doubleSeaterData['total_bed'] ?? '0',
                  availableBed: doubleSeaterData['available_bed'] ?? '0',
                  onAvailableBedValidationChanged: (isValid) {
                    // Update the overall validation status
                    setState(() {
                      _areAvailableBedsValid = isValid;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DashboardTest(
                  roomType: 'Triple Seater',
                  price: tripleSeaterData['total_price'] ?? '0',
                  totalBed: tripleSeaterData['total_bed'] ?? '0',
                  availableBed: tripleSeaterData['available_bed'] ?? '0',
                  onAvailableBedValidationChanged: (isValid) {
                    // Update the overall validation status
                    setState(() {
                      _areAvailableBedsValid = isValid;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DashboardTest(
                  roomType: 'Fourth Seater',
                  price: fourSeaterData['total_price'] ?? '0',
                  totalBed: fourSeaterData['total_bed'] ?? '0',
                  availableBed: fourSeaterData['available_bed'] ?? '0',
                  onAvailableBedValidationChanged: (isValid) {
                    // Update the overall validation status
                    setState(() {
                      _areAvailableBedsValid = isValid;
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (_areAvailableBedsValid) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FacilityMain(),
                    ),
                  );
                } else {
                  // Show an error message or handle the invalid condition
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Available bed cannot be more than Total bed'),
                    ),
                  );
                }
              },
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
