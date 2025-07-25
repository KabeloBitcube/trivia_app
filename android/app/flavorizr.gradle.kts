import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("trivia1") {
            dimension = "flavor-type"
            applicationId = "com.example.trivia1"
            resValue(type = "string", name = "app_name", value = "Trivia App V1")
        }
        create("trivia2") {
            dimension = "flavor-type"
            applicationId = "com.example.trivia2"
            resValue(type = "string", name = "app_name", value = "Trivia App V2")
        }
        create("trivia3") {
            dimension = "flavor-type"
            applicationId = "com.example.trivia3"
            resValue(type = "string", name = "app_name", value = "Trivia App V3")
        }
    }
}