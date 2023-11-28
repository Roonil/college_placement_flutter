import 'package:flutter/material.dart';

class DriveTileName extends StatelessWidget {
  final String imageURL, companyName, driveType, companyID;
  const DriveTileName({
    required this.companyName,
    required this.driveType,
    required this.imageURL,
    required this.companyID,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Hero(
            tag: companyID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                width: 80,
                height: 65,
                image: AssetImage(imageURL),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: Text(companyName)),
                Flexible(child: Text(driveType))
              ],
            ),
          ),
        )
      ],
    );
  }
}
