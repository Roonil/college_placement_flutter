import 'package:flutter/material.dart';

import '../../models/company.dart';
import '../../screens/drive_details_screen.dart';
import '../drive_tile_name.dart';
import './roles_chip_builder.dart';

class DriveTile extends StatelessWidget {
  final Company company;
  const DriveTile({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DriveDetailsScreen(company: company),
        )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 8,
                      children: [
                        DriveTileName(
                            companyID: company.driveID,
                            companyName: company.name,
                            driveType: company.driveType,
                            imageURL: company.imageURL),
                        Chip(
                            color: MaterialStatePropertyAll(
                                company.hasRegistered
                                    ? Colors.green
                                    : Colors.red),
                            label: Text(company.hasRegistered
                                ? "Registered"
                                : "Not Registered"))
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: RolesChipBuilder(
                  roles: company.roles,
                ),
              ),
              const Divider(
                height: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child:
                          Text("Registrations: ${company.numRegistrations}")),
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.timelapse),
                        ),
                        Flexible(child: Text("${company.timeLeft} left")),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
