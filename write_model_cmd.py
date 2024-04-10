import argparse

def write_para(filename):
    iqtree_file = filename + '.iqtree'
    
    cmd = 'MIX"{GTR{1/1/1/1/1}+FO'
    
    with open(iqtree_file) as b:
        for line in b.readlines():
            if 'Model of substitution:' in line:
                class_num = 1
                break
            if 'Mixture model of substitution:' in line:
                class_num = line.count(',') + 1
                break
            
    if class_num == 1:
        cmd = cmd + '{'
        with open(iqtree_file) as b:
            for line in b.readlines():
                if '  pi(A) =' in line:
                    cmd = cmd + str(line.split()[-1])
                if '  pi(C) =' in line:
                    cmd = cmd + str(line.split()[-1])
                if '  pi(G) =' in line:
                    cmd = cmd + str(line.split()[-1])
                if '  pi(T) =' in line:
                    cmd = cmd + str(line.split()[-1])
                    
        cmd = cmd + '}:1:0.5,GTR{1/1/1/1/1}+FO:1:0.5}"'
    else:
        model_list = [[0] * class_num for _ in range(2)]
        for i in range(class_num):
            with open(iqtree_file) as b:
                for line in b.readlines():
                    if '   ' + str(i+1) + '  ' in line:
                        model_list[0][i] = float(line.split()[3])
                        model_list[1][i] = line.split()[4].split('FO')[1].replace(',','/')
    
        paired = list(zip(*model_list))
        sorted_paired = sorted(paired, key=lambda x: x[0])
        sorted_list = list(zip(*sorted_paired))
    
        for j in range(class_num):
            if j != class_num -1:
                cmd = cmd + str(sorted_list[1][j]) + ':1:' + str(sorted_list[0][j]) + ',GTR{1/1/1/1/1}+FO'
            else:
                cmd = cmd + str(sorted_list[1][j]) + ':1:' + str(sorted_list[0][j]/2) + ',GTR{1/1/1/1/1}+FO:1:' + str(sorted_list[0][j]/2) + '}"'
    
    return cmd

parser = argparse.ArgumentParser(description='')
parser.add_argument('--filename', '-f', help='', 
                    required=True)
args = parser.parse_args()

if __name__ == '__main__':
    try:
        n = write_para(args.filename)
        print(n)
    except Exception as e:
        print(e)


