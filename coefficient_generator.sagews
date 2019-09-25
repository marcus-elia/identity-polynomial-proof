S.<x> = PolynomialRing(Rationals())
R.<n> = PolynomialRing(Rationals())
def get_irreducible(m, i):
    P = sum([(-1)^k*binomial(2*x, k)*(x-k)^i for k in range(m)])
    irred = P * factorial(m-1) / ((-2)^(m-1)) / (x - m) / (x - m + 1)
    for j in range(0, m):
        irred = irred / (x - j/2)
    for j in range(1, i/2 + 1):
        irred = irred * (x - j)
    return S(irred)

def get_irred_coefs_polys(i):
    deg = 3*(i/2 - 1)
    for cur_index in range(0, deg + 1):
        m = i + 1 # start m at i + 1 since the patterns seem to start there
        interpolation_points = []
        interpolation_points.append((m, get_irreducible(m, i).list()[cur_index]))
        while(S.lagrange_polynomial(interpolation_points).degree() == len(interpolation_points) - 1):
            m = m + 1
            interpolation_points.append((m, get_irreducible(m, i).list()[cur_index]))
        print(((-1)^(cur_index+i/2+1)*R.lagrange_polynomial(interpolation_points)).list())
    return

get_irred_coefs_polys(18)
