import pandas as pd
import os

path = r'C:\Users\u7151703\Desktop\research\optimisation\c3_dq3'

model_type = ['f']
classes = [1,2,3,4,5,6,7]
org = ['em']
initi = [0,1,2]
dataset = ['q3']
rep = [1,2,3,4,5]

data_list = []
for t in model_type:
    for c in classes:
        for o in org:
            for i in initi:
                for d in dataset:
                    for r in rep:
                        data_list.append([t, c, o, i, d, r])
                        
df = pd.DataFrame({
    'name': [],
    'class': [],
    'type': [],
    'optimiser': [],
    'initialisation': [],
    'data': [],  
    'replicate': [], 
    'lnl': [], 
    'rfdist': [], 
    'bic': [], 
    'para': []
})

xlsx_file = os.path.join(path, 'likelihood.xlsx')                        


for iqfile in data_list:
    file_name = str(iqfile[0]) +str(iqfile[1]) + '_' + iqfile[2] + str(iqfile[3]) + '_d' + str(iqfile[4]) + '_rep' + str(iqfile[5])
        
    iqtree_file = os.path.join(path, file_name + '.iqtree')
    if not os.path.exists(iqtree_file):
        continue

    class_m = iqfile[1]
    type_m = iqfile[0]
    optimiser = iqfile[2]
    initialisation = iqfile[3]
    data = iqfile[4]
    replicate = iqfile[5]
    lnl = ''
    rfdist = ''
    bic = ''
    para = ''

    with open(iqtree_file) as b:
        for line in b.readlines():
            if 'Log-likelihood of the tree:' in line:
                lnl = float(line.split()[4])
            if 'Bayesian information criterion (BIC) score:' in line:
                bic = float(line.split()[-1])
                
    rf_file = os.path.join(path, file_name + '_rf.rfdist')
    if os.path.exists(rf_file):
        with open(rf_file) as b:
            for line in b.readlines():
                if 'Tree0       ' in line:
                    rfdist = float(line.split()[-1])
            
    result_row = {
        'name': file_name,
        'class': class_m,
        'type': type_m,
        'optimiser': optimiser,
        'initialisation': initialisation,
        'data': data,  
        'replicate': replicate, 
        'lnl': lnl, 
        'rfdist': rfdist, 
        'bic': bic, 
        'para': para
    }

    df = df.append(result_row, ignore_index=True)

df.to_excel(xlsx_file, index=False, engine='openpyxl')

