import sys
total = 0
for i in sys.argv:
    try:
        total += float(i)
    except:
        continue
print(total)
