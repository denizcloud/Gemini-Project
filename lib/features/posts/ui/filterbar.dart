import 'package:flutter/material.dart';

class FilterBar extends StatefulWidget {
  const FilterBar({
    super.key,
    required this.options,
  });

  final Set<String> options;

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  Set<String> filters = <String>{};

  @override
  Widget build(BuildContext context) {
    return Wrap(
            spacing: 10.0,
            children: widget.options.map((String option) {
              return FilterChip(
                label: Text(option),
                selected: filters.contains(option),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      filters.add(option);
                    } else {
                      filters.remove(option);
                    }
                  });
                },
              );
            }).toList(),
          );
  }
}