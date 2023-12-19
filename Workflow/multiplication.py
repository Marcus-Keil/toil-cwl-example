import sys
total = 1
for i in sys.argv:
    try:
        total *= float(i)
    except:
        continue
print(total)
