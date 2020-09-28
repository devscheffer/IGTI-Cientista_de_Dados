def f(n):
    print(f'f({n})')
    if n== 1 or n == 2:
        print(f're:{1}')
        return 1
    if n == 0:
        print(f're:{0}')
        return 0
    else:
        return f(n-1) + f(n-2)

f(6)
print(f(6))
