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
├── style.css
├── save.php
├── results.json
└── README.md
```

---

## Étape 1 — Construction de l'image Docker

```bash
docker build -t tictactoe .
```

![Build de l'image](images/docker_build.png)

---

## Étape 2 — Création du volume nommé

```bash
docker volume create game-results
```

### Vérification que le volume a bien été créé

```bash
docker volume ls
docker volume inspect game-results
```

![Liste des volumes](images/docker_volume_ls.png)

![Inspection du volume](images/docker_volume_inspect_game-results.png)

---

## Étape 3 — Lancement du conteneur

```bash
docker run -d --name tictactoe-app -p 8080:80 -v game-results:/usr/share/nginx/html tictactoe
```

- `-d` : mode détaché (en arrière-plan)
- `--name` : nom du conteneur
- `-p 8080:80` : port 8080 de la machine → port 80 du conteneur
- `-v game-results:/usr/share/nginx/html` : volume monté pour persister `results.json`

![Lancement du conteneur](images/docker_run.png)

![Conteneur actif](images/docker_ps.png)

---

## Étape 4 — Accès au jeu via le navigateur

Le jeu est accessible à l'adresse : **http://localhost:8080**

![Jeu dans le navigateur](images/Nav.png)

---

## Étape 5 — Parties jouées

![Victoire X](images/nav_victoire_X.png)

![Victoire O](images/nav_victoire_O.png)

![Match nul](images/nav_match_null.png)

---

## Étape 6 — Accès au système de fichiers du conteneur

```bash
docker exec -it tictactoe-app sh
```

---

## Étape 7 — Résultats des parties dans results.json

```bash
docker exec tictactoe-app cat /usr/share/nginx/html/results.json
```

![Résultats via terminal](images/docker_results.png)

![Résultats via Docker Desktop](images/docker_volume_result.json.png)

---

## Étape 8 — Arrêt du conteneur

```bash
docker stop tictactoe-app
```

![Arrêt du conteneur](images/docker_stop.png)

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
