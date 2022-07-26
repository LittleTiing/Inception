#!/bin/sh

# Check mariadb is alive
while ! mysqladmin ping -h$WORDPRESS_DB_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD &>/dev/null; do
    sleep 2
done

wordpressPath="/var/www/html"

# Create wordpress path if not exists
if [ ! -d $wordpressPath ]; then
    mkdir -p $wordpressPath
fi

# If not have wp-config.php file
if [ ! -f "$wordpressPath/wp-config.php" ]; then
    # Dowload wordpress in path
    wp core download --path=$wordpressPath --allow-root

    # Generate wp-config.php file
    wp config create    --dbname=$WORDPRESS_DB_NAME \
                        --dbuser=$WORDPRESS_DB_USER \
                        --dbpass=$WORDPRESS_DB_PASSWORD \
                        --dbhost=$WORDPRESS_DB_HOST \
                        --path=$wordpressPath \
                        --allow-root

    # Run the standard wordpress installation process
    wp core install --url=$WORDPRESS_DOMAIN_NAME \
                    --title="Inception" \
                    --admin_user=$WORDPRESS_ADMIN_USER \
                    --admin_password=$WORDPRESS_ADMIN_PASSWORD \
                    --admin_email=$WORDPRESS_ADMIN_EMAIL \
                    --path=$wordpressPath \
                    --skip-email \
                    --allow-root

    # Create a new user
    wp user create  $WORDPRESS_NORMAL_USER \
                    $WORDPRESS_NORMAL_EMAIL \
                    --user_pass=$WORDPRESS_NORMAL_PASSWORD \
                    --path=$wordpressPath \
                    --allow-root
fi

echo "Wordpress started on port 9000"
# Run php-fpm force to stay in foreground and allow root
php-fpm7 -F -R
