import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hostel_nepal/constants/global_variables.dart';
import 'package:hostel_nepal/features/facility/screen/facility_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class RoomMain extends StatefulWidget {
  const RoomMain({
    super.key,
    required this.hid,
  });

  final String hid;

  static const String routeName = '/room-screen';

  @override
  State<RoomMain> createState() => _RoomMainState();
}

class _RoomMainState extends State<RoomMain> {
  TextEditingController singleSeaterRoomsController = TextEditingController();
  TextEditingController singleSeaterPriceController = TextEditingController();
  TextEditingController singleSeaterAvailabeController =
      TextEditingController();

  TextEditingController singleSeaterSpecialRoomsController =
      TextEditingController();
  TextEditingController singleSeaterSpecialPriceController =
      TextEditingController();
  TextEditingController singleSeaterSpecialAvailabeController =
      TextEditingController();

  TextEditingController doubleSeaterRoomsController = TextEditingController();
  TextEditingController doubleSeaterPriceController = TextEditingController();
  TextEditingController doubleSeaterAvailabeController =
      TextEditingController();

  TextEditingController doubleSeaterSpecialRoomsController =
      TextEditingController();
  TextEditingController doubleSeaterSpecialPriceController =
      TextEditingController();
  TextEditingController doubleSeaterSpecialAvailabeController =
      TextEditingController();

  TextEditingController tripleSeaterRoomsController = TextEditingController();
  TextEditingController tripleSeaterPriceController = TextEditingController();
  TextEditingController tripleSeaterAvailabeController =
      TextEditingController();

  TextEditingController tripleSeaterSpecialRoomsController =
      TextEditingController();
  TextEditingController tripleSeaterSpecialPriceController =
      TextEditingController();
  TextEditingController tripleSeaterSpecialAvailabeController =
      TextEditingController();

  TextEditingController fourSeaterRoomsController = TextEditingController();
  TextEditingController fourSeaterPriceController = TextEditingController();
  TextEditingController fourSeaterAvailabeController = TextEditingController();

  TextEditingController fourSeaterSpecialRoomsController =
      TextEditingController();
  TextEditingController fourSeaterSpecialPriceController =
      TextEditingController();
  TextEditingController fourSeaterSpecialAvailabeController =
      TextEditingController();

  List<XFile>? _singleSeaterImages = [];
  List<XFile>? _doubleSeaterImages = [];
  List<XFile>? _tripleSeaterImages = [];
  List<XFile>? _fourSeaterImages = [];

  ValueNotifier<bool> singleSeaterSpecialCheckbox = ValueNotifier<bool>(false);
  ValueNotifier<bool> doubleSeaterSpecialCheckbox = ValueNotifier<bool>(false);
  ValueNotifier<bool> tripleSeaterSpecialCheckbox = ValueNotifier<bool>(false);
  ValueNotifier<bool> fourSeaterSpecialCheckbox = ValueNotifier<bool>(false);
  List<String>? _roomData; // Store the result of getCity()

