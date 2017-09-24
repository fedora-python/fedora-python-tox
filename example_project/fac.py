def fac(n):
    if not isinstance(n, int) or n < 0:
        raise ValueError('n must be non-negative integer')

    if n == 0:
        return 1
    else:
        return n * fac(n - 1)
