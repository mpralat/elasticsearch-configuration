import subprocess
from glob import glob

config = {'mappings_path': 'elasticsearch_mappings/*.mapping', 'elasticsearch_host': 'localhost', 'elasticsearch_port': 9200}

def main():
    for mapping_path in glob(config.get('mappings_path')):
        _create_index_and_mapping(mapping_path)
    print("******** FINISHED ALL ********")

def _create_index_and_mapping(mapping_path):
    with open(mapping_path, 'r') as f:
            name = f.readline()
            mapping = f.read()

    name = name.replace('\n', '').replace('\t', '').replace(' ', '')

    create_index_string = ["curl", "-XPUT", "{host}:{port}/{name}".format(
            host=config.get('elasticsearch_host'),
            port=config.get('elasticsearch_port'),
            name=name,
        )
    ]
    create_mapping_string = [
        "curl",
        "-XPUT", "{host}:{port}/{name}/_mapping/{name}".format(
            host=config.get('elasticsearch_host'),
            port=config.get('elasticsearch_port'),
            name=name),
        "-H", "Content-Type: application/json",
        "-d", "{mapping}".format(mapping=mapping)]

    subprocess.run(create_index_string)
    subprocess.run(create_mapping_string)
    print("\nCreated index and mapping: {}".format(name))

if __name__ == "__main__":
    main()
