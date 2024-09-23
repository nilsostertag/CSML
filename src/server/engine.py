import data_pipeline

def execute_analytics(uuid, drive_id):
    #Daten einspeisen, lesbar machen und bereinigen
    dataset = data_pipeline.get_data(uuid, drive_id)
    dataset = data_pipeline.rename_columns(dataset)
    dataset = data_pipeline.convert_values(dataset)

    dataset = data_pipeline.sort_by_datetime(dataset)
    dataset = data_pipeline.add_calculations(dataset)
    pass

if __name__ == '__main__':
    execute_analytics()