import 'package:amazonclone/common/widgets/custom_button.dart';
import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/accounts/widgets/single_product.dart';
import 'package:amazonclone/features/admin/services/admin_services.dart';
import 'package:amazonclone/features/search/screens/search_screen.dart';
import 'package:amazonclone/models/order.dart';
import 'package:amazonclone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetails({super.key, required this.order});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int currentsteps = 0;
  final AdminServices adminServices = AdminServices();

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentsteps = widget.order.status;
  }

  //only for admin
  void changeOrderStatus(int status)  {
     adminServices.changeOrderStatus(
      context: context,
      status: status + 1,
      order: widget.order,
      onSuccess: () {
        setState(
          () {
            currentsteps += 1;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    height: 42,
                    margin: EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.only(top: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide: BorderSide.none),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 1)),
                            hintText: "Search Amazon.in",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17)),
                      ),
                    )),
              ),
              Container(
                color: Colors.transparent,
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "View Order Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Order date:      ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}"),
                    Text("Order Id:          ${widget.order.id}"),
                    Text("Order Total:     \$${widget.order.totalPrice}"),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Purchase Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            width: 120,
                            height: 120,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.order.products[i].name}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Text("Qty: ${widget.order.quantity[i]}"),
                              ],
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Tracking",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Stepper(
                  currentStep: currentsteps,
                  controlsBuilder: (context, details) {
                    if (user.type == "admin") {
                      return CustomButton(
                        text: "Done",
                        onTap: () => changeOrderStatus(details.currentStep),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                  steps: [
                    Step(
                        title: Text("Pending"),
                        content: Text(
                          "Your order is yet to be deliveried",
                        ),
                        isActive: currentsteps > 0,
                        state: currentsteps > 0
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: Text("Completed"),
                        content: Text(
                          "Your order has been delivered,You are yet to sign.",
                        ),
                        isActive: currentsteps > 1,
                        state: currentsteps > 1
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: Text("Recieved"),
                        content: Text(
                          "Your order is has been delivered and signed by you",
                        ),
                        isActive: currentsteps > 2,
                        state: currentsteps > 2
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: Text("Deliveried!"),
                        content: Text(
                          "Your order is has been delivered and signed by you!",
                        ),
                        isActive: currentsteps >= 3,
                        state: currentsteps >= 3
                            ? StepState.complete
                            : StepState.indexed),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
