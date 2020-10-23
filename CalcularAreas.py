from funciones import cuadrado, circulo, pentagono, triangulo, trapezio


def menu():
    print("Selecciona una opción")
    print("1 - Calular area de un cuadrado")
    print("2 - Calular area de un circulo")
    print("3 - Calular area de un triangulo")
    print("4 - Calular area de un trapezio")
    print("5 - Calular area de un pentagono")
    print("0 - salir")
    print("")


while True:
    menu()

    opcion = input("Elige una opcion: ")

    if opcion == "1":
        lado = int(input("Ingrese el valor del lado: "))
        print("\n")
        area = cuadrado.Calcular_Area_Cuadrado(lado)
        print("El area del cuadrado es: ", area, "\n")
    elif opcion == "2":
        radio = int(input("Ingrese el valor del radio: "))
        print("\n")
        area = circulo.calcular_area_circulo(radio)
        print("El area del circulo es: ", area, "\n")
    elif opcion == "3":
        base = int(input("Ingrese el valor de la base: "))
        altura = int(input("Ingrese el valor de la altura: "))
        print("\n")
        area = triangulo.calcular_area_triangulo(base, altura)
        print("El area del triangulo es: ", area, "\n")
    elif opcion == "4":
        base_mayor = int(input("Ingrese el valor de la base mayor: "))
        base_menor = int(input("Ingrese el valor de la base menor: "))
        altura = int(input("Ingrese el valor de la altura: "))
        print("\n")
        area =  trapezio.area_Trapezio(base_mayor, base_menor, altura)
        print("El area del trapezio es: ", area, "\n")
    elif opcion == "5":
        lado = int(input("Ingrese el valor del lado: "))
        print("\n")
        area = pentagono.calcular_area_pentagono(lado)
        print("El area del pentagono es: ", area, "\n")
    elif opcion == "0":
        break
