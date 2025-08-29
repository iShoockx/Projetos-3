proguard
CopiarEditar
# Mantém as classes essenciais para o Flutter
-keep class io.flutter.** { *; }
-keep class androidx.** { *; }
-keep class com.example.** { *; }

#Evita remover código importante do Picasso (caso use )
-keep class com.squareup.picasso.** { *; }

#Remove classes desnecessárias
-dontwarn android.support.**
-dontwarn java.awt.**
-dontwarn sun.misc**

#Ativa otimizaões agressivas
-optimizations !code/simplification/arithmetic