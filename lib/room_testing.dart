import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class RoomDataInputPage extends StatefulWidget {
  const RoomDataInputPage({Key? key}) : super(key: key);

  @override
  State<RoomDataInputPage> createState() => _RoomDataInputPageState();
}

class _RoomDataInputPageState extends State<RoomDataInputPage> {
  TextEditingController singleSeaterRoomsController = TextEditingController();
  TextEditingController singleSeaterPriceController = TextEditingController();
  TextEditingController singleSeaterAvailabeController =
      TextEditingController();

  TextEditingController doubleSeaterRoomsController = TextEditingController();
  TextEditingController doubleSeaterPriceController = TextEditingController();
  TextEditingController doubleSeaterAvailabeController =
      TextEditingController();

  TextEditingController tripleSeaterRoomsController = TextEditingController();
  TextEditingController tripleSeaterPriceController = TextEditingController();
  TextEditingController tripleSeaterAvailabeController =
      TextEditingController();

  TextEditingController fourSeaterRoomsController = TextEditingController();
  TextEditingController fourSeaterPriceController = TextEditingController();
  TextEditingController fourSeaterAvailabeController = TextEditingController();

  List<XFile>? _singleSeaterImages = [];
  List<XFile>? _doubleSeaterImages = [];
  List<XFile>? _tripleSeaterImages = [];
  List<XFile>? _fourSeaterImages = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Room Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Column(
                  children: [
                    _buildSeaterInput(
                        'Single Seater',
                        singleSeaterRoomsController,
                        singleSeaterAvailabeController,
                        singleSeaterPriceController,
                        1),
                    _buildImageSelection(_singleSeaterImages, 1),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Column(
                  children: [
                    _buildSeaterInput(
                        'Double Seater',
                        doubleSeaterRoomsController,
                        doubleSeaterAvailabeController,
                        doubleSeaterPriceController,
                        2),
                    _buildImageSelection(_doubleSeaterImages, 2),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Column(
                  children: [
                    _buildSeaterInput(
                        'Triple Seater',
                        tripleSeaterRoomsController,
                        tripleSeaterAvailabeController,
                        tripleSeaterPriceController,
                        3),
                    _buildImageSelection(_tripleSeaterImages, 3),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Column(
                  children: [
                    _buildSeaterInput(
                        'Four Seater',
                        fourSeaterRoomsController,
                        fourSeaterAvailabeController,
                        fourSeaterPriceController,
                        4),
                    _buildImageSelection(_fourSeaterImages, 4),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Material(
                  child: ElevatedButton(
                      onPressed: _sendDataToServer,
                      child: const Text(' Send Room Data ')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeaterInput(
      String title,
      TextEditingController roomsController,
      TextEditingController availableController,
      TextEditingController priceController,
      int seaterType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 2,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: roomsController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  labelText: 'Total Rooms',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: TextField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: TextField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                controller: availableController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Available Room',
                    border: OutlineInputBorder(),
                    isDense: true),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageSelection(List<XFile>? images, int seaterType) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                borderRadius: BorderRadius.circular(10),
                borderOnForeground: true,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width / 2.5,
                  textColor: Colors.deepPurple,
                  onPressed: () => _getSingleImage(seaterType),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 0.6,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera, color: Colors.deepPurple),
                      SizedBox(width: 8),
                      Text('Take a Photo'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Material(
                borderRadius: BorderRadius.circular(10),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width / 2.5,
                  textColor: Colors.deepPurple,
                  onPressed: () => _getMultipleImages(seaterType),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 0.6,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, color: Colors.deepPurple),
                      SizedBox(width: 8),
                      Text('Upload Images'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
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

  Future<void> _sendDataToServer() async {
    // Prepare room data
    List<Map<String, dynamic>> roomDataList = [
      _prepareRoomData(singleSeaterRoomsController.text,
          singleSeaterPriceController.text, _singleSeaterImages),
      _prepareRoomData(doubleSeaterRoomsController.text,
          doubleSeaterPriceController.text, _doubleSeaterImages),
      _prepareRoomData(tripleSeaterRoomsController.text,
          tripleSeaterPriceController.text, _tripleSeaterImages),
      _prepareRoomData(fourSeaterRoomsController.text,
          fourSeaterPriceController.text, _fourSeaterImages),
    ];

    // Upload images and get image URLs
    List<String> imageUrls = [];
    for (List<XFile>? images in [
      _singleSeaterImages,
      _doubleSeaterImages,
      _tripleSeaterImages,
      _fourSeaterImages,
    ]) {
      List<String> urls = await _uploadImagesToServer(images);
      imageUrls.addAll(urls);
    }

    // Send room data and image URLs to the server
    // Call your API here and pass the room data and image URLs
    print('Room Data: $roomDataList');
    print('Image URLs: $imageUrls');
  }

  Map<String, dynamic> _prepareRoomData(
      String rooms, String price, List<XFile>? images) {
    return {
      'hostel_id': 1, // Assuming a fixed hostel ID for now
      'total': int.parse(rooms),
      'available': int.parse(rooms),
      'price': double.parse(price),
      'images': images?.map((image) => image.path).toList() ?? [],
    };
  }

  Future<List<String>> _uploadImagesToServer(List<XFile>? images) async {
    // Placeholder function for uploading images to server or cloud storage
    // In a real application, implement the logic to upload images and get image URLs
    // For demonstration purposes, returning a placeholder list of image URLs
    await Future.delayed(const Duration(seconds: 2)); // Simulate upload delay
    return images?.map((image) => image.path).toList() ?? [];
  }
}
