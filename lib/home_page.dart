import 'package:flutter/material.dart';
import 'package:notify/core/extensions.dart';
import 'package:notify/features/note/notegridtile_component.dart';

class HomePage extends StatelessWidget {
  final bool isAnonymous = true;
  final String accountName = 'user';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: CustomScrollView(
          slivers: [
            _buildProfileBar(context),
            _buildGreetingBar(context),
            SliverToBoxAdapter(child: SizedBox(height: 24)),
            _buildNotes(context),
          ],
        ),
      ),
    );
  }

  SliverGrid _buildNotes(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 2,
      childAspectRatio: 7 / 8,
      crossAxisSpacing: 8,
      mainAxisSpacing: 12,
      children: List.generate(8, (index) {
        return NoteGridTile();
      }),
    );
  }

  SliverToBoxAdapter _buildGreetingBar(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello $accountName !',
                style: context.textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Save important info here !',
                style: context.textTheme.bodyLarge!.copyWith(
                  shadows: [
                    Shadow(
                      blurRadius: 20,
                      color: Colors.black,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: CircleAvatar(
              child: isAnonymous
                  ? Icon(Icons.person_2_rounded)
                  : Text(accountName),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildProfileBar(BuildContext context) {
    return SliverAppBar(
      flexibleSpace: Row(
        spacing: 8,
        children: [
          CircleAvatar(
            child: isAnonymous
                ? Icon(Icons.person_2_rounded)
                : Text(accountName),
          ),
          Text(
            isAnonymous ? 'Anonymus User' : accountName,
            style: context.textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
