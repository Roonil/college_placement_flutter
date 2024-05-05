import 'package:flutter/material.dart';

import '../../models/company.dart';
import '../../screens/drive_details_screen.dart';
import '../drive_tile_name.dart';
import '../roles_chip_builder.dart';

class DriveTile extends StatelessWidget {
  final Company company;
  const DriveTile({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
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
                            companyID: company.companyID.toString(),
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
                  selectedIdx: null,
                  onTap: null,
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
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: company.timeLeft < 0
                              ? const Icon(Icons.timer_off_outlined)
                              : const Icon(Icons.timelapse),
                        ),
                        Flexible(
                            child: company.timeLeft < 0
                                ? const Text("Expired")
                                : Text("${company.timeLeft}d left")),
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
