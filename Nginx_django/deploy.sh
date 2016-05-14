#!/bin/bash

stop_server(){
    echo -e "\t\t * Stopping service."
    uwsgi_count=$(ps aux|grep "uwsgi"|grep -v "grep"|wc -l)
    if [ $uwsgi_count -gt 0 ]
    then
        echo -e "\t\t * Killing uWSGI.\c"
        sudo killall -9 uwsgi
        echo -e "\033[32mDone.\033[0m"
    else
        echo -e "\t\t * No uWSGI processes found."
    fi
    nginx_count=$(ps aux|grep "nginx"|grep -v "grep"|wc -l)
    if [ $nginx_count -gt 0 ]
    then
        echo -e "\t\t * Killing nginx.\c"
        sudo killall -9 nginx
        echo -e "\033[32mDone.\033[0m"
    else
        echo -e "\t\t * No nginx processes found."
    fi
}
start_nginx(){
    echo -e "\t\t * Start nginx.\c"
    sudo /etc/init.d/nginx start
    echo -e "\033[32mDone.\033[0m"
}
start_uWSGI(){
    echo -e "\t\t * Load all uWSGI ini files."
    dir="/etc/uwsgi/apps-available"
    filelist=`ls $dir/*.ini`
    for file in $filelist
    do
        echo -e "\t\t\c"
        sudo uwsgi --ini $file
    done
    echo -e "\t\t * Load all uWSGI ini files.\c"
    echo -e "\033[32mDone.\033[0m"
}
start_server(){
    echo -e "\t\t * Starting service."
    start_uWSGI
    start_nginx
}
check_server(){
    status_code=0
    echo -e "\t\tChecking service."
    echo -e "\t\t\c"
    /etc/init.d/nginx status
    nginx_count=$(ps aux|grep "nginx"|grep -v "grep"|wc -l)
    if [ $nginx_count -gt 0 ]
    then
        echo -e "\t\t * "$nginx_count" nginx processes found"
        let status_code=$status_code+1
    else
        echo -e "\t\t\033[33m * No nginx processes found.\033[0m"
    fi
    uwsgi_count=$(ps aux|grep "uwsgi"|grep -v "grep"|wc -l)
    if [ $uwsgi_count -gt 0 ]
    then
        echo -e "\t\t * uWSGI is running"
        echo -e "\t\t * "$uwsgi_count" uwsgi processes found"
        let status_code=$status_code+2
    else
        echo -e "\t\t\033[31m *\033[0m uWSGI is not running"
        echo -e "\t\t\033[33m * No uwsgi processes found.\033[0m"
    fi
    if [ $status_code -eq 3 ]
    then
        echo -e "\t\t\033[32m * All service are running.\033[0m"
    elif [ $status_code -eq 2 ]
    then
        echo -e "\t\t\033[33m * nginx service is not running.\033[0m"
    elif [ $status_code -eq 1 ]
    then
        echo -e "\t\t\033[33m * uWSGI service is not running.\033[0m"
    else
        echo -e "\t\t\033[31m * All service are not running.\033[0m"
    fi
    return $status_code
}


echo -e "\t\t**************************************************"
echo -e "\t\t*   SIE Automatic Deploy and Maintainence tool   *"
echo -e "\t\t*\t\t\t\t   Author: David *"
echo -e "\t\t**************************************************"
echo -e ""
if [ $1 ]
then
    choice=$1
else
    echo -e "\t\tAvailable options:"
    echo -e "\t\t- deploy:  Deploy project with nginx and uWSGI."
    echo -e "\t\t- start:   Start uwsgi and nginx."
    echo -e "\t\t- stop:    Stop uwsgi and nginx."
    echo -e "\t\t- restart: Stop and restart uwsgi and nginx."
    echo -e "\t\t- update:  check remote git repository and update"
    echo -e "\t\t           local branch."
    echo -e "\t\t\033[37mPlease select a option: \033[0m\c"
    read choice
