import os



files = os.listdir()
iq_file_list = [file for file in files if file.endswith(".treefile")]



iqtree = '/mnt/data/dayhoff/home/u7151703/software/iqtree-2.2.8.mix-Linux/bin/iqtree2'

sim_tree = '/mnt/data/dayhoff/home/u7151703/optimisation/simulation/q7_sim.treefile'

for iqfile in iq_file_list:
    tree1 = iqfile
        
    pre = tree1.split('.')[0] + '_rf'

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
