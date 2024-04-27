import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../bloc/details_blocs/contact_details_events.dart';
import '../../../bloc/login_bloc.dart';
import '../../../bloc/login_bloc_states.dart';
import '../../../models/contact_details.dart';
import './contact_details_inputs.dart';
import '../../../bloc/details_blocs/contact_details_bloc.dart';
import '../../../bloc/details_blocs/contact_details_states.dart';
import '../details_subtitle.dart';

class ContactDetailsCard extends StatefulWidget {
  const ContactDetailsCard(
      {super.key,
      required this.expansionTileController,
      required this.onEdited});
  final ExpansionTileController expansionTileController;

  final Function(bool) onEdited;
  @override
  State<ContactDetailsCard> createState() => _ContactDetailsCardState();
}

class _ContactDetailsCardState extends State<ContactDetailsCard> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressLine1Controller = TextEditingController();
  final TextEditingController addressLine2Controller = TextEditingController();

  String? previousEmailAddress,
      previousPhoneNumber,
      previousAddressLine2,
      previousAddressLine1;

  bool shouldShowButtons = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactDetailsBloc, ContactDetailsState>(
      listenWhen: (previous, current) =>
          (previous is FetchingContactDetailsState &&
              current is FetchedContactDetailsState) ||
          (previous is UpdatingContactDetailsState &&
              current is UpdatedContactDetailsState) ||
          (previous is FetchingContactDetailsState &&
              current is ContactDetailsFetchFailedState) ||
          (previous is UpdatingContactDetailsState &&
              current is ContactDetailsUpdateFailedState),
      listener: (context, state) {
        if (state is ContactDetailsFetchFailedState ||
            state is ContactDetailsUpdateFailedState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.authError.toString().split(": ")[1])));
        } else if (state is FetchedContactDetailsState) {
          emailAddressController.text = state.contactDetails.emailAddress;
          phoneNumberController.text = state.contactDetails.phoneNumber;
          addressLine1Controller.text = state.contactDetails.currentAddress;
          addressLine2Controller.text = state.contactDetails.permanentAddress;
          previousEmailAddress = emailAddressController.text.trim();
          previousPhoneNumber = phoneNumberController.text.trim();
          previousAddressLine2 = addressLine2Controller.text.trim();
          previousAddressLine1 = addressLine1Controller.text.trim();
        } else if (state is UpdatedContactDetailsState) {
          previousEmailAddress = emailAddressController.text.trim();
          previousPhoneNumber = phoneNumberController.text.trim();
          previousAddressLine2 = addressLine2Controller.text.trim();
          previousAddressLine1 = addressLine1Controller.text.trim();
          widget.onEdited(false);
        }
      },
      buildWhen: (previous, current) =>
          (current is FetchedContactDetailsState ||
              current is ContactDetailsFetchFailedState ||
              current is FetchingContactDetailsState ||
              current is UpdatedContactDetailsState ||
              current is UpdatingContactDetailsState ||
              current is ContactDetailsUpdateFailedState) &&
          previous != current,
      builder: (context, state) {
        bool isEdited =
            previousEmailAddress != emailAddressController.text.trim() ||
                previousPhoneNumber != phoneNumberController.text.trim() ||
                previousAddressLine2 != addressLine2Controller.text.trim() ||
                previousAddressLine1 != addressLine1Controller.text.trim();

        return Card(
          elevation: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Form(
              key: formKey,
              child: Card(
                margin: EdgeInsets.zero,
                child: ExpansionTile(
                  controller: widget.expansionTileController,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onExpansionChanged: (value) => setState(() {
                    shouldShowButtons = value;
                  }),
                  title: Text(
                    "Contact Details",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: DetailsSubtitle(
                    hasFetched: state is FetchedContactDetailsState,
                    hasUpdated: state is UpdatedContactDetailsState,
                    isFetching: state is FetchingContactDetailsState,
                    isUpdating: state is UpdatingContactDetailsState,
                    isEdited: isEdited,
                    onSaved: () {
                      formKey.currentState!.validate() && isEdited
                          ? BlocProvider.of<ContactDetailsBloc>(context).add(
                              UpdateContactDetailsEvent(
                                  studentID:
                                      (BlocProvider.of<LoginBloc>(context).state
                                              as LoggedInState)
                                          .student
                                          .id,
                                  token: (BlocProvider.of<LoginBloc>(context)
                                          .state as LoggedInState)
                                      .student
                                      .token,
                                  contactDetails: ContactDetails(
                                    emailAddress:
                                        emailAddressController.text.trim(),
                                    phoneNumber:
                                        phoneNumberController.text.trim(),
                                    permanentAddress:
                                        addressLine2Controller.text.trim(),
                                    currentAddress:
                                        addressLine1Controller.text.trim(),
                                  )))
                          : null;
                    },
                    onUndo: () {
                      emailAddressController.text = previousEmailAddress ?? "";
                      phoneNumberController.text = previousPhoneNumber ?? "";
                      addressLine1Controller.text = previousAddressLine1 ?? "";
                      addressLine2Controller.text = previousAddressLine2 ?? "";
                      widget.onEdited(false);
                    },
                    shouldShowButtons: shouldShowButtons,
                  ),
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: state is FetchingContactDetailsState
                            ? Skeletonizer(
                                effect: ShimmerEffect(
                                    baseColor: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(.5)),
                                child: ContactDetailsInputs(
                                  emailAddressController:
                                      emailAddressController,
                                  phoneNumberController: phoneNumberController,
                                  addressLine1Controller:
                                      addressLine1Controller,
                                  addressLine2Controller:
                                      addressLine2Controller,
                                  isEdited: false,
                                  inputsEnabled: true,
                                  formKey: formKey,
                                  onChanged: (_) {},
                                ))
                            : ContactDetailsInputs(
                                emailAddressController: emailAddressController,
                                phoneNumberController: phoneNumberController,
                                addressLine1Controller: addressLine1Controller,
                                addressLine2Controller: addressLine2Controller,
                                isEdited: isEdited,
                                inputsEnabled:
                                    state is! UpdatingContactDetailsState,
                                formKey: formKey,
                                onChanged: (_) {
                                  isEdited = previousEmailAddress !=
                                          emailAddressController.text.trim() ||
                                      previousPhoneNumber !=
                                          phoneNumberController.text.trim() ||
                                      previousAddressLine2 !=
                                          addressLine2Controller.text.trim() ||
                                      previousAddressLine1 !=
                                          addressLine1Controller.text.trim();
                                  widget.onEdited(isEdited);
                                },
                              )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
