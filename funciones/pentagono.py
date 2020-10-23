import math


def calcular_apotema(lados, longitud):
    return longitud / (2 * math.tan((180 / lados) * math.pi / 180))


def calcular_area_pentagono(lado):
    perimetro = lado * 5
    apotema = calcular_apotema(5, lado)
    area = (perimetro * apotema)/2
    return area

