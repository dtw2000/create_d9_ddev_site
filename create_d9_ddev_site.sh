#!/bin/bash
read -p "Enter Site Name: " sitename
# be in the right directory
cd ~/sites/ddev
##echo $sitename >> out.txt
mkdir $sitename
cd ./$sitename
ddev config --docroot=web  --project-type=drupal9 --create-docroot
ddev start
ddev composer create drupal/recommended-project --yes
ddev composer require drush/drush
cp web/sites/example.settings.local.php web/sites/default/settings.local.php
echo "if (file_exists(\$app_root . '/' . \$site_path . '/settings.local.php')) {include \$app_root . '/' . \$site_path . '/settings.local.php';}" >> web/sites/default/settings.php
ddev drush site-install --account-pass=admin --yes
ddev composer require drupal/admin_toolbar
ddev drush en -y admin_toolbar admin_toolbar_tools
ddev launch