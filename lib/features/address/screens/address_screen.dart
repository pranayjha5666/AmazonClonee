import 'package:amazonclone/common/widgets/custom_textfield.dart';
import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/constants/utils.dart';
import 'package:amazonclone/features/address/screens/payment_config.dart';
import 'package:amazonclone/features/address/services/address_services.dart';
import 'package:amazonclone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address";
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _adressFormKey = GlobalKey<FormState>();

  List<PaymentItem> paymentItems = [];
  String addressToBeUsed = "";


  final AddressServices addressServices=AddressServices();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  // void onGooglePayResult(res) {
  //   if(Provider.of<UserProvider>(context,listen: false).user.address.isEmpty){
  //     addressServices.saveUserAddress(context: context, address: addressToBeUsed);
  //
  //   }
  //
  //   addressServices.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.totalAmount));
  // }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if(isForm){
      if(_adressFormKey.currentState!.validate()){
        addressToBeUsed='${flatBuildingController.text},${areaController.text},${cityController.text}-${pincodeController.text}';
      }else{
        throw Exception("Please Enter All The Values!");
      }
    }
    else if(addressFromProvider.isNotEmpty){
      addressToBeUsed=addressFromProvider;
    }
    else{
      showSnackBar(context, 'Error');
    }
    if(Provider.of<UserProvider>(context,listen: false).user.address.isEmpty){
      addressServices.saveUserAddress(context: context, address: addressToBeUsed);
    }

    addressServices.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.totalAmount));
    print(addressToBeUsed);
    print(widget.totalAmount);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: "Total Amount",
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "OR",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              Form(
                key: _adressFormKey,
                child: Column(
                  children: [
                    CustomtextFormField(
                      controller: flatBuildingController,
                      hintText: "Flat, House no , Building",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomtextFormField(
                      controller: areaController,
                      hintText: "Area,Street",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomtextFormField(
                        controller: pincodeController, hintText: "Pincode"),
                    SizedBox(
                      height: 10,
                    ),
                    CustomtextFormField(
                        controller: cityController, hintText: "Town/City"),
                    SizedBox(
                      height: 10,
                    ),
                    GooglePayButton(
                      onPressed: () => payPressed(address),
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.only(top: 15.0),
                      paymentConfiguration:
                          PaymentConfiguration.fromJsonString(defaultGooglePay),
                      paymentItems: paymentItems,
                      type: GooglePayButtonType.buy,
                      theme: GooglePayButtonTheme.dark,
                      // onPaymentResult: onGooglePayResult,
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
