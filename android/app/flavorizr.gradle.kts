import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("apple") {
            dimension = "flavor-type"
            applicationId = "com.example.trivia1"
            resValue(type = "string", name = "app_name", value = "Trvia App V1")
        }
        create("banana") {
            dimension = "flavor-type"
            applicationId = "com.example.trivia2"
            resValue(type = "string", name = "app_name", value = "Trvia App V2")
        }
    }
}