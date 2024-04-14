import '../models/filter.dart';
import 'filter_actions.dart';

final Set<Filter> filters = {
  Filter(
      name: "Registration Type",
      selectedValue: null,
      filterItems: {
        FilterType.registeredForDrive: "Registered Drives",
        FilterType.unregisteredForDrive: "Unregistered Drives",
      },
      clearType: FilterType.clearRegisterType),
  Filter(
      name: "Drive Type",
      selectedValue: null,
      filterItems: {
        FilterType.onlineDriveType: "Online",
        FilterType.offlineDriveType: "On Campus",
        FilterType.hybridDriveType: "Hybrid"
      },
      clearType: FilterType.clearDriveType)
};
