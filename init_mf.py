import os
import argparse
import math
from scipy.stats import chi2
import csv

def init_mf(iqtree_loc, file_name, class_num, method, nt, pre, treefile, org):
    class_num = int(class_num)
    method = int(method)

    if treefile != '':
        treefile = ' -te ' + treefile
    if org == 'EM':
        org = ' -optalg_qmix EM'
    else:
        org = ''

    if pre == 'default':
        pre = file_name.split('/')[-1].split('.')[0] + '_i' + str(method)
    if not os.path.isfile(pre):
        os.system('mkdir ' + pre)
    if not os.path.isfile(pre + '.csv'):    
        with open(pre + '.csv', 'w+') as result:
            result.write('method,class,lnl,bic,lrt,df,time \n')
    
    if method == 6:
        cmd = iqtree_loc + 'iqtree2 -s ' + file_name + ' -m ' + sim_model_cmd(treefile) + ' -pre ' + pre + '/c'+str(class_num-1)+' -nt ' +nt+' -opt_input_val' + treefile + org
        os.system(cmd)
        
        iq_file = pre+'/c'+str(class_num-1)+'.iqtree'
        lnl, bic, df, time = get_result(iq_file, class_num-1)
        
        result_row = [str(method),str(class_num-1),str(lnl),str(bic),'none',str(df),str(time)]
        with open(pre + '.csv', 'a+', newline='') as result:   
            writer = csv.writer(result)
            writer.writerow(result_row)
    else:
        for c in range(1, class_num+1):
            if c == 1:
                cmd = iqtree_loc + 'iqtree2 -s ' + file_name + ' -m GTR{1,1,1,1,1}+FO -pre ' + pre + '/c1 -nt ' +nt + treefile + org
                os.system(cmd)
                
                iq_file = pre + '/c1.iqtree'
                lnl, bic, df, time = get_result(iq_file, c)
                lrt = 'none'
                
                result_row = [str(method),str(c),str(lnl),str(bic),str(lrt),str(df),str(time)]
                with open(pre + '.csv', 'a+', newline='') as result:   
                    writer = csv.writer(result)
                    writer.writerow(result_row)
                
            else:
                if method in [3,4,5]:
                    pre_result_file = pre + '/c' + str(c-1)
                    cmd = iqtree_loc + 'iqtree2 -s ' + file_name + ' -m ' + model_cmd(pre_result_file, c-1, method) + ' -pre ' + pre + '/c'+str(c)+' -nt ' +nt+' -opt_input_val' + treefile + org
                elif method in [0,1,2]:
                    cmd = iqtree_loc + 'iqtree2 -s ' + file_name + ' -m MIX"{'
                    for i in range(c):
                        if i < c-1:
                            cmd = cmd + 'GTR{1/1/1/1/1}+FO,'
                        else:
                            cmd = cmd + 'GTR{1/1/1/1/1}+FO}"'
                    cmd = cmd + ' -pre ' + pre + '/c'+str(c)+' -nt ' +nt+' -init_nucl_freq ' + str(method) + treefile + org
                    
                os.system(cmd)
                
                iq_file = pre + '/c'+str(c)+'.iqtree'
                lnl_new, bic, df_new, time = get_result(iq_file, c)
                
                p_value = chi2.cdf(2*(lnl_new - lnl), df_new - df)
                if p_value > 0.95:
                    lrt = 'yes'                
                else:
                    lrt = 'no'
                lnl = lnl_new
                df = df_new
                
                result_row = [str(method),str(c),str(lnl),str(bic),str(lrt),str(df),str(time)]
                with open(pre + '.csv', 'a+', newline='') as result:   
                    writer = csv.writer(result)
                    writer.writerow(result_row)
               
def get_result(file, c):
    with open(file) as iq_result:
        for line in iq_result.readlines():
            if 'Input data:' in line:
                ntaxa = float(line.split()[2])
                sites = float(line.split()[5])
            if 'Log-likelihood of the tree:' in line:
                lnl = float(line.split()[4])
            if 'Total CPU time used:' in line:
                time = float(line.split()[4])
    para = ntaxa*2 - 3 + 4*c - 1  
    bic = para*math.log(sites) - 2*lnl
    return lnl, bic, int(para), time
    
