/*
 Synopsis:
 
 # scalac gcd.scala
 # scala gcd 11 22 33 121

 // prints 11

*/
object gcd {
    def gcd2(a: Int, b: Int): Int = b match {
        case 0 => a
        case _ => gcd2(b, a % b)
    }

    def main(args: Array[String]) {
        try {
            val numbers = args map Integer.parseInt
            println(numbers.foldRight(0)((a, b) => gcd2(a, b)))
        } catch {
           case e: NumberFormatException => println("Not a number")
        }
    }
}
