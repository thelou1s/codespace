# global val
bar_1 = 0
 
 
def test_1():
    def foo_1():
        global bar_1  # UnboundLocalError: local variable 'bar' referenced before assignment
        bar_1 += 1
        print('foo_1(), bar_1 = ' + str(bar_1))
 
    foo_1()
    foo_1()
 
 
# nonlocal val
def test_2():
    bar_2 = 0
 
    def foo_2():
        nonlocal bar_2  # UnboundLocalError: local variable 'bar' referenced before assignment
        bar_2 += 1
        print('foo_2(), bar_2 = ' + str(bar_2))
 
    foo_2()
    foo_2()
 
 
test_1()
test_2()
 
