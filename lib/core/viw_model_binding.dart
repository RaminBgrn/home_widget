import 'package:get/get.dart';
import 'package:widget_home/home/viewModel/home_view_model.dart';
import 'package:widget_home/service/request_service.dart';

class ViewModelBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      HomeViewModel(RequestService()),
    );
  }
}