def model_cmd(filename, class_num, method):
    iqtree_file = filename + '.iqtree'
    
    cmd = 'MIX"{GTR{1/1/1/1/1}+FO'
                
    if class_num == 1:
        if method == 3:
            cmd = cmd + ':1:0.5,GTR{1/1/1/1/1}+FO{'
        elif method == 4:
            cmd = cmd + ':1:0.333,GTR{1/1/1/1/1}+FO{'
        elif method == 5:    
            cmd = cmd + '{0.25/0.25/0.25/0.25}:1:0.5,GTR{1/1/1/1/1}+FO{'
        with open(iqtree_file) as b:
            for line in b.readlines():
                if '  pi(A) =' in line:
                    cmd = cmd + str(line.split()[-1]) + str('/')
                if '  pi(C) =' in line:
                    cmd = cmd + str(line.split()[-1]) + str('/')
                if '  pi(G) =' in line:
                    cmd = cmd + str(line.split()[-1]) + str('/')
                if '  pi(T) =' in line:
                    cmd = cmd + str(line.split()[-1])
        if method == 4:
            cmd = cmd + '}:1:0.667}"'
        else:
            cmd = cmd + '}:1:0.5}"'
    else:
        model_list = [[0] * class_num for _ in range(2)]
        for i in range(class_num):
            with open(iqtree_file) as b:
                for line in b.readlines():
                    if '   ' + str(i+1) + '  ' in line:
                        model_list[0][i] = float(line.split()[3])
                        model_list[1][i] = line.split()[4].split('FO')[1].replace(',','/')
    
        paired = list(zip(*model_list))
        sorted_paired = sorted(paired, key=lambda x: x[0],reverse=True)
        sorted_list = list(zip(*sorted_paired))
    
        for j in range(class_num):
            if j == 0:
                if method == 3:
                    cmd = cmd + ':1:' + str(sorted_list[0][j]/2) + ',GTR{1/1/1/1/1}+FO' + str(sorted_list[1][j]) + ':1:' + str(sorted_list[0][j]/2) + ',GTR{1/1/1/1/1}+FO'
                elif method == 4:
                    cmd = cmd + ':1:' + str(sorted_list[0][j]*(1/3)) + ',GTR{1/1/1/1/1}+FO' + str(sorted_list[1][j]) + ':1:' + str(sorted_list[0][j]*(2/3)) + ',GTR{1/1/1/1/1}+FO'
                elif method == 5:    
                    cmd = cmd +'{0.25/0.25/0.25/0.25}:1:' + str(sorted_list[0][j]/2) + ',GTR{1/1/1/1/1}+FO' + str(sorted_list[1][j]) + ':1:' + str(sorted_list[0][j]/2) + ',GTR{1/1/1/1/1}+FO'
            elif j == class_num - 1:
                cmd = cmd + str(sorted_list[1][j]) + ':1:' + str(sorted_list[0][j]) + '}"'
            else:    
                cmd = cmd + str(sorted_list[1][j]) + ':1:' + str(sorted_list[0][j]) + ',GTR{1/1/1/1/1}+FO'
    return cmd

def sim_model_cmd(file_name):
    file_name = file_name.replace(' -te ', '') + '.log'
    
    cmd = 'MIX"{'
    with open(file_name) as b:
        for line in b.readlines():
            if 'GTR           1.000' in line:
                weight = line.split()[3]
                para = line.split()[4].replace(',','/').replace('FU','FO')
                cmd = cmd + para +':1:' + weight + ','
    cmd = cmd[:-1] + '}"'
    return cmd


parser = argparse.ArgumentParser(description='')
parser.add_argument('--iqtree_loc', '-loc', help='',
                    default = '')
parser.add_argument('--file_name', '-s', help='',
                    required=True)
parser.add_argument('--class_num', '-c', help='',
                    required=True)
parser.add_argument('--method', '-med', help='',
                    required=True)
parser.add_argument('--nt', '-nt', help='',
                    default = '1')
parser.add_argument('--pre', '-pre', help='',
                    default = 'default')
parser.add_argument('--treefile', '-te', help='',
                    default = '')
parser.add_argument('--org', '-org', help='',
                    default = '')
args = parser.parse_args()


if __name__ == '__main__':
    try:
        init_mf(args.iqtree_loc, args.file_name, args.class_num, args.method, args.nt, args.pre, args.treefile, args.org)
    except Exception as e:
        print(e)
