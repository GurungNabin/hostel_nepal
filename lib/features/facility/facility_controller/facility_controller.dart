import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostel_nepal/features/facility/model/facility_model.dart';
import 'package:hostel_nepal/features/facility/repository/facility_repo.dart';

final facilityControllerProvider = Provider((ref) {
  final facilityRepository = ref.read(facilityRepositoryProvider);
  return FacilityController(facilityRepository: facilityRepository, ref: ref);
});

final facilityDataProvider = FutureProvider((ref) {
  final facilityController = ref.watch(facilityControllerProvider);
  return facilityController.getFacility();
});

class FacilityController {
  final FacilityService facilityRepository;
  final ProviderRef ref;

  FacilityController({required this.facilityRepository, required this.ref});

  Future<List<FacilityModel>> getFacility() {
    return facilityRepository.getFacility();
  }
}
