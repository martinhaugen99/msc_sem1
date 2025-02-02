import matplotlib.pyplot as plt
import numpy as np
import pandas as pd


def plot_circles(circle_data, title='Circle Plot', save_path=None):
    """
    plots circles in a 2d plane

    params:
    - circle data: list of tuples [(x, y, r, name), ,,,], where:
      (x, y) are coordinates for the center of the circle
      r is the radius of the circle
      name is the label for the circle
    - title: title of the plot
    - save_path: if provided, saves the plot to this path 
    """

    _, ax = plt.subplots()
    ax.set_aspect('equal', adjustable='datalim')

    colors = plt.cm.tab10(np.linspace(0, 1, len(circle_data)))      # generate distinct colours

    for i, (x, y, r, name) in enumerate(circle_data):
        circle = plt.Circle((x, y), r, color=colors[i], alpha=0.5, edgecolor='black', linewidth=1.5, label=name)
        ax.add_artist(circle)
        ax.plot(x, y, 'o', color=colors[i])     # mark the center of the circle

    ax.legend(loc='upper right', title='Robots', fontsize='small', title_fontsize='medium')
    ax.set_title(title)
    ax.set_xlabel('X-axis')
    ax.set_ylabel('Y-axis')
    plt.grid(True)

    if save_path:
        plt.savefig(save_path, dpi=300)

    plt.show()

def main():
    # load data from excel file
    file_path = '/Users/martinhaugen/Desktop/master/sem1/optmet/exercises/excel/robots.xlsx'
    sheet_name = 'Sheet2'

    # read the data into a dataframe 
    df = pd.read_excel(file_path, sheet_name=sheet_name, header=None)

    # extract the data and create list 
    circle_data = [
        (row[1], row[2], row[0], f'Robot {i + 1}') for i, row in df.iterrows()
    ]

    plot_circles(circle_data, title='Robot operating areas')

if __name__=='__main__':
    main()