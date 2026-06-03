# Tic Tac Toe — Déploiement Docker

Hébergement d'un jeu Tic Tac Toe (Morpion) via Docker avec nginx + php-fpm, et persistance des résultats via un volume nommé.

---

## Structure du projet

```
TicTacToe-Docker/
├── conf/
│   ├── nginx.conf        # Configuration du serveur nginx
│   └── supervisord.conf  # Gestion des processus nginx + php-fpm
├── images/               # Captures d'écran de chaque étape
├── Dockerfile
├── index.html
├── save.php
├── results.json
└── README.md
```

---

## Étape 1 — Construction de l'image Docker

```bash
docker build -t tictactoe .
```

![Build de l'image](images/01_docker_build.png)

---

## Étape 2 — Création du volume nommé

```bash
docker volume create game-results
```

![Création du volume](images/02_volume_create.png)

### Vérification que le volume a bien été créé

```bash
docker volume ls
docker volume inspect game-results
```

![Vérification du volume](images/03_volume_inspect.png)

---

## Étape 3 — Lancement du conteneur

```bash
docker run -d \
  --name tictactoe-app \
  -p 8080:80 \
  -v game-results:/usr/share/nginx/html \
  tictactoe
```

- `-d` : mode détaché (en arrière-plan)
- `--name` : nom du conteneur
- `-p 8080:80` : port 8080 de la machine → port 80 du conteneur
- `-v game-results:/usr/share/nginx/html` : volume monté pour persister `results.json`

![Lancement du conteneur](images/04_docker_run.png)

---

## Étape 4 — Accès au jeu via le navigateur

Le jeu est accessible à l'adresse : **http://localhost:8080**

![Jeu dans le navigateur](images/05_jeu_navigateur.png)

---

## Étape 5 — Jeu et génération de résultats

Plusieurs parties jouées pour générer des données dans `results.json`.

![Parties jouées](images/06_parties_jouees.png)

---

## Étape 6 — Accès au système de fichiers du conteneur

```bash
docker exec -it tictactoe-app sh
```

![Accès au conteneur](images/07_exec_conteneur.png)

---

## Étape 7 — Consultation du fichier results.json

### Via le terminal

```bash
docker exec tictactoe-app cat /usr/share/nginx/html/results.json
```

![results.json via terminal](images/08_results_terminal.png)

### Via Docker Desktop

Naviguer dans : **Volumes → game-results → Files**

![results.json via Docker Desktop](images/09_results_desktop.png)

---

## Étape 8 — Contenu du volume

```bash
docker run --rm -v game-results:/data alpine cat /data/results.json
```

![Contenu du volume](images/10_volume_content.png)

---

## Étape 9 — Résultats des parties

Contenu du fichier `results.json` après plusieurs parties :

![Résultats des parties](images/11_results_json.png)

---

## Étape 10 — Arrêt du conteneur

```bash
docker stop tictactoe-app
```

![Arrêt du conteneur](images/12_docker_stop.png)

---

## Récapitulatif des commandes

| Action | Commande |
|--------|----------|
| Construire l'image | `docker build -t tictactoe .` |
| Créer le volume | `docker volume create game-results` |
| Lister les volumes | `docker volume ls` |
| Inspecter le volume | `docker volume inspect game-results` |
| Lancer le conteneur | `docker run -d --name tictactoe-app -p 8080:80 -v game-results:/usr/share/nginx/html tictactoe` |
| Accéder au conteneur | `docker exec -it tictactoe-app sh` |
| Lire results.json | `docker exec tictactoe-app cat /usr/share/nginx/html/results.json` |
| Arrêter le conteneur | `docker stop tictactoe-app` |
