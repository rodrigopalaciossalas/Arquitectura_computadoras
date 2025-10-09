from graphviz import Digraph

def draw_nested_loops_flowchart():
    dot = Digraph(comment="Nested Loops Flowchart", format="png")
    dot.attr(size='8,8')

    # Nodos
    dot.node('A', 'START', shape='ellipse', style='filled', color='purple')
    dot.node('B', 'Inicialización de registros y variables', shape='diamond', style='filled', color='salmon')
    dot.node('C', 'Incremento de $s0', shape='rectangle', style='filled', color='salmon')
    dot.node('D', 'Comprobación de condición finalización (for1)', shape='diamond', style='filled', color='salmon')
    dot.node('E', 'Procesamiento dentro de for1', shape='rectangle', style='filled', color='salmon')
    dot.node('F', 'Actualización de vec[p] y vec[i]', shape='rectangle', style='filled', color='salmon')
    dot.node('G', 'Salida de print si se cumple condición', shape='parallelogram', style='filled', color='pink')
    dot.node('H', 'Impresión de vec[s2]', shape='rectangle', style='filled', color='salmon')
    dot.node('I', 'Impresión de un guion', shape='rectangle', style='filled', color='salmon')
    dot.node('J', 'Impresión de $s2', shape='rectangle', style='filled', color='salmon')
    dot.node('K', 'Comprobación de condición finalización', shape='diamond', style='filled', color='salmon')
    dot.node('L', 'Incremento de $s7', shape='rectangle', style='filled', color='salmon')
    dot.node('M', 'Comprobación condición finalización (for2)', shape='diamond', style='filled', color='salmon')
    dot.node('N', 'Procesamiento dentro de for2', shape='rectangle', style='filled', color='salmon')
    dot.node('O', 'Comparación y actualización de aux y p', shape='rectangle', style='filled', color='salmon')
    dot.node('P', 'END', shape='ellipse', style='filled', color='lightblue')

    # Conexiones
    dot.edge('A', 'B')
    dot.edge('B', 'C')
    dot.edge('C', 'D')
    dot.edge('D', 'E')
    dot.edge('E', 'F')
    dot.edge('F', 'G')
    dot.edge('G', 'H')
    dot.edge('H', 'I')
    dot.edge('I', 'J')
    dot.edge('J', 'K')
    dot.edge('K', 'P')

    # Bucle for2
    dot.edge('E', 'L')
    dot.edge('L', 'M')
    dot.edge('M', 'N')
    dot.edge('N', 'O')
    dot.edge('O', 'E')

    dot.render("nested_loops_flowchart", view=True)

draw_nested_loops_flowchart()
