public class i3 {
    public static void main(String[] args) {
        try {
            // Manually throw an exception
            throw new Exception("This is a manually thrown exception.");
        } catch (Exception e) {
            System.out.println("Caught Exception: " + e.getMessage());
        }
    }
}
