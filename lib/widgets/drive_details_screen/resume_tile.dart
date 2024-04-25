import 'package:flutter/material.dart';

class ResumeTile extends StatelessWidget {
  final String name;
  const ResumeTile({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Radio(
                value: 2,
                groupValue: 1,
                onChanged: (value) {},
              ),
            ),
            Flexible(
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Icon(
                              Icons.file_present,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Expanded(
                              child: Text(
                                name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.cloud_upload_outlined),
                              ),
                            ),
                            Flexible(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete_outline)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
