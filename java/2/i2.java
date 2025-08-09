// Base class
class Shape {
    // Method to be overridden
    public double getArea() {
        return 0.0; // Default implementation
    }
}

// Subclass
class Rectangle extends Shape {
    private final double width;
    private final double height;

    // Constructor
    public Rectangle(double width, double height) {
        this.width = width;
        this.height = height;
    }

    // Overriding getArea() method
    @Override
    public double getArea() {
        return width * height;
    }
}

// Main class to test the functionality
public class i2 {
    public static void main(String[] args) {
        Rectangle rectangle = new Rectangle(5.0, 3.0);
        System.out.println("Area of rectangle: " + rectangle.getArea());
    }
}
