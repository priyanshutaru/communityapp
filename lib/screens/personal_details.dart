import 'package:communityapp/screens/Stepper/basic_details.dart';
import 'package:flutter/material.dart';

class Personalinfo extends StatefulWidget {
  const Personalinfo({Key? key}) : super(key: key);

  @override
  State<Personalinfo> createState() => _PersonalinfoState();
}

class _PersonalinfoState extends State<Personalinfo> {
  // Initial Selected Value
  String dropdownvalue = 'Merital Status';
  String dropdownvalue1 = 'Native Sakha';

  // List of items in our dropdown menu
  var items = [
    'Merital Status',
    'Item 5',
    'Item 8',
    'Item 22',
    'Item 7878',
  ];
  var items1 = [
    'Native Sakha',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 868,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  color: Colors.brown[100],
                  child: Column(children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Form(
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 120, bottom: 20),
                              child: Text("Personal Details",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )),
                            ),
                            Column(
                              children: [
                                _buildTextField(
                                    hintText: "First Name",
                                    prefixicon: Icon(Icons.person)),
                                _buildTextField(
                                    hintText: "Middle Name",
                                    prefixicon: Icon(Icons.person)),
                                _buildTextField(
                                    hintText: "Last Name",
                                    prefixicon: Icon(Icons.person)),
                                _buildTextField(
                                    hintText: "DOB (DD/MM/YYYY)",
                                    prefixicon: Icon(Icons.calendar_month)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3, bottom: 3),
                              child: Container(
                                height: 50,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .9,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: dropdownvalue,
                                    icon: const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30),
                                          child: Text(
                                            items,
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3, bottom: 3),
                              child: Container(
                                height: 50,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .9,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: dropdownvalue1,
                                    icon: const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    items: items1.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30),
                                          child: Text(
                                            items,
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            _buildTextField(
                                hintText: "Password",
                                prefixicon: Icon(Icons.lock),
                                suffix: Icon(Icons.remove_red_eye)),
                            _buildTextField(
                                hintText: "Conform Password",
                                prefixicon: Icon(Icons.lock),
                                suffix: Icon(Icons.remove_red_eye)),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                        "Note: The profile go for approval to current Sakha\n   Current & Native Sakha can be the same as well",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black38)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("I'm agree with the Term & Conditions")],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 45,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [
                              Colors.blue,
                              Colors.white,
                            ],
                          )),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Center(
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white),
                              ))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an Account ?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>BasicDetail()));
                            },
                            child: const Text("Login"))
                      ],
                    )
                  ]),
                ),
              ),
            ],
          )),
    );
  }


  Widget _buildTextField({var hintText, prefixicon, suffix, lable}) {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        //Type TextField
        height: 50,
        width: MediaQuery
            .of(context)
            .size
            .width * .9,

        child: TextFormField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              border: InputBorder.none,
              hintText: hintText,
              prefixIcon: prefixicon,
              suffixIcon: suffix // pass the hint text parameter here
          ),
        ),
      ),
    );
  }
}
