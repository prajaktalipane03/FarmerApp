import 'package:get/get.dart';
class TabIndexController extends  GetxController{
RxInt _tabindex = 0.obs;
int get tabIndex => _tabindex.value;
set settabIndex(int newValue){
  _tabindex.value=newValue;
}
}