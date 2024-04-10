import os


model_type = ['f']
classes = [3]
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


iqtree = r'C:\Users\u7151703\Desktop\research\software\iqtree-2.2.2.6-Windows\bin\iqtree2'

file_path = r'C:\Users\u7151703\Desktop\research\optimisation'

for iqfile in data_list:
    file_name = str(iqfile[0]) +str(iqfile[1]) + '_' + iqfile[2] + str(iqfile[3]) + '_d' + str(iqfile[4]) +  '_rep' + str(iqfile[5])    
    file_folder = 'c'+ str(iqfile[1]) + '_d' + str(iqfile[4])

    
    iqtree_file = os.path.join(file_path, file_folder, file_name + '.iqtree')
    if not os.path.exists(iqtree_file):
        print(iqtree_file)
        continue
    
    sim_tree_path =  r'C:\Users\u7151703\Desktop\research\optimisation\simulation'
    sim_tree = os.path.join(sim_tree_path, str(iqfile[4]) + '_sim.treefile')
    
    tree1 = os.path.join(file_path, file_folder, file_name + '.treefile')
    pre = os.path.join(file_path, file_folder, file_name + '_rf')

    cmd = iqtree + ' -rf ' + tree1 + ' ' + sim_tree + ' -pre ' + pre + ' -redo'
    os.system(cmd)


# =============================================================================
# t1 = os.path.join(file_path, file_folder, 's3_bfgs0_dq3_rep1.treefile')
# t2 = os.path.join(file_path, file_folder, 's3_em0_dq3_rep1.treefile')
# prex = os.path.join(file_path, file_folder, 'outlier')
# 
# cmdx = iqtree + ' -rf ' + t1 + ' ' + t2 + ' -pre ' + prex + ' -redo'
# os.system(cmdx)
# =============================================================================

