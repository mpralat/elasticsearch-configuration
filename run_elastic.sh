if  [ ! -d  elasticsearch-5.5.2 ]
then
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.5.2.zip
    unzip elasticsearch-5.5.2.zip
fi
cd elasticsearch-5.5.2/
rm config/elasticsearch.yml
cp ../elasticsearch.yml config/
rm config/jvm.options
cp ../jvm.options config/
export ES_JAVA_OPTS="-Xms600m -Xmx600m"
sysctl -w vm.max_map_count=262144
./bin/elasticsearch &

# clean the indices if run with the clean flag
if [ "$1" == "clean" ]
then
     # wait for components to run
     printf "sleeping"
     sleep 5s
     printf "deleting indices..."
     curl -XDELETE localhost:9200/count*
     printf "setting up the mappings..."
     cd ${SCRIPTPATH}
     python3 setup_elastic.py
fi
