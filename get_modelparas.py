import pandas as pd
import os

path = r'C:\Users\u7151703\Desktop\research\optimisation\c3_df3'

model_type = ['f']
classes = [3]
org = ['em']
initi = [0,1,2]
dataset = ['f3']
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
    'sim_data': [],  
    'replicate': [],
    'class_ind': [],
    'weight': [],
    'AC': [],
    'AG': [],  
    'AT': [], 
    'CG': [], 
    'CT': [], 
    'GT': [], 
    'FA': [], 
    'FC': [], 
    'FG': [], 
    'FT': [],
    'qAC': [],
    'qAG': [],  
    'qAT': [], 
    'qCG': [], 
    'qCT': [], 
    'qGT': []
})

xlsx_file = os.path.join(path, 'para.xlsx')


def normal_q(r,f):
    q= [[0,        r[0]*f[1],r[1]*f[2],r[2]*f[3]],
        [r[0]*f[0],0        ,r[3]*f[2],r[4]*f[3]],
        [r[1]*f[0],r[3]*f[1],0        ,1*f[3]],
        [r[2]*f[0],r[4]*f[1],1*f[2]   ,0]]

    q[0][0] = -sum(q[0])
    q[1][1] = -sum(q[1])
    q[2][2] = -sum(q[2])
    q[3][3] = -sum(q[3])

    dia_sum = - (f[0]*q[0][0] + f[1]*q[1][1] + f[2]*q[2][2] + f[3]*q[3][3])
    for i in range(4):
        for j in range(4):
            q[i][j] = q[i][j]/dia_sum
        
    return q


for iqfile in data_list:
    #file_name = str(iqfile[0]) +str(iqfile[1]) + '_' + iqfile[2] + str(iqfile[3]) + '_d' + str(iqfile[4]) + '_rep' + str(iqfile[5])
    file_name = str(iqfile[0]) +'1_' + iqfile[2] + str(iqfile[3]) + '_d' + str(iqfile[4]) + '_rep' + str(iqfile[5])
        
    iqtree_file = os.path.join(path, file_name + '.iqtree')
    if not os.path.exists(iqtree_file):
        continue
    
    weight = []
    AC = []
    AG = []
    AT = []
    CG = []
    CT = []
    GT = []
    FA = []
    FC = []
    FG = []
    FT = []
    qAC = []
    qAG = []
    qAT = []
    qCG = []
    qCT = []
    qGT = []
    
    with open(iqtree_file) as b:
        for line in b.readlines():
            for i in range(1,iqfile[1]+1):
                if str(i) + '  GTR' in line:
                    r = []
                    f = []
                    
                    weight.append(float(line.split()[-2]))
                    gtr_all = line.split()[-1]
                    gtr_list = gtr_all.split(',')
                    AC.append(float(gtr_list[0].split('{')[1]))
                    AG.append(float(gtr_list[1]))
                    AT.append(float(gtr_list[2]))
                    CG.append(float(gtr_list[3]))
                    CT.append(float(gtr_list[4].split('}')[0]))
                    GT.append(1)
                    FA.append(float(gtr_list[4].split('{')[1]))
                    FC.append(float(gtr_list[5]))
                    FG.append(float(gtr_list[6]))
                    FT.append(float(gtr_list[7].split('}')[0]))
                    
                    r.append(float(gtr_list[0].split('{')[1]))
                    r.append(float(gtr_list[1]))
                    r.append(float(gtr_list[2]))
                    r.append(float(gtr_list[3]))
                    r.append(float(gtr_list[4].split('}')[0]))
                    f.append(float(gtr_list[4].split('{')[1]))
                    f.append(float(gtr_list[5]))
                    f.append(float(gtr_list[6]))
                    f.append(float(gtr_list[7].split('}')[0]))
                    
                    q = normal_q(r,f)
                    qAC.append(q[0][1])
                    qAG.append(q[0][2])
                    qAT.append(q[0][3])
                    qCG.append(q[1][2])
                    qCT.append(q[1][3])
                    qGT.append(q[2][3])
    
    true_file_name = str(iqfile[0]) +str(iqfile[1]) + '_bfgs' + str(iqfile[3]) + '_d' + str(iqfile[4]) + '_rep' + str(iqfile[5])
    df1 = pd.DataFrame({
        'name': [true_file_name]*iqfile[1],
        'class': [iqfile[1]]*iqfile[1],
        'type': [iqfile[0]]*iqfile[1],
        'optimiser': [iqfile[2]]*iqfile[1],
        'initialisation': [iqfile[3]]*iqfile[1],
        'sim_data': [iqfile[4]]*iqfile[1],  
        'replicate': [iqfile[5]]*iqfile[1],
        'class_ind': list(range(1,iqfile[1]+1)),
        'weight': weight,
        'AC': AC,
        'AG': AG,  
        'AT': AT, 
        'CG': CG, 
        'CT': CT, 
        'GT': GT, 
        'FA': FA, 
        'FC': FC, 
        'FG': FG, 
        'FT': FT,
        'qAC': qAC,
        'qAG': qAG,  
        'qAT': qAT, 
        'qCG': qCG, 
        'qCT': qCT, 
        'qGT': qGT
    })
    
    df = pd.concat([df, df1], ignore_index=True)

df.to_excel(xlsx_file, index=False, engine='openpyxl')

