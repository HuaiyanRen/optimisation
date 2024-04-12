import os
import csv

folder_path = r'C:\Users\u7151703\Desktop\research\optimisation\data\f81_qmix\c3t100r05k'

new_csv_path = os.path.join(folder_path,'sum_result.csv')


with open(new_csv_path, mode='w', newline='') as new_csv_file:
    writer = csv.writer(new_csv_file)

    writer.writerow(['method', 'class', 'lnl', 'bic', 'lrt', 'df', 'time', 'rep']) 


    for filename in os.listdir(folder_path):
        if filename.endswith('.csv'):
            file_path = os.path.join(folder_path, filename)
            repname = filename.split('.csv')[0]

            with open(file_path, mode='r', newline='') as csv_file:
                reader = csv.reader(csv_file)
                next(reader)  

                for row in reader:
                    writer.writerow(row + [repname])


