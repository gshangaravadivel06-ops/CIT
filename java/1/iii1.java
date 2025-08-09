import java.util.Scanner;

public class iii1 {
    public static void main(String[] args) {
        // Prompt and read first number
        try (Scanner scanner = new Scanner(System.in)) {
            // Prompt and read first number
            System.out.print("Input first number: ");
            int firstNumber = scanner.nextInt();
            
            // Prompt and read second number
            System.out.print("Input second number: ");
            int secondNumber = scanner.nextInt();
            
            int product = firstNumber * secondNumber;
            
            // Display the result
            System.out.println(firstNumber + " x " + secondNumber + " = " + product);
        }
    }
}
