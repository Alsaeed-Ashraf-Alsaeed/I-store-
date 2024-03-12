import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_store/core/view_model/check_out_view_model/checkout_states.dart';

class CheckoutBloc extends Cubit<CheckoutStates>{
  CheckoutBloc() : super(CheckoutInitialStates());


}