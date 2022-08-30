#! /bin/bash
################## Database
echo 'Criando e Atualizando baco de Dados' &&
mysqldump --ssl-mode=DISABLE --column-statistics=0 --no-tablespaces -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" 123milhas_model > dump.sql &&
mysqldump --ssl-mode=DISABLE --column-statistics=0 --no-tablespaces -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" 123milhas_model_meta > dump_meta.sql &&
mysqldump --ssl-mode=DISABLE --column-statistics=0 --no-tablespaces -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" 123milhas_model_cache > dump_cache.sql &&
mysqldump --ssl-mode=DISABLE --column-statistics=0 --no-tablespaces -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" 123milhas_model_bt > dump_bt.sql &&
################## 123milhas_meta
echo 'create database 123milhas_${VERS}_meta;' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" 123milhas_${VERS}_meta < dump_meta.sql &&
################## 123milhas_cache
echo 'create database 123milhas_${VERS}_cache;' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" 123milhas_${VERS}_cache < dump_cache.sql &&
################## 123milhas_bt
echo 'create database 123milhas_${VERS}_bt;' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" 123milhas_${VERS}_bt < dump_bt.sql &&
################## 123milhas
echo 'create database 123milhas_${VERS};' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" 123milhas_${VERS} < dump.sql &&
echo 'Banco Criado e Atualizado' &&
################## Criando usario do banco de dados 
echo 'Criando Usuario banco de dados' &&
echo 'CREATE USER "teste_${VERS}"@"%" IDENTIFIED BY "${RESULT_PASS_DB}";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'GRANT ALL PRIVILEGES ON 123milhas_${VERS}.* TO "teste_${VERS}"@"%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'GRANT ALL PRIVILEGES ON 123milhas_${VERS}_bt.* TO "teste_${VERS}"@"%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'GRANT ALL PRIVILEGES ON 123milhas_${VERS}_meta.* TO "teste_${VERS}"@"%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'GRANT ALL PRIVILEGES ON 123milhas_${VERS}_cache.* TO "teste_${VERS}"@"%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'flush privileges;' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
################## Atulizando configs do banco de dados
echo 'Atualizando variaveis config banco de dados' &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "teste${VERS}.${ENV_REDIS}" WHERE `key` like "%redis%host%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "http://teste${VERS}.123milhas.com" WHERE `key` like "%app.url%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "http://teste${VERS}.123milhas.com/img/best-destinations" WHERE `key` like "%best-travels.file.path%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "http://teste${VERS}.buscafacilmf.com.br/" WHERE `key` like "%external.bf.url%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "https://teste${VERS}.123milhas.com/api/search-listener" WHERE `key` like "%notifications.endpoint%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "http://teste${VERS}.123milhas.com" WHERE `key` like "%external_products_provider.nekobasu.callback_url%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "http://teste${VERS}.123milhas.com/login/facebook/callback" WHERE `key` like "%services.facebook.redirect%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "http://teste${VERS}.123milhas.com/login/google/callback" WHERE `key` like "%services.google.redirect%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "https://teste${VERS}.123milhas.com:8443" WHERE `key` like "%antifraud.connections.0.url%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "https://teste${VERS}.buscafacilmf.com.br/view/eticket?chave=" WHERE `key` like "%external.eticket_url%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "https://teste${VERS}.buscafacilmf.com.br/transporter/" WHERE `key` like "%external.transporter.url%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "http://teste${VERS}.buscafacilmf.com.br" WHERE `key` like "%external_products_provider.buscafacil.url%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "123milhas_${VERS}_bt" WHERE `key` like "%database.connections.best_travels_database.database%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "123milhas_${VERS}" WHERE `key` like "%database.connections.mysql.database%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "123milhas_${VERS}_meta" WHERE `key` like "%database.connections.mysql_metasearch.database%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "123milhas_${VERS}_cache" WHERE `key` like "%database.connections.mysql_cache.database%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "teste_${VERS}" WHERE `key` like "%database%user%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'UPDATE 123milhas_${VERS}.configs SET value = "${RESULT_PASS_DB}" WHERE `key` like "%database%pass%";' | mysql -h ${DB_HOST} -u ${DB_USER} -p"${DB_PASS}" &&
echo 'Variaveis do banco Atualizadas' &&
################## Atulizando arquviso de variaveis
echo 'atualizando arquivos do ambiente' &&
sed -i 's/testex/teste${VERS}/g' /var/www/123Milhas/.env &&
sed -i 's/testex/teste${VERS}/g' /var/www/123Milhas/constants.php &&
sed -i 's/testex/teste${VERS}/g' /var/www/123milhas-nextjs/packages/web/.env.local &&
sed -i 's/testex/teste${VERS}/g' /etc/nginx/conf.d/123milhas.conf &&
sed -i 's/123milhas_x/123milhas_${VERS}/g' /var/www/123Milhas/.env &&
sed -i 's/123milhas_x_meta/123milhas_${VERS}_meta/g' /var/www/123Milhas/.env &&
sed -i 's/123milhas_x_cache/123milhas_${VERS}_cache/g' /var/www/123Milhas/.env &&
sed -i 's/123milhas_x_bt/123milhas_${VERS}_bt/g' /var/www/123Milhas/.env &&
sed -i 's/root/teste_${VERS}/g' /var/www/123Milhas/.env &&
sed -i 's/senhax/${RESULT_PASS_DB}/g' /var/www/123Milhas/.env &&
echo 'Variaveis do ambiente Atualizadas' &&
echo 'Executando comandos finais' &&
################## 123Milhas 
echo 'Reiniciando NGINX' &&
sudo service nginx restart &&
################## Redis1
echo 'Limpando dados da instância redis1' &&
redis-cli -h teste${VERS}.${ENV_REDIS} flushall &&
################## Git
echo 'Executando comandos Git' &&
su ubuntu -c 'cd /var/www/123Milhas && git fetch origin && git checkout -- . && git checkout dev && git pull origin dev' &&
su ubuntu -c 'cd /var/www/123milhas-nextjs && git fetch origin && git checkout -- . && git checkout master && git pull origin master' &&
su ubuntu -c 'cd /var/www/123Milhas && composer install' &&
################## PHP artisan  
echo 'Executando comandos PHP artisan' &&
su ubuntu -c 'cd /var/www/123Milhas && php artisan migrate; php artisan db:seed; php artisan constants:update; php artisan constants:load; ' &&
################## 123milhasnext.js 
su ubuntu -c 'cd /var/www/123milhas-nextjs && . ~/.nvm/nvm.sh; nvm use 16; yarn install' &&
su ubuntu -c 'cd /var/www/123milhas-nextjs && . ~/.nvm/nvm.sh; nvm use 16; pm2 kill; pm2 start yarn --name "123milhas_nextjs" --interpreter bash -- web' &&
################## 132Milhas
su ubuntu -c 'cd /var/www/123Milhas && . ~/.nvm/nvm.sh; nvm use 8; gulp' &&
##################
echo '### AMBIENTE CRIADO ! ###'
exit 0

