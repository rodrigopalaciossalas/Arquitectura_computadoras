from graphviz import Digraph

def draw_fibonacci_flowchart():
    dot = Digraph(comment="Fibonacci Flowchart", format="png")
    dot.attr(size='8,8')

    # Nodos
    dot.node('A', 'START', shape='ellipse', style='filled', color='purple')
    dot.node('B', 'Ingresa "n"', shape='rectangle', style='filled', color='salmon')
    dot.node('C', '$t8 <- n', shape='rectangle', style='filled', color='salmon')
    dot.node('D', '$t0 <- 0, $t1 <- 1', shape='rectangle', style='filled', color='salmon')
    dot.node('E', 'Imprime $t0', shape='rectangle', style='filled', color='salmon')
    dot.node('F', '$t2 <- $t0+$t1\n$t0 <- $t1\n$t1 <- $t2\nCounter <- Counter+1', shape='rectangle', style='filled', color='salmon')
    dot.node('G', 'Counter = n?', shape='diamond', style='filled', color='gold')
    dot.node('H', 'END', shape='ellipse', style='filled', color='lightblue')

    # Conexiones
    dot.edge('A', 'B')
    dot.edge('B', 'C')
    dot.edge('C', 'D')
    dot.edge('D', 'E')
    dot.edge('E', 'F')
    dot.edge('F', 'G')
    dot.edge('G', 'H', label="Sí")
    dot.edge('G', 'E', label="No")

    dot.render("fibonacci_flowchart", view=True)

draw_fibonacci_flowchart()
