import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letsgohome/controller/schoolController.dart';
import 'package:letsgohome/models/add_student.dart';
import 'package:letsgohome/screens/students_page.dart';
import 'package:letsgohome/utils/add_student_api.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../component/customTextFieldWith_DropDown.dart';
import '../component/fordays.dart';
import '../component/textformfield_ns.dart';
import '../controller/dropdowncontroller.dart';

class AddStudentPage extends StatefulWidget {
  final String studentCode;
  const AddStudentPage({Key? key, required this.studentCode}) : super(key: key);

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final AddStudentPost addStudentPost = AddStudentPost();
  List<String> selectedDays = [];
  List<String> alarm = ["On", "OFF"];
  String? selectedValue = "On";
  List<String> allDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController centerController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController outTimeController = TextEditingController();
  final TextEditingController commingTimeController = TextEditingController();
  final TextEditingController arriveController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController illnessTypeController = TextEditingController();
  final TextEditingController symptomsController = TextEditingController();
  final TextEditingController firstAidController = TextEditingController();
  final TextEditingController commingAlarmController = TextEditingController();
  final TextEditingController outAlarmController = TextEditingController();
  final TextEditingController daysController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController schoolIdController = TextEditingController();
  final SchoolController schoolController = Get.put(SchoolController());
  final DropdownController dropdownController = Get.put(DropdownController());
  TimeOfDay commingTime = TimeOfDay.now();
  TimeOfDay time = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  bool outAlarm = false;
  bool commingAlarm = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    schoolController.fetchSchoolData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 129,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF5C955D),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const Positioned(
                top: 80,
                left: 27,
                child: Text(
                  "Add New Student",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(30),
                children: [
                  const SizedBox(height: 10,),
                  CustomTextField(
                    prefixIcon: Icons.person_rounded,
                    labelText: "Full Name",
                    controller: fullnameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the full name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15,),
                  Obx(() => Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2.0),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    child: CustomDropdownButton(
                      items: convertSchoolControllerToList(schoolController.schoolData),
                      selectedItemId: dropdownController.selectedItemId.value,
                      onChanged: (value) {
                        if (value != null) {
                          dropdownController.setSelectedItemId(value);
                        }
                      },
                    ),
                  )),
                  SizedBox(height: 15,),
                  Obx(() => CustomTextFieldDrop1(
                    prefixIcon: Icons.leaderboard,
                    selectedOption: schoolController.levelController.value,
                    labelText: "Level",
                    onChanged: schoolController.handleDropdownChangeLevel,
                    options: <String>['Elementary', 'Middle', 'High']
                        .map((String value) => {'id': value, 'name': value})
                        .toList(),
                    controller: schoolController,
                  )),
                  CustomTextField(
                    prefixIcon: Icons.add,
                    labelText: "Branch",
                    controller: branchController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the branch';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(Icons.calendar_today, color: Colors.black), // Add your desired prefix icon here
                        ),
                        Expanded(
                          child: MultiSelectDialogField(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            buttonText: Text(
                              "Select Days",
                              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                            ),
                            title: Text(
                              "Days",
                              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                            ),
                            items: allDays.map((day) => MultiSelectItem(day, day)).toList(),
                            listType: MultiSelectListType.LIST,
                            onConfirm: (values) {
                              setState(() {
                                selectedDays = List<String>.from(values);
                              });
                            },
                            initialValue: selectedDays,
                            itemsTextStyle: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  CustomTextField(
                    prefixIcon: Icons.business_rounded,
                    labelText: "Nationality",
                    controller: nationalityController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the nationality';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),
                  CustomTextField(
                    prefixIcon: Icons.height_outlined,
                    labelText: "Height",
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the height';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  CustomTextField(
                    prefixIcon: Icons.line_weight,
                    labelText: "Weight",
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the weight';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  CustomTextField(
                    prefixIcon: Icons.sick_rounded,
                    labelText: "Illness Type",
                    controller: illnessTypeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the illness type';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  CustomTextField(
                    prefixIcon: Icons.line_weight,
                    labelText: "Symptoms",
                    controller: symptomsController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the symptoms';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10,),
                  CustomTextField(
                    prefixIcon: Icons.line_weight,
                    labelText: "First Aid",
                    controller: firstAidController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the first aid details';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),
                  CustomTextField(
                    prefixIcon: Icons.add_business,
                    labelText: "Health Center",
                    controller: centerController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the health center';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    padding: EdgeInsets.all(8),
                    width: 250,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(),
                    ),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final DateTime? day = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (day != null) {
                              setState(() {
                                selectedDate = day;
                              });
                            }
                          },
                          child: Text("Define BirthDay", style: TextStyle(color: Colors.black54, fontSize: 14),),
                        ),
                        Spacer(),
                        Text(" ${selectedDate.toLocal().toString().split(' ')[0]}"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    padding: EdgeInsets.all(8),
                    width: 250,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(),
                    ),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final TimeOfDay? commingTime1 = await showTimePicker(
                              context: context,
                              initialTime: commingTime,
                              initialEntryMode: TimePickerEntryMode.input,
                            );
                            if (commingTime1 != null) {
                              setState(() {
                                commingTime = commingTime1;
                              });
                            }
                          },
                          child: Text("Select CommingTime ", style: TextStyle(color: Colors.black54, fontSize: 14),),
                        ),
                        Spacer(),
                        Text(" ${commingTime.format(context)}"),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  CustomTextFieldDrop2(
                    prefixIcon: Icons.alarm,
                    labelText: "Comming Alarm",
                    selectedOption: schoolController.commingAlarmController.value,
                    onChanged: schoolController.handleDropdownChangeComming,
                    options: <String>['OFF', 'On']
                        .map((String value) => {'id': value, 'name': value})
                        .toList(), controller: schoolController,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 250,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(),
                    ),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final TimeOfDay? timeofDay = await showTimePicker(
                              context: context,
                              initialTime: time,
                              initialEntryMode: TimePickerEntryMode.input,
                            );
                            if (timeofDay != null) {
                              setState(() {
                                time = timeofDay;
                              });
                            }
                          },
                          child: Text("Select OutTime ", style: TextStyle(color: Colors.black54, fontSize: 14),),
                        ),
                        Spacer(),
                        Text(" ${time.format(context)}"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  CustomTextFieldDrop3(
                    prefixIcon: Icons.alarm,
                    labelText: "Out Alarm",
                    selectedOption: schoolController.outAlarmController.value,
                    onChanged: schoolController.handleDropdownChangeOut,
                    options: <String>['OFF', 'On']
                        .map((String value) => {'id': value, 'name': value})
                        .toList(), controller: schoolController,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF5C955D),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          bool success = await saveStudent(widget.studentCode);
                          if (success) {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => StudentsPage()));
                          }
                        }
                      },
                      child: const Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void handleDropdownChangeLevel(String? levelselectedValue) {
    levelController.text = levelselectedValue!;
    print('level Selected value: $levelselectedValue');
  }

  List<Map<String, String>> convertSchoolControllerToList(RxList schoolData) {
    List<Map<String, String>> resultList = [];
    for (var element in schoolData) {
      resultList.add({
        'id': element['id'].toString(),
        'name': element['name'].toString(),
      });
    }
    return resultList;
  }

  Future<bool> saveStudent([String? studentCode]) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? parentId = prefs.getString('Parent_id');

    if (selectedDate.isAfter(DateTime.now())) {
      throw "The birthdate field must be a date before today.";
    }

    if (dropdownController.selectedItemId.value!.isEmpty || schoolController.levelController.value.isEmpty) {
      throw "School and level must be selected.";
    }

    final outAlarmValue = (schoolController.outAlarmController.value == 'On') ? true : false;
    final commingAlarmValue = (schoolController.commingAlarmController.value == 'On') ? true : false;

    AddStudentModel std = AddStudentModel(
      id: parentId!,
      student_code: widget.studentCode,
      school_id: dropdownController.selectedItemId.value ?? '',
      name: fullnameController.text,
      level: schoolController.levelController.value,
      branch: branchController.text,
      birthdate: selectedDate.toLocal().toString().split(' ')[0],
      nationality: nationalityController.text,
      days: selectedDays,
      out_time: time.format(context),
      comming_time: commingTime.format(context),
      out_alarm: outAlarmValue,
      comming_alarm: commingAlarmValue,
      h_center: centerController.text,
      height: heightController.text,
      weight: weightController.text,
      illnes_type: illnessTypeController.text,
      symptoms: symptomsController.text,
      first_aid: firstAidController.text,
    );

    await addStudentPost.addStudent(std);
    return true;
  }
}
