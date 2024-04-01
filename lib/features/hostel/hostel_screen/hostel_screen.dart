import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_nepal/features/hostel/hostel_model/hosel_model.dart';
import 'package:hostel_nepal/features/hostel/hostel_repo/hostel_repo.dart';
import 'package:hostel_nepal/features/room/room_screen/room_main.dart';
import 'package:http/http.dart' as http;
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class HostelMain extends StatefulWidget {
  const HostelMain({super.key, required this.userId});

  final String userId;

  @override
  State<HostelMain> createState() => _HostelMainState();
}

class _HostelMainState extends State<HostelMain> {
  String cityId = '';
  String areaId = '';

  List<String> cityIds = [];
  List<String> areaIds = [];
  List<String> cityTitles = [];
  List<String> areaTitles = [];

  final GlobalKey<AutoCompleteTextFieldState<dynamic>> _autoCompleteKey =
      GlobalKey<AutoCompleteTextFieldState<dynamic>>();
  final GlobalKey<AutoCompleteTextFieldState<dynamic>> _secondAutoCompleteKey =
      GlobalKey<AutoCompleteTextFieldState<dynamic>>();

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _citySuggestionController = TextEditingController();
  final _areaSuggestionController = TextEditingController();

  int? dropdownValue;

  List<Map<String, dynamic>> list = [
    {'text': 'Boys', 'value': 1},
    {'text': 'Both', 'value': 2},
    {'text': 'Girls', 'value': 3},
  ];

  List<String>? _cityData; // Store the result of getCity()
  List<String>? _getAreaByCity;

  Future<List<String>> getCity() async {
    if (_cityData != null) {
      return _cityData!; // Return cached data if available
    }

    try {
      final response = await http
          .get(Uri.parse('https://collegesnepal.com/api/getCity.php'));
      if (response.statusCode == 200) {
        final List<dynamic> cityData = jsonDecode(response.body);
        cityTitles = cityData.map((city) => city['title'] as String).toList();
        cityIds = cityData.map((city) => city['id'] as String).toList();
        _cityData = cityTitles; // Cache the result
      } else {
        throw Exception('Failed to load options');
      }
    } catch (e) {
      print('Error fetching city data: $e');
      return [];
    }
    return cityTitles;
  }

  Future<List<String>> getAreaByCity(String cityId) async {
    if (_getAreaByCity != null) {
      return _getAreaByCity!;
    }
    try {
      final response = await http.get(Uri.parse(
          'https://collegesnepal.com/api/getAreaByCity.php?cityId=$cityId'));
      // print('Second API Response: ${response.body}'); // Debugging line
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        areaTitles = data.map((area) => area['title'] as String).toList();
        areaIds = data.map((area) => area['id'] as String).toList();
        print('Area Data: $areaTitles');
        print('Area Indexes: $areaIds');
      } else {
        throw Exception('Failed to load secondary suggestions');
      }
    } catch (e) {
      print('Error fetching area data: $e');
      return [];
    }
    if (cityId == '') {
      areaTitles = [];
    }
    return areaTitles;
  }
  // final _imageController = TextEditingController();
  // final _imageExtensionController = TextEditingController();

  List<XFile>? _images = [];
  final ImagePicker _picker = ImagePicker();

