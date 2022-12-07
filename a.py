f = open("a.sql", "r")
w = open("r.sql", "w")
list = []
for line in f:
    print(line)
    newl = line[:-3] + "'" + line[-3:]
    list.append(newl)
    w.write(newl)