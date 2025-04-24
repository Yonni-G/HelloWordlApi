# Étape 1 : Build avec Maven et JDK 21
FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /app

# Copier les fichiers de configuration Maven en premier (pour le cache Docker)
COPY pom.xml .
COPY src ./src

# Compile et package le projet
RUN mvn clean install -DskipTests

# Étape 2 : Image légère pour exécuter l'app
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

# Copier le .jar depuis l'image précédente
COPY --from=build /app/target/*.jar app.jar

# Expose le port si besoin (optionnel)
EXPOSE 8080

# Commande pour lancer l'app
ENTRYPOINT ["java", "-jar", "app.jar"]

