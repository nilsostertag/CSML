import pandas as pd
import matplotlib.pyplot as plt

def plot_datafrane_light(df_plot):
    plot_dataframe(df_plot, ['latitude', 'longitude'], 'datetime')


def plot_dataframe(df_plot, columns_to_drop, time_column):
    # Entferne die Spalten 'latitude' und 'longtitude'
    if len(columns_to_drop) > 0:
        df_plot = df_plot.drop(columns=columns_to_drop)

    df_plot['datetime'] = pd.to_datetime(df_plot['datetime'])
    df_plot = df_plot.sort_values(by='datetime', ascending=True)

    # Erstelle eine neue Figur
    plt.figure(figsize=(25, 8))

    columns_to_plot = [column for column in df_plot.columns if column != 'datetime']

    for column in columns_to_plot:
        plt.plot(df_plot['datetime'], df_plot[column], label=column)

    # Formatierung des Plots
    plt.xlabel('Datum und Uhrzeit')
    plt.ylabel('Wert')
    plt.title('Werte über Zeit')
    plt.legend()
    plt.grid(True)
    plt.xticks(rotation=45)  # Drehe die x-Achsen-Beschriftungen für bessere Lesbarkeit
    plt.tight_layout()  # Sorgt dafür, dass alles gut aussieht und nichts abgeschnitten wird

    # Zeige den Plot an
    plt.show()