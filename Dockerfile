FROM eclipse-temurin
EXPOSE 80
ARG JAR_FILE_PATH=/home/ubuntu/target/spring-petclinic-2.4.0.BUILD-SNAPSHOT.jar
COPY ${JAR_FILE_PATH} spring-petclinic.jar
ENTRYPOINT ["java", "-jar", "spring-petclinic.jar"]
