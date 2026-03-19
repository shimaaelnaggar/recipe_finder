import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepo {
  final supabase = Supabase.instance.client;

  Future<Map<String, dynamic>> getProfile() async {
    final user = supabase.auth.currentUser;

    final data = await supabase
        .from('users')
        .select()
        .eq('id', user!.id)
        .single();

    return data;
  }

  Future<Either<String, void>> logout() async {
    try {
      await supabase.auth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

 Future<void> updateProfile({
  required String name,
  required String email,
}) async {

  final user = supabase.auth.currentUser;

  if (user == null) {
    throw Exception("User not logged in");
  }

  await supabase
      .from('users')
      .update({
        'name': name,
        'email': email,
      })
      .eq('id', user.id);
}
}
