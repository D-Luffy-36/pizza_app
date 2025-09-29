plugins {
            id("com.google.gms.google-services") apply false
        }

        allprojects {
            repositories {
                google()
                mavenCentral()
            }
        }

        buildscript {
            repositories {
                google()
                mavenCentral()
            }
            dependencies {
                classpath("com.google.gms:google-services:4.4.3")
            }
        }

        buildDir = file("../../build")

        subprojects {
            buildDir = file("../../build/${project.name}")
            project.evaluationDependsOn(":app")
        }

        tasks.register<Delete>("clean") {
            delete(rootProject.buildDir)
        }