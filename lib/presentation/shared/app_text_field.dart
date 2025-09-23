import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final String title;
  final Function(String)? onChanged;

  const SearchTextField({super.key, required this.title, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.black54),
        hintText: title,
        hintStyle: const TextStyle(color: Colors.black54),
        filled: true,

        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
