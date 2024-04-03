import 'package:flutter/material.dart';
import 'package:hostel_nepal/constants/global_variables.dart';
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
  late Future<List<FacilityModel>> _futureFacilities;
  late List<bool> _isSelectedList;
  bool _selectAll = false;

  @override
  void initState() {
    super.initState();
    _futureFacilities = _facilityService.getFacility();
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
            Material(
              elevation: 10,
              child: CheckboxListTile(
                // Step 2: Add a CheckboxListTile for "Select All"
                activeColor: GlobalVariables.mainColor,
                title: const Text('Select All'),
                value: _selectAll,
                tileColor: Color.fromRGBO(255, 255, 255, 1),
                onChanged: (bool? value) {
                  setState(() {
                    _selectAll = value!;
                    _isSelectedList =
                        List<bool>.filled(_isSelectedList.length, _selectAll);
                  });
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<List<FacilityModel>>(
                future: _futureFacilities,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
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
                          FacilityModel facility = snapshot.data![index];
                          return CheckboxListTile(
                              activeColor: GlobalVariables.mainColor,
                              title: Text(facility.title),
                              value: _isSelectedList[index],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isSelectedList[index] = value!;
                                });
                              });
                        });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
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
            ),
          ],
        ),
      ),
    );
  }
}
