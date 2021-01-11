# thePHP Website

> [Article](https://thephp.website/en/issue/php-docker-quick-setup/)

1. Créer l'arborescence :

    ```bash
    mkdir my-project
    cd my-project
    touch docker-compose.yml
    mkdir -p src/ tests/ bin/ .conf/nginx/ var/
    ```

1. Compléter le fichier `docker-compose.yml` :

    ```yaml
    version: '3'
    services:
    ```

1. Ajouter un service pour *Composer* dans `docker-compose.yml` :

    ```yaml
    version: '3'
    services:
        composer:
            image: composer:1.9.3
            environment:
            - COMPOSER_CACHE_DIR=/app/var/cache/composer
            volumes:
            - .:/app
            restart: never
    ```
    
1. Ajouter le fichier `.gitignore` :

    ``` bash
    echo 'vendor/' >> .gitignore
    echo 'var/' >> .gitignore
    ```

1. Ajouter PHPUnit :

    ``` bash
    docker-compose run composer require --dev phpunit/phpunit
    ```

1. Ajouter un service pour PHP dans `docker-compose.yml` :

    ```yaml
    version: '3'
    services:
        composer:
            # ...
        php:
            image: php:7.4-cli
            restart: never
            volumes:
            - .:/app
            working_dir: /app # Pour que /app doit le dossier courant lorsqu'on lance docker-compose run php
    ```

    On peut désormais lancer phpunit avec :

    ```bash
    docker-compose run php vendor/bin/phpunit
    ```

1. Ajouter un service pour phpunit pour simplifier la commande :

    ```yaml
    version: '3'
    services:
        composer:
            # ...
        php:
            # ...
        phpunit:
            image: php:7.4-cli
            restart: never
            volumes:
            - .:/app
            working_dir: /app
            entrypoint: ["php", "vendor/bin/phpunit"] # Commande qui s'exécute quand on lance le conteneur. Ici on aurait pu juste mettre vendor/bin/phpunit.
    ```

    On peut désormais lancer phpunit avec :

    ```bash
    docker-compose run phpunit
    ```

1. Générer le fichier de configuration de PHPUnit :

    ```bash
    docker-compose run phpunit --generate-configuration
    ```

1. Créer un test :

    ```bash
    touch tests/MyTest.php
    ```

    Dans le fichier `tests/MyTest.php` :

    ```php
    <?php

    declare(strict_types=1);

    use PHPUnit\Framework\TestCase;

    class MyTest extends TestCase
    {
        public function testMyTest(): void
        {
            self::assertTrue(false);
        }
    }
    ```

1. Ajouter un service pour PHP-FPM :

    ```yaml
    version: '3'
    services:
        composer:
            # ...
        php:
            # ...
        phpunit:
            # ...
        fpm:
            image: php:7.4-fpm
            restart: always
            volumes:
                - .:/app
    ```

    Pour lancer le service en arrière plan :

    ```bash
    docker-compose up -d fpm
    ```

1. Ajouter un service pour NGINX :

    ```yaml
    version: '3'
    services:
        composer:
            # ...
        php:
            # ...
        phpunit:
            # ...
        fpm:
            # ...
        nginx:
            image: nginx:1.17.8-alpine
            ports:
                - 8080:80 # Expose le port local 8080 correspondant au port 80 du conteneur
            volumes:
                - .:/app
                - ./var/log/nginx:/var/log/nginx
                - .conf/nginx/site.conf:/etc/nginx/conf.d/default.conf
    ```

    Créer le fichier de configuration NGINX :

    ```bash
    touch .conf/nginx/site.conf
    ```

    Contenu du fichier `.conf/nginx/site.conf` :

    ```
    server {
        listen 80;
        listen [::]:80;

        root /app/public;
        index index.php;

        location / {
            try_files $uri $uri/ /index.php$is_args$args;
        }

        location ~ .php$ {
            try_files $uri =404;
            fastcgi_split_path_info ^(.+.php)(/.+)$;
            fastcgi_pass fpm:9000;
            fastcgi_index index.php;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            fastcgi_param PATH_INFO $fastcgi_path_info;
        }

        access_log /var/log/nginx/myapp_access.log;
        error_log /var/log/nginx/myapp_error.log;
    }
    ```