import os
import pandas as pd

path = r'C:\Users\u7151703\Desktop\research\optimisation\data\turtle\t1'

df = pd.DataFrame({
    'name': [],
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
    'qGT': [],
    'lnl': []
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


for filename in os.listdir(path):
    if filename.endswith('.iqtree'):
        file_path = os.path.join(path, filename)
        name = filename.split('.iqtree')[0]
        
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
        
        with open(file_path) as b:
            for line in b.readlines():
                if 'Model of substitution:' in line:
                    n_class = 1
                if 'Mixture model of substitution:' in line:
                    n_class = line.count(',') + 1
                if 'Log-likelihood of the tree:' in line:
                    lnl = float(line.split()[4])
    
        if n_class == 1:
            r = []
            f = []
            GT.append(1) 
            weight = 1
            
            with open(file_path) as b:
                for line in b.readlines():                                        
                    if 'A-C:' in line:
                        AC.append(float(line.split()[-1]))
                        r.append(float(line.split()[-1]))
                    if 'A-G:' in line:
                        AG.append(float(line.split()[-1]))
                        r.append(float(line.split()[-1]))
                    if 'A-T:' in line:
                        AT.append(float(line.split()[-1]))
                        r.append(float(line.split()[-1]))
                    if 'C-G:' in line:
                        CG.append(float(line.split()[-1]))
                        r.append(float(line.split()[-1]))
                    if 'C-T:' in line:
                        CT.append(float(line.split()[-1]))
                        r.append(float(line.split()[-1]))
                        r.append(1)
                    if 'pi(A)' in line:
                        FA.append(float(line.split()[-1]))
                        f.append(float(line.split()[-1]))
                    if 'pi(C)' in line:
                        FC.append(float(line.split()[-1]))
                        f.append(float(line.split()[-1]))
                    if 'pi(G)' in line:
                        FG.append(float(line.split()[-1]))
                        f.append(float(line.split()[-1]))
                    if 'pi(T)' in line:
                        FT.append(float(line.split()[-1]))
                        f.append(float(line.split()[-1]))
            
            q = normal_q(r,f)
            qAC.append(q[0][1])
            qAG.append(q[0][2])
            qAT.append(q[0][3])
            qCG.append(q[1][2])
            qCT.append(q[1][3])
            qGT.append(q[2][3])
            
        else:     
            with open(file_path) as b:
                for line in b.readlines():
                    for i in range(1,n_class+1):
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
        
        df1 = pd.DataFrame({
            'name': [name]*n_class,
            'class': list(range(1, n_class+1)),
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
            'qGT': qGT,
            'lnl': [lnl]*n_class
        })
        
        df = pd.concat([df, df1], ignore_index=True)

df.to_excel(xlsx_file, index=False, engine='openpyxl')

