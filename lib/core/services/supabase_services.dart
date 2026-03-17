import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  static const String supabaseUrl = 'https://ubgwoeskhnoxoyxdwtmu.supabase.co';
  static const String supabaseKey =
      'sb_publishable_vG8svlqbYqispp17VgDcEA_HxLZ1KjH';

  static Future<void> initSupabase() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  }

 
}
