import pandas as pd

modelparas = pd.read_excel(r'C:\Users\u7151703\Desktop\research\optimisation\parameters.xlsx')

qAC = []
qAG = []
qAT = []
qCG = []
qCT = []
qGT = []

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

for i in range(modelparas.shape[0]):
    r = [modelparas.AC[i],modelparas.AG[i],modelparas.AT[i],modelparas.CG[i],modelparas.CT[i]]
    f = [modelparas.FA[i],modelparas.FC[i],modelparas.FG[i],modelparas.FT[i]]

    q = normal_q(r,f)
    qAC.append(q[0][1])
    qAG.append(q[0][2])
    qAT.append(q[0][3])
    qCG.append(q[1][2])
    qCT.append(q[1][3])
    qGT.append(q[2][3])

modelparas['qAC'] = qAC
modelparas['qAG'] = qAG
modelparas['qAT'] = qAT
modelparas['qCG'] = qCG
modelparas['qCT'] = qCT
modelparas['qGT'] = qGT

modelparas.to_excel(r'C:\Users\u7151703\Desktop\research\optimisation\parameters.xlsx', index=False, engine='openpyxl')
