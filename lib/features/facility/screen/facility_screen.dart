import 'package:flutter/material.dart';
import 'package:hostel_nepal/features/facility/model/facility_model.dart';
import 'package:hostel_nepal/features/facility/repository/facility_repo.dart';
import 'package:hostel_nepal/features/rule/rule_screen/rule.dart';


class FacilityMain extends StatefulWidget {
  const FacilityMain({
    super.key,
  });

  @override
  State<FacilityMain> createState() => _FacilityMainState();
}

class _FacilityMainState extends State<FacilityMain> {
  final FacilityService _facilityService = FacilityService();
  late Future<List<Facility>> _futureFacilities;
  late List<bool> _isSelectedList;

  @override
  void initState() {
    super.initState();
    _futureFacilities = _facilityService.getFacility(context: context);
    _isSelectedList = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facility'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: FutureBuilder<List<Facility>>(
                future: _futureFacilities,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    if (_isSelectedList.isEmpty) {
                      _isSelectedList =
                          List<bool>.filled(snapshot.data!.length, false);
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Facility facility = snapshot.data![index];
                        return ListTile(
                          title: Text(facility.title),
                          leading: Checkbox(
                            value: _isSelectedList[index],
                            onChanged: (bool? value) {
                              setState(() {
                                _isSelectedList[index] = value!;
                              });
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RuleForm()));
                },
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
