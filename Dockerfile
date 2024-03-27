FROM eclipse-temurin
COPY ./target/spring-petclinic-2.4.0.BUILD-SNAPSHOT.jar spring-petclinic.jar
ENTRYPOINT ["java", "-jar", "spring-petclinic.jar"]
