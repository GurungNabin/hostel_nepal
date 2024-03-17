import 'package:flutter/material.dart';

class PriceTextFormField extends StatelessWidget {
  const PriceTextFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: TextFormField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(
          labelText: 'Price',
          hintText: 'Enter the price',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter the price';
          }
          return null;
        },
        onSaved: (value) {
          double.parse(value!);
        },
      ),
    );
  }
}
