import random
import pandas as pd
import os

random.seed(2024)

xlsx_file = 'f81c3_rep.xlsx'
rep = 5
classes = 3


def gen_u(n):
    numbers = [random.random() for _ in range(n-1)]
    numbers.append(1)
    numbers.append(0)
    numbers = sorted(numbers)    
    f_list = [numbers[i+1] - numbers[i] for i in range(n)]
    
    return f_list

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

df = pd.DataFrame({
    'data': [],
    'class': [],
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

for r in range(rep):
    data = []
    class_ind = []
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
    
    for c in range(classes):
        data.append('rep' + str(r+1))
        class_ind.append(c+1)
        AC.append(1)
        AG.append(1)
        AT.append(1)
        CG.append(1)
        CT.append(1)
        GT.append(1)
        rates = [1,1,1,1,1,1]
        
        f = gen_u(4)
        while min(f) < 0.001:
            f = gen_u(4)
            
        FA.append(f[0])
        FC.append(f[1])
        FG.append(f[2])
        FT.append(f[3])
        
        q = normal_q(rates,f)
        qAC.append(q[0][1])
        qAG.append(q[0][2])
        qAT.append(q[0][3])
        qCG.append(q[1][2])
        qCT.append(q[1][3])
        qGT.append(q[2][3])
        
    weight = gen_u(classes)
    while min(weight) < 0.01:
        weight = gen_u(6)

    
    df1 = pd.DataFrame({
    'data': data,
    'class': class_ind,
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
    
    file_name = 'f81c3_rep' + str(r+1) +'_sim'
    model_cmd = ' -m "MIX{'
    
    for i in range(classes):
        q_para = 'GTR{'+str(AC[i])+'/'+str(AG[i])+'/'+str(AT[i])+'/'+str(CG[i])+'/'+str(CT[i])+'}+F{'+str(FA[i])+'/'+str(FC[i])+'/'+str(FG[i])+'/'+str(FT[i])+'}:1:' + str(weight[i]) + ','
        model_cmd = model_cmd + q_para
            
    model_cmd = model_cmd[:-1] + '}"' 

    alisim_cmd = '/mnt/data/dayhoff/home/u7151703/software/iqtree-2.2.8.mix-Linux/bin/iqtree2 --alisim ' + file_name + model_cmd + ' --length ' + str(1000*classes) + ' -seed ' + str(rep+2024) + ' -af fasta -t RANDOM{yh/' +str(100)+ '} -redo'
    print(alisim_cmd)
    os.system(alisim_cmd)

df.to_excel(xlsx_file, index=False, engine='openpyxl')




# =============================================================================
# #c3
# print(gen_f(4))
# print(gen_f(4))
# print(gen_f(4))
# 
# print(gen_f(3))
# print('\n\n')
# 
# #c6
# print(gen_f(4))
# print(gen_f(4))
# print(gen_f(4))
# print(gen_f(4))
# print(gen_f(4))
# print(gen_f(4))
# 
# print(gen_f(6))
# print('\n\n')
# =============================================================================
