// Run this file

// evaluate implicitly creates a class based on the filename specified
evaluate(new File("./sub.groovy"))
// Safer to use 'def' here as Groovy seems fussy about whether the filename (and therefore implicit class name) has a capital first letter
def tu = new Testutils()
tu.myUtilityMethod("hello world")