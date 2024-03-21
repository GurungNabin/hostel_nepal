import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hostel_nepal/common/error.dart';
import 'package:hostel_nepal/features/hostel_inforamtion/hostel_model/hostel_model.dart';
import 'package:hostel_nepal/features/hostel_inforamtion/hostel_repo/hostel_repo.dart';
import 'package:hostel_nepal/room_main.dart';
import 'package:image_picker/image_picker.dart';

class HostelMain extends StatefulWidget {
  const HostelMain({super.key});

  @override
  State<HostelMain> createState() => _HostelMainState();
}

class _HostelMainState extends State<HostelMain> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _imageController = TextEditingController();

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
        imageQuality: 50,
        maxWidth: 200,
        maxHeight: 200,
      );
      if (image != null) {
        setState(() {
          _images = [image]; // Set the image
        });
      }
    } catch (e) {
      // Handle error
      ErrorHandler.handleError(e);
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
    final email = _emailController.text;
    final phone = _phoneController.text;
    final image = _imageController.toString();

    // Create a HostelModel object
    final hostelData = HostelModel(
      name: name,
      address: address,
      email: email,
      phone: phone,
      images:  image,
    );

    // Send data to API
    HostelApi.createHostelInfo(hostelData).then((_) {
      // Navigate to the next page after successful submission
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RoomMain()),
      );
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hostel Form'),
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

                //hostel address
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Hostel Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                //Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the email';
                    }
                    // You can add more validation for email format here if needed
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                //Phone
                TextFormField(
                  controller: _phoneController,
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
                    // You can add more validation for phone number format here if needed
                    return null;
                  },
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
