import 'package:flutter/material.dart';
import 'package:hostel_nepal/common/price_text_form_field.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key, required this.title});

  final String title;

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/room.jpg'),
                const HostelList(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceTextFormField(),
                    Text(
                      'TO',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    PriceTextFormField(),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HostelList extends StatefulWidget {
  const HostelList({super.key});

  @override
  State<HostelList> createState() => _HostelListState();
}

class _HostelListState extends State<HostelList> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HostelFacility(
          label: 'Accommodiation',
        ),
        HostelFacility(
          label: 'Bathrooms',
        ),
        HostelFacility(
          label: 'Common Area',
        ),
        HostelFacility(
          label: 'Kitchen and Dining Area',
        ),
        HostelFacility(
          label: 'Laundry Facilites',
        ),
        HostelFacility(
          label: 'Wi-Fi',
        ),
        HostelFacility(
          label: 'Security',
        ),
        HostelFacility(
          label: 'Information Desk',
        ),
        HostelFacility(
          label: 'Events and Activites',
        ),
        HostelFacility(
          label: 'Additional Services',
        ),
      ],
    );
  }
}

class HostelFacility extends StatefulWidget {
  const HostelFacility({super.key, required this.label});

  final String label;

  @override
  State<HostelFacility> createState() => _HostelFacilityState();
}

class _HostelFacilityState extends State<HostelFacility> {
  bool? _value = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: _value,
            onChanged: (newValue) {
              setState(() {
                _value = newValue;
              });
            }),
        Text(widget.label),
      ],
    );
  }
}
