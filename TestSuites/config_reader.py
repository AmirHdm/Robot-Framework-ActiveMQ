import configparser


def Read_Config_File(file_path):
    config = configparser.ConfigParser()
    config.read(file_path)
    data = {}
    for section in config.sections():
        data[section] = dict(config.items(section))
    print(data)
    return data

