FROM eclipse-temurin
CMD ["./mvnw", "clean", "package"]
ARG JAR_FILE_PATH=target/*.jar
COPY ${JAR_FILE_PATH} spring-petclinic.jar
ENTRYPOINT ["nohup" "java", "-jar", "spring-petclinic.jar"]
EXPOSE 8080
