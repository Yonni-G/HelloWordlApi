### TP Fils Rouge pour les Étudiants

Le **TP fils rouge** consiste à suivre le pipeline complet, étape par étape, et de comprendre chaque concept et chaque tâche. L'objectif est de créer un pipeline CI/CD complet de A à Z, tout en mettant en place des bonnes pratiques de qualité et de gestion des artefacts.

---

#### **Jour 1 – CI Build / Test / Artefacts + Multistage**

**Objectifs :**
- Créer un pipeline de base avec un build Java, un test unitaire et la publication des artefacts.
- Ajouter la fonctionnalité multistage dans le pipeline.

1. **Création du Projet**
   - Créez un projet Java de type API simple avec Maven (ou Gradle) et ajoutez un test unitaire.
   - Poussez le projet sur un dépôt GitHub et GitLab.

2. **Mise en place de GitHub Actions (GitHub)**
   - Créez un fichier `.github/workflows/build.yml`.
   - Ajoutez des étapes pour :
     - **Build** du projet avec `mvn clean install` (ou l'équivalent Gradle).
     - **Test** avec `mvn test`.
     - Publier un artefact `.jar` ou `.war` dans le répertoire des artefacts.
   
3. **Mise en place de GitLab CI (GitLab)**
   - Créez un fichier `.gitlab-ci.yml` équivalent.
   - Ajoutez des étapes pour :
     - **Build** du projet avec `mvn clean install`.
     - **Test** avec `mvn test`.
     - Publier un artefact `.jar` ou `.war` dans le répertoire des artefacts.

4. **Ajout du Multistage dans les Pipelines**
   - Divisez les étapes du pipeline en plusieurs stages (par exemple, `build`, `test`, `publish`).
   - Sur GitHub et GitLab, structurez les jobs de manière à ce que chaque étape soit un stage distinct.

---

#### **Jour 2 – Docker + Secrets + Publication Conditionnelle**

**Objectifs :**
- Construire une image Docker du projet Java.
- Ajouter des secrets pour la publication sur Docker Hub.
- Conditionner l'exécution des étapes Docker à la réussite des tests.

1. **Création d'un Dockerfile**
   - Créez un Dockerfile pour le projet Java.
   - Assurez-vous que l'image Docker contient l'application Java et que l'application peut être exécutée depuis un conteneur.

2. **Ajout du Docker Build Conditionnel**
   - Dans le pipeline GitHub Actions et GitLab CI, ajoutez une condition pour que le build Docker soit effectué uniquement si les tests unitaires réussissent.
   - Utilisez `if: success()` dans GitHub Actions et `when: on_success` dans GitLab pour contrôler cette condition.

3. **Ajout des Secrets dans le Pipeline**
   - Ajoutez un secret fictif dans GitHub (par exemple, une clé API ou un mot de passe Docker Hub).
   - Ajoutez également ce secret dans GitLab CI.
   - Utilisez ce secret dans les étapes du pipeline pour se connecter à Docker Hub.

4. **Push de l'Image Docker sur Docker Hub**
   - Créez un job supplémentaire qui push l'image Docker sur Docker Hub si les tests réussissent et que le build Docker a été réalisé.
   - Assurez-vous de vous connecter au Hub Docker avec les secrets d'identification (via Docker login).

---

#### **Jour 3 – Qualité + Matrices de Build**

**Objectifs :**
- Ajouter des tests supplémentaires.
- Ajouter un job de qualité (couverture de tests).
- Implémenter des matrices de build pour tester plusieurs versions de Java.

1. **Ajout de Tests Unitaires**
   - Ajoutez des tests unitaires à votre API Java en utilisant JUnit.
   - Intégrez la génération d'un rapport de couverture de code avec `jacoco` (ou un outil équivalent).

2. **Ajout du Badge de Qualité**
   - Ajoutez un badge pour les tests ou la couverture de code dans le README de votre dépôt.
   - Générer le badge avec l'outil de couverture (par exemple, Jacoco).

3. **Ajout des Matrices de Build**
   - Dans le fichier `.github/workflows/build.yml`, ajoutez une matrice pour tester votre projet avec plusieurs versions de Java (ex : Java 11 et Java 17).
   - Dans le fichier `.gitlab-ci.yml`, créez un job similaire qui utilise une matrice pour tester les différentes versions de Java.

4. **Changelog Automatique**
   - Ajoutez un job pour générer un changelog basé sur les commits depuis la dernière release. Utilisez un outil comme `git-cliff`, `release-please` ou équivalent.
   - Le changelog doit être créé automatiquement dans le pipeline à chaque nouvelle version.

---

#### **Jour 4 – Changelog + Consolidation**

**Objectifs :**
- Générer un changelog automatique.
- Consolider l'ensemble du pipeline CI/CD.

1. **Génération Automatique du Changelog**
   - Configurez un outil de changelog automatique pour que chaque commit ajouté au projet génère une entrée dans le changelog.
   - Affichez ce changelog dans la page des releases GitHub ou GitLab.

2. **Revue Complète du Pipeline**
   - Vérifiez que tous les composants sont bien connectés :
     - Tests
     - Docker build & push
     - Couverture
     - Matrices de build
     - Changelog
   - Ajoutez un badge pour chaque étape du pipeline et vérifiez leur bon fonctionnement.

