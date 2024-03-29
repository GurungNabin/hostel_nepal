import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CountryTextField extends StatefulWidget {
  final TextEditingController phoneController;

  const CountryTextField({
    super.key,
    required this.phoneController,
  });

  @override
  State<CountryTextField> createState() => _CountryTextFieldState();
}

class _CountryTextFieldState extends State<CountryTextField> {
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: widget.phoneController,
      decoration: const InputDecoration(
        hintText: 'Phone Number',
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      initialCountryCode: 'NP',
      showDropdownIcon: false,
    );
  }
}