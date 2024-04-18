import os
import pandas as pd

#modelparas = pd.read_excel(r'C:\Users\u7151703\Desktop\research\optimisation\q3.xlsx')
modelparas = pd.read_excel('f81_rep.xlsx')

seed_num = 2024

class_num = [6]
taxa_num =[10,25,50,100]

for c_num in class_num:
    for t_num in taxa_num:
        for rep in range(1,5+1):
            file_name = 'f81'+ str(c_num) +'_t' + str(t_num) +'_rep'+ str(rep)+ '_sim'
            model_cmd = ' -m "MIX{'
            
            for i in range(modelparas.shape[0]):
                if modelparas.data[i] == "rep"+ str(rep):
                    q_para = 'GTR{'+str(modelparas.AC[i])+'/'+str(modelparas.AG[i])+'/'+str(modelparas.AT[i])+'/'+str(modelparas.CG[i])+'/'+str(modelparas.CT[i])+'}+F{'+str(modelparas.FA[i])+'/'+str(modelparas.FC[i])+'/'+str(modelparas.FG[i])+'/'+str(modelparas.FT[i])+'}:1:' + str(modelparas.weight[i]) + ','
                    model_cmd = model_cmd + q_para
                    
            model_cmd = model_cmd[:-1] + '}"' 
        
            alisim_cmd = '/mnt/data/dayhoff/home/u7151703/software/iqtree-2.2.8.mix-Linux/bin/iqtree2 --alisim ' + file_name + model_cmd + ' --length ' + str(1000*c_num) + ' -seed ' + str(seed_num+rep) + ' -af fasta -t RANDOM{yh/' +str(t_num)+ '} -redo'
            print(alisim_cmd)
            os.system(alisim_cmd)