//multiple image
  Future<void> _getMultipleImages() async {
    try {
      final List<XFile> pickedFiles =
          await _picker.pickMultiImage(imageQuality: 50);

      setState(() {
        _images = pickedFiles;
      });
    } catch (e) {
      // Handle image picking errors.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking images: $e'),
        ),
      );
    }
  }

  //click a image
  Future<void> _getImageFormCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
      );
      if (image != null) {
        setState(() {
          _images = [image]; // Set the image
        });
        // Get the image path
        String imagePath = image.path;
        print('Image captured at: $imagePath');
      }
    } catch (e) {
      // Handle error
      // ErrorHandler.handleError(e);
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _images!.removeAt(index);
    });
  }

  void _submitForm() {
    final name = _nameController.text;
    final address = _addressController.text;
    final location = int.parse(cityId);
    final area = int.parse(areaId);
    final phone = _phoneController.text;
    final type = dropdownValue;

    // Get the list of image paths
    List<String> imagePaths = _images!.map((image) => image.path).toList();

    // Create a HostelModel object
    final hostelData = HosetlInfoModel(
      name: name,
      location: location,
      area: area,
      address: address,
      phone: phone,
      type: type.toString(),
      images: [],
      imagesExtension: [],
    );

    // Pass the image path to createHostelInfo
    HostelApi.createHostelInfo(hostelData, imagePaths).then((hostelId) {
      // Navigate to the next page after successful submission

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RoomMain(
                  hid: hostelId,
                )),
      );

      // Navigator.pushNamed(context, '/room-screen');
    }).catchError((error) {
      // Handle error, for example, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit form: $error'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getCity();
    getAreaByCity(cityId);
  }

  // String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Hostel Form')),
        // automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //hostel name
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Hostel Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Hostel City
                FutureBuilder<List<String>>(
                  future: getCity(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CupertinoActivityIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return AutoCompleteTextField(
                        decoration: InputDecoration(
                            labelText: 'City',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                        key: _autoCompleteKey,
                        controller: _citySuggestionController,
                        suggestions: snapshot.data ?? [],
                        clearOnSubmit: false,
                        itemFilter: (item, query) {
                          return item
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase());
                        },
                        itemSorter: (a, b) {
                          return a.compareTo(b);
                        },
                        itemSubmitted: (item) {
                          _citySuggestionController.text = item;
                          setState(() {
                            cityId = cityIds[cityTitles.indexOf(item)];
                            _areaSuggestionController.text = '';
                          });
                        },
                        itemBuilder: (context, item) {
                          return Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 180, 180, 180)
                                          .withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.location_city,
                                    color: Colors.deepPurple), // Custom icon
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: const TextStyle(color: Colors.black),
                                    overflow: TextOverflow
                                        .ellipsis, // Handle long text
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                // Hostel Area
                FutureBuilder<List<String>>(
                  future: cityId.isEmpty
                      ? Future.value([])
                      : getAreaByCity(cityId.toString()),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CupertinoActivityIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return AutoCompleteTextField(
                        decoration: InputDecoration(
                            labelText: 'Area',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                        key: _secondAutoCompleteKey,
                        controller: _areaSuggestionController,
                        suggestions: snapshot.data ?? [],
                        clearOnSubmit: false,
                        itemFilter: (item, query) {
                          return item
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase());
                        },
                        itemSorter: (a, b) {
                          return a.compareTo(b);
                        },
                        itemSubmitted: (item) {
                          _areaSuggestionController.text = item;
                          areaId = areaIds[areaTitles.indexOf(item)];
                        },
                        itemBuilder: (context, item) {
                          return Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 180, 180, 180)
                                          .withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.location_city,
                                    color: Colors.deepPurple), // Custom icon
                                const SizedBox(
                                    width:
                                        8.0), // Spacing between icon and text
                                Expanded(
                                  child: Text(
                                    item,
                                    style: const TextStyle(color: Colors.black),
                                    overflow: TextOverflow
                                        .ellipsis, // Handle long text
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                //hotel address
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText:
                        'Hostel Street (Optional)', // Add (Optional) to the label

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    suffixIcon: Icon(
                      Icons.info_outline,
                      // color: Colors.red,
                    ), // Optionally, you can add an info icon
                  ),
                ),

                const SizedBox(height: 20),

                //Phone
                TextFormField(
                  controller: _phoneController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the phone number';
                    }
                    // if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    //   return 'Phone number must be 10 digits';
                    // }

                    return null;
                  },
                ),
                const SizedBox(height: 20),

                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<int>(
                    value: dropdownValue,
                    onChanged: (int? value) {
                      setState(() {
                        dropdownValue = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Select an option',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    items: list.map((item) {
                      return DropdownMenuItem<int>(
                        value: item['value'] as int,
                        child: Text(item['text'] as String),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),

                //image
                Center(
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: TextButton.icon(
                                onPressed: _getMultipleImages,
                                icon: const Icon(Icons.image),
                                label: const Text(
                                  'Select image',
                                )),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: TextButton.icon(
                              onPressed: _getImageFormCamera,
                              icon: const Icon(Icons.camera),
                              label: const Text(
                                'Take image',
                              ),
                            ),
                          ),
                        ],
                      ),
                      for (int i = 0; i < _images!.length; i++)
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.file(
                                File(_images![i].path),
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _deleteImage(i),
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitForm();
                    }
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
