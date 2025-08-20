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
                  return Expanded(child: Center(child: CircularProgressIndicator(color: Colors.white,)));
                } else if (state is SearchProfileStateSuccess) {

                  final items = state.searchProfileResponse.data ?? [];

                  if (items.isEmpty) {
                    return const Center(
                      child: Text(
                        "No items found",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.white),
                      ),
                    );
                  }

                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Two columns
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                         childAspectRatio: 0.9, // Adjust aspect ratio for item height
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            SearchItem(
                              name: item.name ?? "",
                              id: item.userId ?? 0,
                            ),
                          ]
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

  const SearchItem({super.key, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "ID:$id",
            style: const TextStyle(color: Colors.white54, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
