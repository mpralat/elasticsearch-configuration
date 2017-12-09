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
./bin/elasticsearch &
