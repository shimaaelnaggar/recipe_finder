import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepo {
  SupabaseClient supabase = Supabase.instance.client;

  Future<Either<String, void>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await supabase.auth.signUp(email: email, password: password);
      await saveUserData(name: name, email: email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> saveUserData({
    required String name,
    required String email,
  }) async {
    try {
      final user = supabase.auth.currentUser;
      if (user != null) {
        final userId = user.id;
        await supabase.from('users').insert({
          'id': userId,
          'name': name,
          'email': user.email,
        });
      }
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> getUserData() async {
  try {
    final user = supabase.auth.currentUser;

    final data = await supabase
        .from('users')
        .select()
        .eq('id', user!.id)
        .single();

    return Right(data);
  } catch (e) {
    return Left(e.toString());
  }
}
}
