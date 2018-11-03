// This is the 'include file'
// Testmain.groovy will load it as an implicit class
// Each method in here will become a method on the implicit class
class sub {
    def myUtilityMethod(String msg) {
        println "myUtilityMethod running with: ${msg}"
    }
}