fi
echo -e ""
if [ "$choice"x = "deploy"x ]
then
    echo -e "\t\t**************************************************"
    echo -e "\t\t* This part is going to deploy a project. and it *"
    echo -e "\t\t* will follow these steps.                       *"
    echo -e "\t\t*                                                *"
    echo -e "\t\t* 1. Install nginx and uWSGI.                    *"
    echo -e "\t\t* 2. Get important project variables from        *"
    echo -e "\t\t*    user input.                                 *"
    echo -e "\t\t* 4. Setting up nginx and uWSGI files.           *"
    echo -e "\t\t* 5. Create link files to /etc/nginx and         *"
    echo -e "\t\t*    /etc/uwsgi .                                *"
    echo -e "\t\t* 6. Restart nginx server and uWSGI.             *"
    echo -e "\t\t*                                                *"
    echo -e "\t\t* Please confirm you are fully aware of these    *"
    echo -e "\t\t* steps, otherwise \033[31mDO NOT\033[0m continue.              *"
    echo -e "\t\t**************************************************"
    echo -e "\t\t"
    echo -e "\t\tPlease confirm to continue (Y or N):\c"
    read confirm
    if [ "$confirm"x != "Y"x ]
    then
        exit 0
    fi

    # Install Python and Django requirements
    # Install nginx and uWSGI
    sudo apt-get install python-dev
    sudo apt-get install libmysqlclient-dev libmysqld-dev
    sudo apt-get install mysql-server mysql-client
    if [ -f "requirements.txt" ]
    then
        pip install -r requirements.txt
    fi
    sudo apt-get install nginx
    sudo pip install uwsgi

    echo -e "Project path:\c"
    read project_path
    echo -e "Project name:\c"
    read project_name
    echo -e "home path:\c"
    read home_path

    echo -e "1- Copy nginx.conf with "$project_name
    cp nginx.conf $project_name.conf

    echo -e "2- Copy uwsgi.ini with "$project_name
    cp uwsgi.ini $project_name.ini


    echo -e "3- Replace path/to/project with "$project_path" in nginx.conf"
    sed -i 's#path/to/project#'$project_path'#g' $project_name.conf
    echo -e "4- Replace project_name with "$project_name" in nginx.conf"
    sed -i 's#project_name#'$project_name'#g' $project_name.conf
    echo -e "5- Replace path/to/home with "$home_path" in nginx.conf"
    sed -i 's#path/to/home#'$home_path'#g' $project_name.conf
    echo -e "6- Replace path/to/project with "$project_path" in uwsgi.ini"
    sed -i 's#path/to/project#'$project_path'#g' $project_name.ini
    echo -e "7- Replace project_name with "$project_name" in uwsgi.ini"
    sed -i 's#project_name#'$project_name'#g' $project_name.ini
    echo -e "8- Replace path/to/home with "$home_path" in uwsgi.ini"
    sed -i 's#path/to/home#'$home_path'#g' $project_name.ini

    echo -e "9- Create link files."
    sudo rm -f /etc/nginx/sites-enabled/$project_name.conf
    sudo rm -f /etc/nginx/sites-available/$project_name.conf
    sudo rm -f /etc/uwsgi/apps-available/$project_name.ini
    sudo ln -s $project_path/$project_name.conf /etc/nginx/sites-enabled/
    sudo ln -s $project_path/$project_name.conf /etc/nginx/sites-available/
    sudo ln -s $project_path/$project_name.ini /etc/uwsgi/apps-available/

    echo -e "10- Restart nginx server and uWSGI."
    sudo /etc/rc.local

elif [ "$choice"x = "update"x ]
then
    if [ -f ".git" ]
    then
        echo -e "\t\t\033[32m * Update source codes from Github repo.\033[0m"
    else
        echo -e "\t\t\033[33m * No repository found!\033[0m"
        exit 0
    fi
    echo -e "\t\t\033[36m * Check out to master\033[0m"
    git checkout master
    echo -e "\t\t\033[36m * Pull from origin master\033[0m"
    git pull origin master
    echo -e "\t\t\033[36m * Collect static files\033[0m"
    ./manage.py collecstatic
elif [ "$choice"x = "start"x ]
then
    status_code=`check_server`
    status_code=$?
    echo -e "\t\tstatus_code: "$status_code
    if [ $status_code -eq 0 ]
    then
        start_server
    elif [ $status_code -eq 1 ]
    then
        echo -e "\t\t\033[33m * nginx service is running.\033[0m"
        start_uWSGI
    elif [ $status_code -eq 2 ]
    then 
        echo -e "\t\t\033[33m * uWSGI service is running.\033[0m"
        start_nginx
    else
        echo -e "\t\t\033[33m * All services is running.\033[0m"
        echo -e "\t\t\033[33m * Use <status> to check.\033[0m"
    fi
elif [ "$choice"x = "stop"x ]
then
    status_code=`check_server`
    stop_server
elif [ "$choice"x = "restart"x ]
then
    status_code=`check_server`
    if [ $? -eq 3 ]
    then
        stop_server
    fi
    status_code=`check_server`
    if [ $? -eq 0 ]
    then
        start_server
    fi
elif [ "$choice"x = "status"x ]
then
    check_server
else
    echo -e "\t\t**************************************************"
    echo -e "\t\t*\t\t     \033[33mWrong Usage\033[0m                 *"
    echo -e "\t\t*                Available Usages                *"
    echo -e "\t\t*   [update|status|restart|start|stop|deploy]    *"
    echo -e "\t\t**************************************************"
fi
