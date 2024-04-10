import math



def bic(lnl, para):
    sites = 6000
    bic = para*math.log(sites) - 2*lnl
    
    return bic