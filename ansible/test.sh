ansible controller -b -a mysql_user -a "login_user=root login_password='' name=root password=\"root\" priv=*.*:ALL,GRANT host=localhost"
