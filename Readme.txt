Перед использованием сервиса необходимо заполнить базу данных стран (countries) и валют (currencies). В консоли: rake database:refresh_all
При использовании: удалит все данные в таблицах countries и сurrencies (если они есть), скачает новые данные с soap сервера, указанного в config/environments/production.rb (на данный момент, http://www.webservicex.net/country.asmx').

Чтобы добавить логин и пароль владельца коллекции, наберите в консоли: rake database:register_owner[login,password], где login - логин владельца, password - пароль владельца. По умолчанию (rake database:register_owner) login='smart', password='verysmart'.
