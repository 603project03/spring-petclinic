FROM eclipse-temurin
EXPOSE 80
ARG JAR_FILE_PATH=/home/ubuntu/*.jar
COPY ${JAR_FILE_PATH} spring-petclinic.jar
ENTRYPOINT ["java", "-jar", "spring-petclinic.jar"]
