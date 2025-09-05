import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yoo_live/Features/Bloc/CreateRoomBloC/create_room_bloc.dart';
import 'package:yoo_live/widget/presentation/audio_live_host_view_widget/audio_room_page.dart';

import '../../../Features/domain/Model/CreatingRoomResponse.dart';

class BeforeLiveScreen extends StatefulWidget {
  const BeforeLiveScreen({super.key});

  @override
  State<BeforeLiveScreen> createState() => _BeforeLiveScreenState();
}

class _BeforeLiveScreenState extends State<BeforeLiveScreen> {
  TextEditingController textEditingController = TextEditingController();
  String selectedCategory = 'Song';
  int selectedSeat = 8;
  String? role;
  File? selectedImagePath;

  final List<String> categories = [
    'Song',
    'Music',
    'Story',
    'Fun',
    'PK',
    'Another',
  ];
  final List<int> seatOptions = [8, 12, 16];

  void createRoom(DataForRoom dataForRoom) {
    context.read<CreateRoomBloc>().add(CreateRoom(dataForRoom));
  }

  void fetchProfileDetails() {
    context.read<CreateRoomBloc>().add(FetchProfileDetails());
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85, // compress for performance
    );

    if (image != null) {
      // Check file extension
      final ext = image.path.split('.').last.toLowerCase();
      if (['jpg', 'jpeg', 'png'].contains(ext)) {
        setState(() {
          selectedImagePath = File(image.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Only JPG, JPEG, or PNG images are allowed'),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    fetchProfileDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: BlocListener<CreateRoomBloc, CreateRoomState>(
        listener: (context, state) {
          if (state is CreateRoomLoading) {
            print("Creating room - showing loading...");
          } else if (state is AuthProfileDetails) {
            role = state.authProfile.data?.role;
            print("User role: $role");
          } else if (state is CreateRoomSuccess) {
            final roomId = state.creatingRoomResponse.data?.sId;
            print("Room created successfully! RoomId: $roomId");
            if (roomId != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AudioRoomPage(roomId: roomId),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Room created but ID is missing')),
              );
            }
          } else if (state is CreateRoomFailure) {
            print("Room creation failed: ${state.message}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to create room: ${state.message}')),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              //category
              const Text(
                "Select Category",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                    categories.map((category) {
                      final isSelected = selectedCategory == category;
                      return ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.black : Colors.black,
                        ),
                        selectedColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        shape: StadiumBorder(
                          side: BorderSide(color: Colors.white),
                        ),
                      );
                    }).toList(),
              ),

              //image
              const SizedBox(height: 30),
              const Text(
                "Add a image",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: pickImage,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(12),
                    image:
                        selectedImagePath != null
                            ? DecorationImage(
                              image: FileImage(selectedImagePath!),
                              fit: BoxFit.cover,
                            )
                            : null,
                  ),
                  child:
                      selectedImagePath == null
                          ? const Icon(Icons.image, color: Colors.white)
                          : null,
                ),
              ),
              const SizedBox(height: 20),

              //title
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: 'Add a title',
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 30),

              //seat
              const Text(
                "Seat",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Row(
                children:
                    seatOptions.map((seat) {
                      final isSelected = selectedSeat == seat;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSeat = seat;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 15),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? Colors.white : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white),
                          ),
                          child: Text(
                            seat.toString(),
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),

              SizedBox(height: 40),
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFBAE3C), Color(0xFFB64EF0)],
                  ),
                ),
                child: TextButton.icon(
                  onPressed: () {
                    if (textEditingController.text.isNotEmpty &&
                        role == "ADMIN" &&
                        selectedImagePath != null) {
                      DataForRoom dataForRoom = DataForRoom(
                        textEditingController.text,
                        selectedCategory.toUpperCase(),
                        selectedSeat,
                        selectedImagePath, //image file
                      );
                      // Go Live logic
                      createRoom(dataForRoom);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Something went wrong')),
                      );
                    }
                  },
                  icon: const Icon(Icons.graphic_eq, color: Colors.white),
                  label: const Text(
                    "Go Live",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
