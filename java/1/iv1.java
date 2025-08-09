import java.util.Scanner;

public class iv1{
    public static void main(String[] args) {
        // Prompt user for a number
        try (Scanner scanner = new Scanner(System.in)) {
            // Prompt user for a number
            System.out.print("Input a number: ");
            int number = scanner.nextInt();
            
            // Print multiplication table up to 10
            for (int i = 1; i <= 10; i++) {
                System.out.println(number + " x " + i + " = " + (number * i));
            }
        }
    }
}
