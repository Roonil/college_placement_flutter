import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_events.dart';
import 'register_states.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc()
      : super(InitialState(
            isLoading: false,
            authError: null,
            personalDetailsEdited: false,
            contactDetailsEdited: false,
            intermediateDetailsEdited: false,
            matricDetailsEdited: false,
            undergraduateDetailsEdited: false));
}
