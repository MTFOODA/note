// ignore_for_file: file_names, must_be_immutable, use_build_context_synchronously, avoid_print
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:note_app/logics/create_note_logic/cubit.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/utilities/colors_dart.dart';
import 'package:note_app/logics/create_note_logic/state.dart';
import 'package:note_app/models/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/utilities/decoration.dart';
import 'package:note_app/utilities/fonts_dart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreateNoteScreen extends StatelessWidget {
  CreateNoteScreen({super.key});

  TextEditingController headLineController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  XFile? selectedImage;

  Future selectImage() async {
    final ImagePicker picker = ImagePicker();
    selectedImage = await picker.pickImage(source: ImageSource.gallery);
    print ('${selectedImage?.path}');
  }

  Future<String?> uploadImage(XFile image) async {
    try {
      final storage = FirebaseStorage.instance
          .ref()
          .child("note_images/${DateTime.now().millisecondsSinceEpoch}.jpg");
      await storage.putFile(File(image.path));
      return await storage.getDownloadURL();
    } catch (e) {
      print("Uploaded Error ===========$e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateNoteCubit(),
      child: BlocConsumer<CreateNoteCubit, CreateNoteStates>(
        listener: (context, state) {
          if (state is CreateNoteSuccessStates) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Note is Created successful")),
            );
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ));
          } else if (state is CreateNoteErrorStates) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage.toString())),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.primaryLM,
            appBar: AppBar(
              title: Text('Add Note'.tr()),
              actions: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()));
                  },
                ),
                const SizedBox(width: 20),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 120),
                    Text("Create New Note".tr(), style: AppFonts.textW24bold),
                    const SizedBox(height: 20),
                    IconButton(
                      icon: const Icon(Icons.add_photo_alternate_outlined),
                      iconSize: 100.0,
                      tooltip: 'Add Image'.tr(),
                      onPressed: selectImage,
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            style: AppFonts.textW24bold,
                            controller: headLineController,
                            decoration: customInputDecoration('Head line'.tr()),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            style: AppFonts.textW24bold,
                            controller: descriptionController,
                            maxLines: 3,
                            decoration: customInputDecoration('Description'.tr()),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () async {
                        if (selectedImage != null) {
                          final imageUrl = await uploadImage(selectedImage!);
                          context.read<CreateNoteCubit>().createNote(NotesModel(
                              description: descriptionController.text,
                              headline: headLineController.text,
                              time: DateTime.now(),
                              imageUrl: imageUrl));

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                          );
                        } else {
                          context.read<CreateNoteCubit>().createNote(NotesModel(
                                description: descriptionController.text,
                                headline: headLineController.text,
                                time: DateTime.now(),
                              ));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                          );
                        }
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: customContainerDecoration(),
                        child: Center(
                          child: Text("Create".tr(), style: AppFonts.textW24bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
