import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoo_live/Features/Bloc/SearchProfileBloc/search_profile_bloc.dart';

// hi there
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void searchedProfile(String query) {
    context.read<SearchProfileBloc>().add(FetchSearchedProfile(query));
  }

  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    context.read<SearchProfileBloc>().add(ResetSearchPage());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            context.read<SearchProfileBloc>().add(ResetSearchPage());
          },
        ),
        title: const Text("", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "Search ID or Name",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.white54),
                    onPressed: () {
                      searchedProfile(searchController.text);
                      searchController.clear();
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            //Search Items
            BlocBuilder<SearchProfileBloc, SearchProfileState>(
              builder: (context, state) {
                if (state is SearchProfileStateLoading) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  );
                } else if (state is SearchProfileStateSuccess) {
                  final items = state.searchProfileResponse.data ?? [];

                  if (items.isEmpty) {
                    return const Center(
                      child: Text(
                        "No items found",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.searchProfileResponse.data?.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return SearchItem(
                          name: item.name ?? "",
                          id: item.userId ?? 0,
                          profileImageUrl: item.profileImage,
                          onAddPressed: () {

                          },
                        );
                      },
                    ),
                  );
                } else if (state is SearchProfileError) {
                  return Center(child: Text(state.message));
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SearchItem extends StatelessWidget {
  final String name;
  final int id;
  final String? profileImageUrl;
  final VoidCallback? onAddPressed; // Callback for the add button

  const SearchItem({
    super.key,
    required this.name,
    required this.id,
    this.profileImageUrl,
    this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    // A default placeholder image if profileImageUrl is null or empty
    final ImageProvider<Object> backgroundImageProvider =
        (profileImageUrl != null && profileImageUrl!.isNotEmpty)
            ? NetworkImage(profileImageUrl!)
            : const AssetImage('assets/account.png');

    return InkWell(
      onTap: () {
        print("Tapped on $name");
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[850]?.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white12, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blueAccent.withOpacity(0.7),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 30, // Slightly larger
                backgroundColor: Colors.grey[700],
                backgroundImage: backgroundImageProvider,
                onBackgroundImageError: (exception, stackTrace) {
                  print('Error loading image: $exception');
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18, // Larger font for name
                      letterSpacing: 0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "ID: $id",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onAddPressed ?? () {},
                borderRadius: BorderRadius.circular(20),
                splashColor: Colors.blueAccent.withOpacity(0.3),
                highlightColor: Colors.blueAccent.withOpacity(0.2),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent.withOpacity(
                      0.15,
                    ), // Subtle background
                  ),
                  child: Icon(
                    Icons.person_add_alt_1_rounded, // A different add icon
                    color: Colors.blueAccent, // Use accent color
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
