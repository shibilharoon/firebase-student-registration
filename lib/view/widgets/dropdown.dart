import 'package:firebase_project/controller/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDown extends StatelessWidget {
  const DropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (context, provider, child) => DropdownButton<String?>(
          value: provider.selectedGroups,
          items: provider.courses.map((grp) {
            return DropdownMenuItem<String>(
                value: grp,
                child: Text(
                  grp,
                  style: TextStyle(color: Colors.red),
                ));
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              provider.dropdownValuechange(newValue);
            }
          }),
    );
  }
}
