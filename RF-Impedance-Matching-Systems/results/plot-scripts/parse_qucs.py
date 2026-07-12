import re

def parse_dat(path, dep_name):
    with open(path, 'r', errors='ignore') as f:
        content = f.read()
    # get indep frequency block
    freq_block = re.search(r'<indep frequency \d+>(.*?)</indep>', content, re.S).group(1)
    freqs = [float(x) for x in freq_block.split()]
    dep_block = re.search(rf'<dep {re.escape(dep_name)} frequency>(.*?)</dep>', content, re.S).group(1)
    vals = [float(x) for x in dep_block.split()]
    return freqs, vals

if __name__ == "__main__":
    f, v = parse_dat("/home/claude/rf_repo/RF-Impedance-Matching-Systems/qucs/01_Open_Circuit_Stub/StubOC.dat", "dBS11")
    print(len(f), len(v), v[:5], min(v))
