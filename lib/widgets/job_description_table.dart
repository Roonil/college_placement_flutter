import '../models/company.dart';
import 'package:flutter/material.dart';

class JobDescriptionTable extends StatelessWidget {
  final Company company;
  const JobDescriptionTable({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final TextStyle tableHeadingTextStyle =
        TextStyle(color: Theme.of(context).colorScheme.onPrimary);
    final Color headingCellColor = Theme.of(context).colorScheme.primary;
    //TODO: Make table scrollable horizontally (Color misaligns on smaller widths)
    return Table(
      border: TableBorder.all(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.onPrimaryContainer),
      children: [
        TableRow(children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10)),
            child: Container(
              color: headingCellColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Eligibility Criteria",
                  style: tableHeadingTextStyle,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(company.eligibilityCriteria),
          )
        ]),
        TableRow(children: [
          Container(
            color: headingCellColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Type of Drive",
                style: tableHeadingTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(company.driveType),
          )
        ]),
        TableRow(children: [
          Container(
            color: headingCellColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Date of Drive",
                style: tableHeadingTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(company.dateOfDrive),
          )
        ]),
        TableRow(children: [
          Container(
            color: headingCellColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Job Profile",
                style: tableHeadingTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(company.jobProfile),
          ),
        ]),
        TableRow(children: [
          Container(
            color: headingCellColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Job Location",
                style: tableHeadingTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(company.location),
          )
        ]),
        TableRow(children: [
          Container(
            color: headingCellColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Pay Package",
                style: tableHeadingTextStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(company.package),
          )
        ]),
        TableRow(children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(10)),
            child: Container(
              color: headingCellColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Bond",
                  style: tableHeadingTextStyle,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(company.bond),
          ),
        ]),
      ],
    );
  }
}
