import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpic_app/cubit/localization_cubit.dart';
import 'package:fpic_app/data/meta.dart';
import 'package:fpic_app/main.dart';
import '../data/repository.dart';
import '../constants.dart';

// Create a Form widget.
class EmailForm extends StatefulWidget {
  final Meta meta;

  const EmailForm({super.key, required this.meta});

  @override
  EmailFormState createState() {
    return EmailFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class EmailFormState extends State<EmailForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<EmailFormState>.
  final _formKey = GlobalKey<FormState>();
  var formData;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    Repository repository = Repository();
    bool sent;

    return BlocBuilder<LocalizationCubit, Localization>(
        builder: (BuildContext context, Localization localization) {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localization == Localization.English
                            ? widget.meta.email_form.missing_name_en ?? ""
                            : widget.meta.email_form.missing_name_kh ?? "";
                      }
                      return null;
                    },
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        decorationColor: Colors.white),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(9.0),
                          ),
                          borderSide:
                              BorderSide(color: Colors.amber, width: 2.0),
                        ),
                        filled: true,
                        fillColor: DarkBackgroundColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(9.0),
                          ),
                          borderSide:
                              BorderSide(color: Colors.amber, width: 2.0),
                        ),
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 14.0),
                        hintText: localization == Localization.English
                            ? widget.meta.email_form.name_en ?? ""
                            : widget.meta.email_form.name_kh ?? ""))),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localization == Localization.English
                            ? widget.meta.email_form.missing_email_en ?? ""
                            : widget.meta.email_form.missing_email_kh ?? "";
                      }
                      return null;
                    },
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        decorationColor: Colors.white),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(9.0),
                          ),
                          borderSide:
                              BorderSide(color: Colors.amber, width: 2.0),
                        ),
                        filled: true,
                        fillColor: DarkBackgroundColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(9.0),
                          ),
                          borderSide:
                              BorderSide(color: Colors.amber, width: 2.0),
                        ),
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 14.0),
                        hintText: localization == Localization.English
                            ? widget.meta.email_form.email_en ?? ""
                            : widget.meta.email_form.email_kh ?? ""))),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: TextFormField(
                    controller: subjectController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localization == Localization.English
                            ? widget.meta.email_form.missing_subject_en ?? ""
                            : widget.meta.email_form.missing_subject_kh ?? "";
                      }
                      return null;
                    },
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        decorationColor: Colors.white),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(9.0),
                          ),
                          borderSide:
                              BorderSide(color: Colors.amber, width: 2.0),
                        ),
                        filled: true,
                        fillColor: DarkBackgroundColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(9.0),
                          ),
                          borderSide:
                              BorderSide(color: Colors.amber, width: 2.0),
                        ),
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 14.0),
                        hintText: localization == Localization.English
                            ? widget.meta.email_form.subject_en ?? ""
                            : widget.meta.email_form.subject_kh ?? ""))),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: TextFormField(
                    controller: messageController,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return localization == Localization.English
                            ? widget.meta.email_form.missing_message_en ?? ""
                            : widget.meta.email_form.missing_message_kh ?? "";
                      }
                      return null;
                    },
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        decorationColor: Colors.white),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(9.0),
                          ),
                          borderSide:
                              BorderSide(color: Colors.amber, width: 2.0),
                        ),
                        filled: true,
                        fillColor: DarkBackgroundColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(9.0),
                          ),
                          borderSide:
                              BorderSide(color: Colors.amber, width: 2.0),
                        ),
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 14.0),
                        hintText: localization == Localization.English
                            ? widget.meta.email_form.message_en ?? ""
                            : widget.meta.email_form.message_kh ?? ""))),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
              child: GestureDetector(
                  onTap: () async => {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate())
                          {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            sent = await repository.email({
                              'name': nameController.text,
                              'email': emailController.text,
                              'subject': subjectController.text,
                              'message': messageController.text
                            }),

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(sent
                                    ? localization == Localization.English
                                        ? widget.meta.email_form
                                                .success_message_en ??
                                            ""
                                        : widget.meta.email_form
                                                .success_message_kh ??
                                            ""
                                    : localization == Localization.English
                                        ? widget.meta.email_form
                                                .failed_message_en ??
                                            ""
                                        : widget.meta.email_form
                                                .failed_message_kh ??
                                            "")))
                          }
                      },
                  child: Card(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0)),
                      child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: DarkBackgroundColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9.0))),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  child: Center(
                                      child: Text(
                                          localization == Localization.English
                                              ? widget.meta.email_form
                                                      .send_button_en ??
                                                  ""
                                              : widget.meta.email_form
                                                      .send_button_kh ??
                                                  "",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight:
                                                  FontWeight.bold)))))))),
            ),
          ],
        ),
      );
    });
  }
}