  final ImagePicker _picker = ImagePicker();
  Future<void> _getSingleImage(int seaterType) async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          switch (seaterType) {
            case 1:
              _singleSeaterImages = [pickedFile];
              break;
            case 2:
              _doubleSeaterImages = [pickedFile];
              break;
            case 3:
              _tripleSeaterImages = [pickedFile];
              break;
            case 4:
              _fourSeaterImages = [pickedFile];
              break;
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
        ),
      );
    }
  }

  Future<void> _getMultipleImages(int seaterType) async {
    try {
      final List<XFile> pickedFiles =
          await _picker.pickMultiImage(imageQuality: 50);
      setState(() {
        switch (seaterType) {
          case 1:
            _singleSeaterImages = pickedFiles;
            break;
          case 2:
            _doubleSeaterImages = pickedFiles;
            break;
          case 3:
            _tripleSeaterImages = pickedFiles;
            break;
          case 4:
            _fourSeaterImages = pickedFiles;
            break;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking images: $e'),
        ),
      );
    }
  }

  // Function to delete an image
  void _deleteImage(int index, int seaterType) {
    setState(() {
      switch (seaterType) {
        case 1:
          _singleSeaterImages!.removeAt(index);
          break;
        case 2:
          _doubleSeaterImages!.removeAt(index);
          break;
        case 3:
          _tripleSeaterImages!.removeAt(index);
          break;
        case 4:
          _fourSeaterImages!.removeAt(index);
          break;
      }
    });
  }

  List<String> roomIds = [];
  // List<String> areaIds = [];
  List<String> roomTitles = [];
  // List<String> areaTitles = []
  Future<List<String>> getRooms() async {
    if (_roomData != null) {
      return _roomData!; // Return cached data if available
    }
    try {
      final response = await http
          .get(Uri.parse('https://collegesnepal.com/api/getseaterlist.php'));
      if (response.statusCode == 200) {
        final List<dynamic> roomData = jsonDecode(response.body);
        roomTitles = roomData.map((room) => room['title'] as String).toList();
        roomIds = roomData.map((room) => room['id'] as String).toList();
        _roomData = roomTitles; // Cache the result
        print(_roomData);
      } else {
        throw Exception('Failed to load options');
      }
    } catch (e) {
      print('Error fetching room data: $e');
      return [];
    }
    return roomTitles;
  }

  @override
  void initState() {
    getRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Room Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<String>>(
          future: getRooms(), // Your method to fetch room data
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator()); // Show loading animation
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text('Error fetching data')); // Show error message
            } else {
              // Assuming getRooms() returns a list of room titles
              _roomData = snapshot.data; // Cache the result
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //single seater
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Specify the border color
                              width: 1.0, // Specify the border width
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              _buildSeaterInput(
                                  _roomData![0],
                                  singleSeaterRoomsController,
                                  singleSeaterAvailabeController,
                                  singleSeaterPriceController,
                                  'One'),
                              _buildspecialSeaterInput(
                                  singleSeaterSpecialCheckbox,
                                  _roomData![1],
                                  'One',
                                  singleSeaterSpecialRoomsController,
                                  singleSeaterSpecialAvailabeController,
                                  singleSeaterSpecialPriceController),
                              _buildImageSelection(
                                _singleSeaterImages,
                                () async {
                                  await _getSingleImage(1);
                                },
                                () async {
                                  await _getMultipleImages(1);
                                },
                                1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Divider(
                          color: Colors.red,
                        ),

                        //double seater
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Specify the border color
                              width: 1.0, // Specify the border width
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              _buildSeaterInput(
                                  _roomData![2],
                                  doubleSeaterRoomsController,
                                  doubleSeaterAvailabeController,
                                  doubleSeaterPriceController,
                                  'Two'),
                              _buildspecialSeaterInput(
                                  doubleSeaterSpecialCheckbox,
                                  _roomData![3],
                                  'Two',
                                  doubleSeaterSpecialRoomsController,
                                  doubleSeaterSpecialAvailabeController,
                                  doubleSeaterSpecialPriceController),
                              _buildImageSelection(
                                _doubleSeaterImages,
                                () async {
                                  await _getSingleImage(2);
                                },
                                () async {
                                  await _getMultipleImages(2);
                                },
                                2,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Divider(
                          color: Colors.red,
                        ),

                        //triple seater
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Specify the border color
                              width: 1.0, // Specify the border width
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              _buildSeaterInput(
                                  _roomData![4],
                                  tripleSeaterRoomsController,
                                  tripleSeaterAvailabeController,
                                  tripleSeaterPriceController,
                                  'Three'),
                              _buildspecialSeaterInput(
                                  tripleSeaterSpecialCheckbox,
                                  _roomData![5],
                                  'Three',
                                  tripleSeaterSpecialRoomsController,
                                  tripleSeaterSpecialAvailabeController,
                                  tripleSeaterSpecialPriceController),
                              _buildImageSelection(
                                _tripleSeaterImages,
                                () async {
                                  await _getSingleImage(3);
                                },
                                () async {
                                  await _getMultipleImages(3);
                                },
                                3,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Divider(
                          color: Colors.red,
                        ),

                        //four seater
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey, // Specify the border color
                              width: 1.0, // Specify the border width
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              _buildSeaterInput(
                                  _roomData![6],
                                  fourSeaterRoomsController,
                                  fourSeaterAvailabeController,
                                  fourSeaterPriceController,
                                  'Four'),
                              // _buildspecialSeaterInput(
                              //     fourSeaterSpecialCheckbox,
                              //     'Four Seater with bathroom', //Data not found through API
                              //     'Four',
                              //     fourSeaterSpecialRoomsController,
                              //     fourSeaterSpecialAvailabeController,
                              //     fourSeaterSpecialPriceController),
                              _buildImageSelection(
                                _fourSeaterImages,
                                () async {
                                  await _getSingleImage(4);
                                },
                                () async {
                                  await _getMultipleImages(4);
                                },
                                4,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all<Size>(
                                const Size(200.0, 35.0),
                              ),
                            ),
                            onPressed: _sendDataToServer,
                            child: const Text('Send Room Data'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildSeaterInput(
      String title,
      TextEditingController roomsController,
      TextEditingController availableController,
      TextEditingController priceController,
      String seaterType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, color: Colors.black87),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: TextField(
                controller: roomsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Total Rooms',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: 80,
              child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Price',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: TextField(
                controller: availableController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Available',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 1.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageSelection(
    List<XFile>? images,
    VoidCallback takePhoto,
    VoidCallback uploadImages,
    int seaterType,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
            children: [
              ElevatedButton(
                onPressed: takePhoto,
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(150.0, 35.0),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.camera_outlined),
                    Text('Take a Photo'),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              ElevatedButton(
                onPressed: uploadImages,
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(
                        150.0, 35.0), // Set the width and height of the button
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.image_outlined),
                    Text('Upload Images'),
                  ],
                ),
              ),
            ],
          ),
          // const SizedBox(height: 20),
          Center(
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                if (images != null)
                  for (int i = 0; i < images.length; i++)
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.file(
                            File(images[i].path),
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
                            onPressed: () => _deleteImage(i, seaterType),
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildspecialSeaterInput(
      ValueNotifier<bool> checkboxNotifier,
      String title,
      String seaterType,
      TextEditingController roomsController,
      TextEditingController availableController,
      TextEditingController priceController) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(children: [
        ValueListenableBuilder<bool>(
          valueListenable: checkboxNotifier,
          builder: (context, value, child) {
            return CheckboxListTile(
              dense: true,
              // checkColor: Colors.orange,
              activeColor: GlobalVariables.mainColor,

              title: const Text('Attached Washrooms available?'),
              value: value,
              onChanged: (bool? newValue) {
                checkboxNotifier.value = newValue ?? false;
              },
            );
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: checkboxNotifier,
          builder: (context, value, child) {
            if (value) {
              return _buildSeaterInput(title, roomsController,
                  availableController, priceController, seaterType);
            } else {
              return const SizedBox
                  .shrink(); // Return an empty widget when not needed
            }
          },
        ),
      ]),
    );
  }

  Future<void> _sendDataToServer() async {
    try {
      List<String> singleImagePaths =
          _singleSeaterImages!.map((image) => image.path).toList();
      List<String> doubleImagePaths =
          _doubleSeaterImages!.map((image) => image.path).toList();
      List<String> tripleImagePaths =
          _tripleSeaterImages!.map((image) => image.path).toList();
      List<String> fourImagePaths =
          _fourSeaterImages!.map((image) => image.path).toList();

      List<String> singleBase64Images = [];
      List<String> singleImagesExtensions = [];

      for (String imagePath in singleImagePaths) {
        List<int> imageBytes = File(imagePath).readAsBytesSync();

        String base64Image = base64Encode(imageBytes);

        singleBase64Images.add(base64Image);
        singleImagesExtensions.add(path.extension(imagePath));
      }
      List<String> doubleBase64Images = [];
      List<String> doubleImagesExtensions = [];

      for (String imagePath in doubleImagePaths) {
        List<int> imageBytes = File(imagePath).readAsBytesSync();

        String base64Image = base64Encode(imageBytes);

        doubleBase64Images.add(base64Image);
        doubleImagesExtensions.add(path.extension(imagePath));
      }
      List<String> tripleBase64Images = [];
      List<String> tripleImagesExtensions = [];

      for (String imagePath in tripleImagePaths) {
        List<int> imageBytes = File(imagePath).readAsBytesSync();

        String base64Image = base64Encode(imageBytes);

        tripleBase64Images.add(base64Image);
        tripleImagesExtensions.add(path.extension(imagePath));
      }
      List<String> fourBase64Images = [];
      List<String> fourImagesExtensions = [];

      for (String imagePath in fourImagePaths) {
        List<int> imageBytes = File(imagePath).readAsBytesSync();

        String base64Image = base64Encode(imageBytes);

        fourBase64Images.add(base64Image);
        fourImagesExtensions.add(path.extension(imagePath));
      }
      // Prepare room data
      List<Map<String, dynamic>> roomDataList = [
        _prepareRoomData(
          'One',
          singleSeaterRoomsController.text,
          singleSeaterAvailabeController.text,
          singleSeaterPriceController.text,
          singleBase64Images,
          singleImagesExtensions,
        ),
        _prepareRoomData(
          'Two',
          doubleSeaterRoomsController.text,
          doubleSeaterAvailabeController.text,
          doubleSeaterPriceController.text,
          doubleBase64Images,
          doubleImagesExtensions,
        ),
        _prepareRoomData(
          'Three',
          tripleSeaterRoomsController.text,
          tripleSeaterAvailabeController.text,
          tripleSeaterPriceController.text,
          tripleBase64Images,
          tripleImagesExtensions,
        ),
        _prepareRoomData(
          'Four',
          fourSeaterRoomsController.text,
          fourSeaterAvailabeController.text,
          fourSeaterPriceController.text,
          fourBase64Images,
          fourImagesExtensions,
        ),
      ];

      for (var roomData in roomDataList) {
        roomData['hostel_id'] = widget.hid;
      }

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FacilityMain()));

      // Make HTTP post request
      final response = await http.post(
        Uri.parse('$uri/inserthostelseaterinfo.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(roomDataList),
      );

      if (response.statusCode == 201) {
        print('Data sent successfully');
        print(response.body);
      } else {
        print(
            'Failed to send data to server. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending data to server: $e');
      // Handle the error
    }
  }

  Map<String, dynamic> _prepareRoomData(
    String type,
    String rooms,
    String price,
    String available,
    List<String> images,
    List<String> imagesExtension,
  ) {
    List<String>? imageUrls = images.map((image) => image).toList();
    return {
      'hostel_room_seater': type,
      'total': int.parse(rooms),
      'available': int.parse(available),
      'price': double.parse(price),
      'images': imageUrls,
      'imagesExtension': imagesExtension,
    };
  }
}
