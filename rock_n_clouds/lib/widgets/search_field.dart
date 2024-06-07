import 'package:flutter/material.dart';
import 'package:rock_n_clouds/i18n/text_data.dart';
import 'package:rock_n_clouds/widgets/custom_form_field.dart';

class SearchField extends StatelessWidget {
  final TextEditingController searchController;
  final Function() onSubmit;
  const SearchField({
    super.key,
    required this.searchController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomFormField(
          label: TextData.searchByCity,
          controller: searchController,
          onSubmit: onSubmit,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            TextData.searchFieldTip,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        )
      ],
    );
  }
}
